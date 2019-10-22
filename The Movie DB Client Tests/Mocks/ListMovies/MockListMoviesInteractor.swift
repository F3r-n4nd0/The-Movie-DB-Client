//
//  MockListMoviesInteractor.swift
//  The Movie DB Client Tests
//
//  Created by Fernando Luna on 10/19/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

@testable import The_Movie_DB_Client

import Foundation
import Viperit
import RxSwift

final class MockListMoviesInteractor: Interactor {

    var error: ListMoviesError?
    var dataMovies: [Movie]?

}

extension MockListMoviesInteractor: ListMoviesInteractorApi {

    var session: URLSession {
        get {
            return URLSession.shared
        }
    }

    func getPopularMovies() -> Observable<[Movie]> {
        return Observable<[Movie]>.create { [unowned self] (observer) -> Disposable in
            if let error = self.error {
                observer.onError(error)
            }
            if let data = self.dataMovies {
                 observer.onNext(data)
            }
            return Disposables.create {}
        }
    }
    
}
