//
//  PaginationRequestType.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/25/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Foundation

protocol PaginationRequestType: RESTTargetType {
    associatedtype Response: PaginationResponseType
    var page: Int { get }
    
    func requestWithPage(page: Int) -> Self
    func requestWithQuery(query: String) -> Self
}