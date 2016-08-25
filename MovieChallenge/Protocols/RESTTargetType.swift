//
//  MovieRequestType.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/25/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

protocol RESTTargetType: URLRequestConvertible {
    associatedtype Response
    var baseUrl: NSURL { get }
    var path: String { get }
    var method: Alamofire.Method { get }
    var parameters: [String: AnyObject]? { get }
    var parameterEncoding: Alamofire.ParameterEncoding { get }
    var extraHeaders: [String: String]? { get }
    var URLRequest: NSMutableURLRequest { get }
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response
}

extension RESTTargetType {
    var baseUrl: NSURL { return NSURL(string: NetworkService.baseURLString)! }
    var parameters: [String: AnyObject]? { return nil }
    var parameterEncoding: Alamofire.ParameterEncoding { return .URL }
    var extraHeaders: [String: String]? { return nil }
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: "\(baseUrl.absoluteString)\(path)")!
        let mutableURLRequest = NSMutableURLRequest(URL: URL)
        mutableURLRequest.HTTPMethod = method.rawValue
        mutableURLRequest.requestByAddingExtraHeaders(extraHeaders)
        let encoding = parameterEncoding
        
        return encoding.encode(mutableURLRequest, parameters: parameters).0;
    }
}

extension RESTTargetType where Response: Mappable {
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        return try GoditMapper<Response>.map(object)
    }
}

extension RESTTargetType where Response: PaginationResponseType {
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) throws -> Response {
        let pageLinks = URLResponse.findPageLinks()
        let elements = try GoditMapper<Response.Element>.mapArray(object)
        
        return Response(elements: elements, previousPage: pageLinks.previous, nextPage: pageLinks.next)
    }
}