//
//  NSMutableURLRequest+Extension.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/20/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Foundation

extension NSMutableURLRequest {
    func requestByAddingExtraHeaders(headers: [String: String]?) {
        guard let headers = headers else { return }
        
        for value in headers {
            self.addValue(value.1, forHTTPHeaderField: value.0)
        }
    }
}
