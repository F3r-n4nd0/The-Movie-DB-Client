//
//  HomeRouter.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/22/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import Viperit

// MARK: - HomeRouter class
final class HomeRouter: Router {
}

// MARK: - HomeRouter API
extension HomeRouter: HomeRouterApi {
    func goMovies() {
        let home = AppModules.ListMovies.build()
        home.router.show(from: viewController, embedInNavController: false, setupData: nil)
    }
}

// MARK: - Home Viper Components
private extension HomeRouter {
    var presenter: HomePresenterApi {
        return _presenter as! HomePresenterApi
    }
}
