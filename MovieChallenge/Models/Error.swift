//
//  Error.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/25/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Foundation

public enum Error: ErrorType {
    case Custom(String)
}

extension Error {
    var description: String {
        switch self {
        case .Custom(let errorMessage):
            return errorMessage
        }
    }
}