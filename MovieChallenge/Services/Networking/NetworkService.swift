//
//  NetworkService.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/20/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Alamofire

public protocol RESTTargetType {
    var path: String { get }
    var method: Alamofire.Method { get }
    var parameters: [String: AnyObject]? { get }
    var parameterEncoding: Alamofire.ParameterEncoding? { get }
    var extraHeaders: [String: String]? { get }
}

public struct NetworkService {
    public static let baseURLString = "https://api.trakt.tv/"
}
