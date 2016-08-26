//
//  Movie.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/20/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import ObjectMapper

public class Movie: Mappable {
    var traktId: Int?
    var title: String?
    var year: Int?
    var overview: String?
    var rating: Float?
    var votes: Int?
    var certification: String?
    var posterImgUrlString: String?
    
    // MARK: - Protocol Conformance
    
    // MARK: Mappable
    
    public required init?(_ map: Map) {}
    
    public func mapping(map: Map) {
        traktId                 <- map["ids.trakt"]
        title                   <- map["title"]
        overview                <- map["overview"]
        year                    <- map["year"]
        rating                  <- map["rating"]
        votes                   <- map["votes"]
        certification           <- map["certification"]
        posterImgUrlString      <- map["images.poster.thumb"]
    }
}
