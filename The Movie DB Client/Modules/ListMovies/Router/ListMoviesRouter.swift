//
//  ListMoviesRouter.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/19/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import Viperit

// MARK: - ListMoviesRouter class
final class ListMoviesRouter: Router {
}

// MARK: - ListMoviesRouter API
extension ListMoviesRouter: ListMoviesRouterApi {
}

// MARK: - ListMovies Viper Components
private extension ListMoviesRouter {
    var presenter: ListMoviesPresenterApi {
        return _presenter as! ListMoviesPresenterApi
    }
}
