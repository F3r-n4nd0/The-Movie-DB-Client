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
    func loadPopularMovies() -> Void
    func loadNextPage() -> Void
}

//MARK: - ListMoviesInteractor API
protocol ListMoviesInteractorApi: InteractorProtocol {
    func requestMovies(page: Int, type: ListMoviesType) -> Observable<PageMovies>
}

protocol ListMoviesAPIClientApi {
    func requestPageMovies(
        page: Int,
        type: ListMoviesType,
        handler: @escaping (Result<PageMovies,Error>) -> Void
    ) -> URLSessionDataTask?
}

protocol ListMoviesRepositoryApi  {
    func storePageMovies(pageMovies: PageMovies) -> Void
    func getPageMovies(page: Int, type: ListMoviesType) -> PageMovies?
}
