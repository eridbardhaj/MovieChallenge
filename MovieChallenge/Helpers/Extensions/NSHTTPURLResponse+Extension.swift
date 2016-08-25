//
//  NSHTTPURLResponse+Extension.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/26/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import UIKit

public typealias PageLinks = (first: Int?, last: Int?, next: Int?, previous: Int?)

extension NSHTTPURLResponse {
    private enum Header: String {
        case Limit = "x-pagination-limit"
        case Page = "x-pagination-page"
        case PageCount = "x-pagination-page-count"
    }
    
    func findPageLinks() -> PageLinks {
        var first: Int? = nil
        var last: Int? = nil
        var next: Int? = nil
        var previous: Int? = nil
        
        let headers = self.allHeaderFields
        
        first = 1
        last = unwrapValue(headers[Header.PageCount.rawValue])
        if let currentPage = unwrapValue(headers[Header.Page.rawValue]) {
            if let last = last {
                next = (last - currentPage > 0) ? currentPage + 1 : nil
            }
            previous = (currentPage > 1) ? currentPage - 1 : nil
        }
        return (first, last, next, previous)
    }
    
    func unwrapValue(value: AnyObject?) -> Int? {
        guard let value = value as? String else { return nil }
        
        return Int(value)
    }
}
