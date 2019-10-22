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
    
    private let observableMovies = PublishSubject<[Movie]>()
    private let disposeBag = DisposeBag()
    
    override func viewHasAppeared() {
        super.viewHasAppeared()
        loadPopularMovies()
    }
    
    private func updatedMovies(movies: [Movie]) {
        observableMovies.onNext(movies)
    }
    
    private func loadPopularMovies() {
        interactor.getPopularMovies().subscribe(
            onNext: { [unowned self]  movies in
                self.updatedMovies(movies: movies) },
            onError: { [unowned self] error in
                self.observableMovies.onError(error)
        }).disposed(by: disposeBag)
    }

}

// MARK: - ListMoviesPresenter API
extension ListMoviesPresenter: ListMoviesPresenterApi {
    
    var publishUpdatedMovies: Observable<[Movie]> {
        return observableMovies
    }
    
    func showPopularMovies() {
        self.loadPopularMovies()
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
