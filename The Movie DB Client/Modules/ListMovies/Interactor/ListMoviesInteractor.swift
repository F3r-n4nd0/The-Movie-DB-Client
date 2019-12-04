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
    var listMovieRepository: ListMoviesRepositoryApi = ListMoviesRepository()
    
    private func loadCacheMovies(page: Int, type: ListMoviesType, handle: @escaping (PageMovies)->Void) -> Void {
        guard let pageMovies = self.listMovieRepository.getPageMovies(page: page, type: type) else {
            return
        }
        handle(pageMovies)
    }
    
    private func requestAPIMovies(page: Int, type: ListMoviesType, handler: @escaping (Result<PageMovies,Error>)->Void) -> URLSessionDataTask? {
        return self.listMovieAPiClient.requestPageMovies(page: page, type: type)
        { [unowned self] result in
            switch result {
            case .success(let pageMovies):
                self.storeMoviesToCache(pageMovies: pageMovies)
                handler(.success(pageMovies))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    private func storeMoviesToCache(pageMovies: PageMovies) {
        self.listMovieRepository.storePageMovies(pageMovies: pageMovies)
    }
    
}

// MARK: - ListMoviesInteractor API
extension ListMoviesInteractor: ListMoviesInteractorApi {
    
    func requestMovies(page: Int, type: ListMoviesType) -> Observable<PageMovies> {
        return Observable<PageMovies>.create { [unowned self] observer in
            self.loadCacheMovies(page: page, type: type) { pageMovies in
                observer.onNext(pageMovies)
            }
            let task = self.requestAPIMovies(page: page, type: type) { result in
                switch result {
                case .success(let pageMovies):
                    observer.onNext(pageMovies)
                    observer.onCompleted()
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
