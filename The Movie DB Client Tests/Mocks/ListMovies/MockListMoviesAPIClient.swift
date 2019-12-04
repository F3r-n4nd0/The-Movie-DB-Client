//
//  MockListMoviesAPIClient.swift
//  The Movie DB Client Tests
//
//  Created by Fernando Luna on 10/22/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

@testable import The_Movie_DB_Client

import Foundation

final class MockListMoviesAPIClient {
    
    private var response: PageMovies?
    private var error: Error?
    
    init(response: PageMovies?, error: Error?) {
        self.response = response
        self.error = error
    }
    
}

extension MockListMoviesAPIClient: ListMoviesAPIClientApi {
    
    func requestPageMovies(page: Int, type: ListMoviesType, handler: @escaping (Result<PageMovies, Error>) -> Void) -> URLSessionDataTask? {
        if let error = self.error {
            handler(.failure(error))
        }
        if let data = self.response {
            handler(.success(data))
        }
        return nil
    }
    
}
