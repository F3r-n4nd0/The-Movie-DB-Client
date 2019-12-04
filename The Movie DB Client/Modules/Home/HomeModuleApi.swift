//
//  HomeModuleApi.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/22/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import Viperit

//MARK: - HomeRouter API
protocol HomeRouterApi: RouterProtocol {
    func goMovies()
}

//MARK: - HomeView API
protocol HomeViewApi: UserInterfaceProtocol {
}

//MARK: - HomePresenter API
protocol HomePresenterApi: PresenterProtocol {
}

//MARK: - HomeInteractor API
protocol HomeInteractorApi: InteractorProtocol {
}
