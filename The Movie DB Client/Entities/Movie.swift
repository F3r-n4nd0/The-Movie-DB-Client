//
//  Movie.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/19/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation

struct Movie: Equatable {

    public var _id: Int
    
    public var posterPath: URL

    public var overview: String

    public var releaseDate: Date

    public var originalTitle: String

    public var originalLanguage: String?

    public var title: String
    
    public var voteCount: Int
    
    public var voteAverage: Float

}
