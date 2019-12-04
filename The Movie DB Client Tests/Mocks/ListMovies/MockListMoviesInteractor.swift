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
    var data: PageMovies?
    
    init(data: PageMovies?, error: ListMoviesError?) {
        self.data = data
        self.error = error
    }
    
    required init() {
    }
    
}

extension MockListMoviesInteractor: ListMoviesInteractorApi {
    
    func requestMovies(page: Int, type: ListMoviesType) -> Observable<PageMovies> {
        return Observable<PageMovies>
                   .create { [unowned self] (observer) -> Disposable in
                       if let error = self.error {
                           observer.onError(error)
                       }
                       if let data = self.data {
                           observer.onNext(data)
                       }
                       return Disposables.create {}
               }
    }
 
}
