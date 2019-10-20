//
//  ListMoviesPresenter.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/19/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import Viperit

// MARK: - ListMoviesPresenter Class
final class ListMoviesPresenter: Presenter {
}

// MARK: - ListMoviesPresenter API
extension ListMoviesPresenter: ListMoviesPresenterApi {
}

// MARK: - ListMovies Viper Components
private extension ListMoviesPresenter {
    var view: ListMoviesViewApi {
        return _view as! ListMoviesViewApi
    }
    var interactor: ListMoviesInteractorApi {
        return _interactor as! ListMoviesInteractorApi
    }
    var router: ListMoviesRouterApi {
        return _router as! ListMoviesRouterApi
    }
}
