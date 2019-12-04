//
//  ListMoviesPresenter.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/19/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import Viperit
import RxSwift

// MARK: - ListMoviesPresenter Class
final class ListMoviesPresenter: Presenter {
    
    private let _publishUpdatedMovies = PublishSubject<[Movie]>()
    private let disposeBag = DisposeBag()
    
    private var page: Int = 1
    private var type: ListMoviesType = .Popular
    
    private func notifyMoviesLoaded(pageMovies: PageMovies) {
        let movies = pageMovies.movies
        page = pageMovies.number
        _publishUpdatedMovies.onNext(movies)
    }
    
    private func processLoadMovies(page: Int, type: ListMoviesType) {
        interactor.requestMovies(page: page, type: type)
            .subscribe(
                onNext: { [unowned self]  pageMovies in
                    self.notifyMoviesLoaded(pageMovies: pageMovies)
                },
                onError: { [unowned self] error in
                    self._publishUpdatedMovies.onError(error)
                },
                onCompleted: {
                    self._publishUpdatedMovies.onCompleted()
            }
        ).disposed(by: disposeBag)
    }
    
}

// MARK: - ListMoviesPresenter API
extension ListMoviesPresenter: ListMoviesPresenterApi {
    
    var publishUpdatedMovies: Observable<[Movie]> {
        return _publishUpdatedMovies
    }
    
    func loadPopularMovies() {
        page = 1
        type = .Popular
        processLoadMovies(page: page, type: type)
    }
    
    func loadNextPage() {
        let nextPage = page + 1
        processLoadMovies(page: nextPage, type: type)
    }
    
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
