//
//  MovieStore.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/20/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import Foundation

class MovieStore {
    // Singleton
    static let sharedInstance: MovieStore = MovieStore()
    
    // Vars
    var popularMovies: [Movie]?
    
    // MARK: - Initializers
    
    init () {
        
    }
}
