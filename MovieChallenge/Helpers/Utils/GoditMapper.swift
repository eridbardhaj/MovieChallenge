//
//  GoditMapper.swift
//  Godit
//
//  Created by Erid Bardhaj on 8/24/16.
//  Copyright © 2016 Godit. All rights reserved.
//

import Foundation
import ObjectMapper

public final class GoditMapper<E: Mappable> {
    public static func map(JSON: AnyObject?) throws -> E {
        guard let object = Mapper<E>().map(JSON) else {
            throw Error.Custom("Mapping failed")
        }
        
        return object
    }
    
    public static func mapArray(JSON: AnyObject?) throws -> [E] {
        guard let objects = Mapper<E>().mapArray(JSON) else {
            throw Error.Custom("Mapping failed")
        }
        
        return objects
    }
}