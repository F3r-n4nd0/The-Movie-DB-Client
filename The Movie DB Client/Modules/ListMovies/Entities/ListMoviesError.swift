//
//  ListMoviesError.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/20/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation

enum ListMoviesError: Error, Equatable {
    case internetConnectionProblem
    case cacheProblem
}
