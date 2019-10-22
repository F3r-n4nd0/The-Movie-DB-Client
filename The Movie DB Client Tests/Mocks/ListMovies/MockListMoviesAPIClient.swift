//
//  MockListMoviesAPIClient.swift
//  The Movie DB Client Tests
//
//  Created by Fernando Luna on 10/22/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

@testable import The_Movie_DB_Client

import Foundation

final class MockListMoviesAPIClient: ListMoviesAPIClientApi {
    
    private var response: [Movie]?
    private var error: Error?
    
    init(response: [Movie]?, error: Error?) {
        self.response = response
        self.error = error
    }
    
    func requestListPopularMovies(page: Int, reponse: @escaping (Result<[Movie], Error>) -> Void) -> URLSessionDataTask? {
        if let error = self.error {
            reponse(.failure(error))
        }
        if let data = self.response {
            reponse(.success(data))
        }
        
        return nil
    }
    
}
