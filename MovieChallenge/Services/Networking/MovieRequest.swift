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
            return ["extended": "full,images"]
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
}


