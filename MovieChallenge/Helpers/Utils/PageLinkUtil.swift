//
//  PageLinkUtil.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/22/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import UIKit

public typealias PageLinks = (first: Int?, last: Int?, next: Int?, previous: Int?)

extension NSHTTPURLResponse {
    private enum Delim: String {
        case Links = ","
        case LinkParam = ";"
    }
    
    private enum Header: String {
        case Link = "Link"
        case Next = "X-Next"
        case Last = "X-Last"
    }
    
    enum Meta: String {
        case Rel = "rel"
        case Last = "last"
        case Next = "next"
        case First = "first"
        case Previous = "previous"
    }
    
    func findPageLinks() -> PageLinks {
        var first: Int?
        var last: Int?
        var next: Int?
        var previous: Int?
        
        let headers = self.allHeaderFields
        
        if let linkHeader = headers[Header.Link.rawValue] as? String {
            let cleanLinkHeader = linkHeader.stringByReplacingOccurrencesOfString(" ", withString: "")
            let links = cleanLinkHeader.componentsSeparatedByString(Delim.Links.rawValue)
            
            for link in links {
                let segments = link.componentsSeparatedByString(Delim.LinkParam.rawValue)
                
                // If there is no link inside <> then continue to the other link
                if segments.count < 2 {
                    continue
                }
                var linkPart = segments[0]
                
                // Check if we have the required format
                if !linkPart.hasPrefix("<") || !linkPart.hasSuffix(">")  {
                    continue
                }
                
                let startIndex = linkPart.startIndex.advancedBy(1)
                let endIndex = linkPart.endIndex.advancedBy(-2)
                let range = startIndex...endIndex
                linkPart = linkPart.substringWithRange(range)
                
                for i in 1..<segments.count {
                    // Clean string
                    let relString = segments[i].stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                    let rel = relString.componentsSeparatedByString("=")
                    
                    if rel.count < 2 || Meta.Rel.rawValue != rel[0] {
                        continue
                    }
                    
                    var relValue = rel[1]
                    if relValue.hasPrefix("\"") && relValue.hasSuffix("\"") {
                        let startIndex = relValue.startIndex.advancedBy(1)
                        let endIndex = relValue.endIndex.advancedBy(-2)
                        let range = startIndex...endIndex
                        relValue = relValue.substringWithRange(range)
                    }
                    
                    switch relValue {
                    case Meta.First.rawValue:
                        first = Int(linkPart)
                        break
                    case Meta.Last.rawValue:
                        last = Int(linkPart)
                        break
                    case Meta.Previous.rawValue:
                        previous = Int(linkPart)
                        break
                    case Meta.Next.rawValue:
                        next = Int(linkPart)
                        break
                    default: break
                    }
                }
            }
        }
        
        return (first, last, next, previous)
    }
}