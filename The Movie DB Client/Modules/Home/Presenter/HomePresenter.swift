//
//  HomePresenter.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/22/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import Viperit

// MARK: - HomePresenter Class
final class HomePresenter: Presenter {
    override func viewHasLoaded() {
        router.goMovies()
    }
}

// MARK: - HomePresenter API
extension HomePresenter: HomePresenterApi {
}

// MARK: - Home Viper Components
private extension HomePresenter {
    var view: HomeViewApi {
        return _view as! HomeViewApi
    }
    var interactor: HomeInteractorApi {
        return _interactor as! HomeInteractorApi
    }
    var router: HomeRouterApi {
        return _router as! HomeRouterApi
    }
}
