    //
//  MovieRequest.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/20/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Alamofire
import ObjectMapper

struct MovieRequest {
    struct PopularList: RESTTargetType, PaginationRequestType {
        let page: Int
        
        init(page: Int = 1) {
            self.page = page
        }
        
        // MARK: - Protocol Conformance
        
        // MARK: RESTTargetType
        
        typealias Response = PaginationResponse<Movie>
        
        var path: String {
            return "/movies/popular"
        }
        
        var method: Alamofire.Method {
            return .GET
        }
        
        var parameters: [String : AnyObject]? {
            return ["extended": "full,images",
                    "page": "\(page)",
                    "limit": "10"]
        }
        
        var extraHeaders: [String : String]? {
            return ["Content-Type": "application/json",
                    "trakt-api-version": "2",
                    "trakt-api-key": Constants.API.key]
        }
        
        // MARK: PaginationRequestType
        
        func requestWithPage(page: Int) -> PopularList {
            return PopularList(page: page)
        }
        
        func requestWithQuery(query: String) -> PopularList {
            return PopularList(page: 1)
        }
    }
    
    struct Search: RESTTargetType, PaginationRequestType {
        let query: String
        let page: Int
        
        init(let query: String, page: Int = 1) {
            self.query = query
            self.page = page
        }
        
        // MARK: - Protocol Conformance
        
        // MARK: RESTTargetType
        
        typealias Response = PaginationResponse<Movie>
        
        var path: String {
            return "/search/movie"
        }
        
        var method: Alamofire.Method {
            return .GET
        }
        
        var parameters: [String : AnyObject]? {
            return ["extended": "full,images",
                    "page": "\(page)",
                    "limit": "10",
                    "query": query]
        }
        
        var extraHeaders: [String : String]? {
            return ["Content-Type": "application/json",
                    "trakt-api-version": "2",
                    "trakt-api-key": Constants.API.key]
        }
        
        // MARK: PaginationRequestType
        
        func requestWithPage(page: Int) -> Search {
            return Search(query: query, page: page)
        }
        
        func requestWithQuery(query: String) -> Search {
            return Search(query: query, page: 1)
        }
        
        // Override the default behavior as the model is not the root model
        func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
            let pageLinks = URLResponse.findPageLinks()
            
            var elements: [Response.Element] = []
            
            guard let objects = object as? NSArray else {
                throw Error.Custom("Malformed data")
            }

            for dictionary in objects {
                guard let dictionary = dictionary as? NSDictionary,
                    let movieObject = dictionary["movie"] else {
                    throw Error.Custom("No movie conforming object")
                }
                
                let element = try GoditMapper<Response.Element>.map(movieObject)
                elements.append(element)
            }
            
            return Response(elements: elements, previousPage: pageLinks.previous, nextPage: pageLinks.next)
        }
    }
}


