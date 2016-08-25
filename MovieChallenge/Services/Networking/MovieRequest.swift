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
        
        // MARK: PaginationRequestType
        
        func requestWithPage(page: Int) -> PopularList {
            return PopularList(page: page)
        }
    }
}


