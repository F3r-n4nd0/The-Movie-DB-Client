//
//  PageMovies.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/23/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation

struct PageMovies: Equatable {

    public var number: Int
    public var type: ListMoviesType
    public var source: ListMoviesSourceData
    public var movies: [Movie]

}
