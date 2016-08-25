//
//  PaginationResponse.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/25/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Foundation
import ObjectMapper

struct PaginationResponse<E: Mappable>: PaginationResponseType {
    typealias Element = E
    
    let elements: [Element]
    
    let previousPage: Int?
    let nextPage: Int?
}
