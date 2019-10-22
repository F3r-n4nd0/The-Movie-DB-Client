//
//  ListMoviesInteractor.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/19/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import Viperit
import RxSwift

// MARK: - ListMoviesInteractor Class
final class ListMoviesInteractor: Interactor {
    var listMovieAPiClient: ListMoviesAPIClientApi = ListMoviesAPiClient()
}

// MARK: - ListMoviesInteractor API
extension ListMoviesInteractor: ListMoviesInteractorApi {

    func getPopularMovies() -> Observable<[Movie]> {
        return Observable<[Movie]>.create { [unowned self] observer in
            let task = self.listMovieAPiClient.requestListPopularMovies(page: 1) { result in
                switch result {
                case .success(let movies):
                    observer.onNext(movies)
                case .failure(let error):
                     observer.onError(error)
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
}

// MARK: - Interactor Viper Components Api
private extension ListMoviesInteractor {
    
    var presenter: ListMoviesPresenterApi {
        return _presenter as! ListMoviesPresenterApi
    }
    
}
