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
    var query: String? { get }
    
    func requestWithPage(page: Int) -> Self
}

extension PaginationRequestType {
    var query: String? {
        return nil
    }
    
    func requestWithQuery(query: String) -> Self {
        return self
    }
    
    func request(query: String, page: Int) -> Self {
        return self
    }
}