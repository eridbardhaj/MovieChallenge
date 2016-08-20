//
//  MovieRequest.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/20/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Alamofire
import ObjectMapper

enum MovieRequest: URLRequestConvertible, RESTTargetType {
    // MARK: - API methods definitions
    
    case ListPopular(limit: Int, page: Int)
    case ListSearch(query: String, limit: Int, page: Int)
    
    // MARK: - Protocol Conformance
    
    // MARK: RESTTargetType
    
    var method: Alamofire.Method {
        switch self {
        case .ListPopular(_), .ListSearch(_):
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .ListPopular(_):
            return "/movies/popular"
        case .ListSearch(_):
            return "/search/movie"
        }
    }
    
    var parameters: [String : AnyObject]? {
        switch self {
        case .ListPopular(let limit, let page):
            return ["limit": limit,
                    "page": page]
        case .ListSearch(let query, let limit, let page):
            return ["limit": limit,
                    "page": page,
                    "query": query]
        }
    }
    
    var parameterEncoding: ParameterEncoding? {
        switch self {
        case .ListPopular(_), .ListSearch(_):
            return .URL
        }
    }
    
    var extraHeaders: [String : String]? {
        return ["Content-Type": "application/json",
                "trakt-api-version": "2",
                "trakt-api-key": Constants.API.key]
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: "\(NetworkService.baseURLString)\(path)")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.requestByAddingExtraHeaders(extraHeaders)
        let encoding = parameterEncoding ?? Alamofire.ParameterEncoding.URL
        
        return encoding.encode(mutableURLRequest, parameters: parameters).0;
    }
}
