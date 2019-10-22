//
//  RouterAPI.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/21/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation

enum RouterAPI {

    case getPopularMovies(page: Int)
    case getTopRatedMovies
    case getUpcomingMovies

    var scheme: String {
        switch self {
        case .getPopularMovies,
             .getTopRatedMovies,
             .getUpcomingMovies:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .getPopularMovies,
             .getTopRatedMovies,
             .getUpcomingMovies:
            return "api.themoviedb.org"
        }
    }

    var path: String {
        switch self {
        case .getPopularMovies:
            return "/3/movie/popular"
        case .getTopRatedMovies:
            return "/3/movie/top_rated"
        case .getUpcomingMovies:
            return "/3/movie/upcoming"
        }
    }

    var parameters: [URLQueryItem] {
        let accessToken = "97360d2599c7104a1c928f13b9943aeb"
        switch self {
        case .getPopularMovies(let page):
            return [URLQueryItem(name: "page", value: "\(page)"),
                    URLQueryItem(name: "api_key", value: accessToken)]
        case .getTopRatedMovies:
            return [URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "collection_id", value: "68424466488"),
                    URLQueryItem(name: "api_key", value: accessToken)]
        case .getUpcomingMovies:
            return [URLQueryItem(name: "ids", value: "2759162243,2759143811"),
                    URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "api_key", value: accessToken)]
        }
    }
    
    var method: String {
      switch self {
        case .getPopularMovies, .getTopRatedMovies, .getUpcomingMovies:
          return "GET"
      }
    }
    
}
