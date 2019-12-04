//
//  ListMoviesAPiClient.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/21/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation

class ListMoviesAPiClient {
    
    var serviceLayer: ServiceLayer = ServiceLayer(session: URLSession.shared)
    
    private func requestPopularMovies(page: Int, handler: @escaping (Result<PageMovies, Error>) -> Void) -> URLSessionDataTask? {
        return serviceLayer.request(router: RouterAPI.getPopularMovies(page: page))
        { [unowned self] (result: Result<InlineResponse200, Error>) in
            switch result {
            case .success(let responseRequest):
                let pageMovie = self.mapResponse(response: responseRequest, type: .Popular)
                handler(.success(pageMovie))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    private func mapResponse(response: InlineResponse200, type: ListMoviesType) -> PageMovies {
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
        return PageMovies(number: response.page ?? 1,
                          type: type,
                          source: .api,
                          movies: movies ?? [])
    }
    
}

extension ListMoviesAPiClient: ListMoviesAPIClientApi {

    func requestPageMovies(page: Int, type: ListMoviesType, handler: @escaping (Result<PageMovies, Error>) -> Void) -> URLSessionDataTask? {
        switch type {
        case .Popular:
            return requestPopularMovies(page: page, handler: handler)
        }
    }
    
}
