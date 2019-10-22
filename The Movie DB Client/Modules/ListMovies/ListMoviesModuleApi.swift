//
//  ListMoviesModuleApi.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/19/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import Viperit
import RxSwift

//MARK: - ListMoviesRouter API
protocol ListMoviesRouterApi: RouterProtocol {
}

//MARK: - ListMoviesView API
protocol ListMoviesViewApi: UserInterfaceProtocol {
}

//MARK: - ListMoviesPresenter API
protocol ListMoviesPresenterApi: PresenterProtocol {
    var publishUpdatedMovies: Observable<[Movie]> { get }
    func showPopularMovies() -> Void
}

//MARK: - ListMoviesInteractor API
protocol ListMoviesInteractorApi: InteractorProtocol {
    func getPopularMovies() -> Observable<[Movie]>
}

protocol ListMoviesAPIClientApi {
    func requestListPopularMovies(page: Int, reponse: @escaping (Result<[Movie],Error>) -> Void ) -> URLSessionDataTask?
}
