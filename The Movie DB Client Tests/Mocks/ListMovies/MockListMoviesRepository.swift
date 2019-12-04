//
//  MockListMoviesRepository.swift
//  The Movie DB Client Tests
//
//  Created by Fernando Luna on 10/22/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

@testable import The_Movie_DB_Client

import Foundation

final class MockListMoviesRepository {
    
    private var pagesMovies: [String:PageMovies] = [:]
    
    init(pagesMovies: [PageMovies]) {
        pagesMovies.forEach { pageMovies in
            let id = generateKey(pageMovies: pageMovies)
            self.pagesMovies[id] = pageMovies
        }
    }
    
    private func generateKey(pageMovies: PageMovies) -> String {
        return generateKey(page: pageMovies.number, type: pageMovies.type)
    }
    
    private func generateKey(page: Int, type: ListMoviesType) -> String {
        return "\(page)-\(type)"
    }
    
}

extension  MockListMoviesRepository: ListMoviesRepositoryApi  {
    
    func storePageMovies(pageMovies: PageMovies) {
        let id = generateKey(pageMovies: pageMovies)
        self.pagesMovies[id] = pageMovies
    }
    
    func getPageMovies(page: Int, type: ListMoviesType) -> PageMovies? {
        let id = generateKey(page: page, type: type)
        return self.pagesMovies[id]
    }
    
}
