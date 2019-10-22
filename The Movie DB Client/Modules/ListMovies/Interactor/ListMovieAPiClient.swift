//
//  ListMovieAPiClient.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/21/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation

class ListMoviesAPiClient: ListMoviesAPIClientApi {
    
    var serviceLayer: ServiceLayer = ServiceLayer(session: URLSession(configuration: .default))
    
    func requestListPopularMovies(page: Int, reponse: @escaping (Result<[Movie],Error>) -> Void ) -> URLSessionDataTask? {
        return serviceLayer.request(router: RouterAPI.getPopularMovies(page: page))
        { (result: Result<InlineResponse200, Error>) in
            switch result {
            case .success(let response):
                let movies = self.convert(response: response)
                reponse(.success(movies))
                break
            case .failure(let error): reponse(.failure(error))
            }
        }
    }
    
    private func convert(response: InlineResponse200) -> [Movie] {
        let movies = response.results?.map(
        { movieObject in
            return Movie(_id: movieObject._id ?? 0,
                         posterPath: movieObject.decodePosterPath(),
                         overview: movieObject.overview ?? "",
                         releaseDate: movieObject.decodeReleaseDate(),
                         originalTitle: movieObject.originalTitle ?? "",
                         originalLanguage: movieObject.originalLanguage,
                         title: movieObject.title ?? "",
                         voteCount: movieObject.voteCount ?? 0, voteAverage: movieObject.voteAverage ?? 0)
        })
        return movies ?? []
    }
    
}
