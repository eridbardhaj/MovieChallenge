//
//  PaginationResponseType.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/25/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Foundation
import ObjectMapper

protocol PaginationResponseType {
    associatedtype Element: Mappable
    var elements: [Element] { get }
    var previousPage: Int? { get }
    var nextPage: Int? { get }
    
    init(elements: [Element], previousPage: Int?, nextPage: Int?)
}

extension PaginationResponseType {
    var hasPreviousPage: Bool {
        return previousPage != nil
    }
    
    var hasNextPage: Bool {
        return nextPage != nil
    }
}
