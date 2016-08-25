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
    }
    
    struct SearchMovies: RESTTargetType, PaginationRequestType {
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
            return "/search/movies"
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
        
        func requestWithPage(page: Int) -> SearchMovies {
            return SearchMovies(query: query, page: page)
        }
    }
}


