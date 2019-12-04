//
//  ListMoviesRepository.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/22/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import RealmSwift

class ListMoviesRepository {
    
    private func storeRealmPageMovies(pageMovies: PageMovies) {
        let pageMoviesRepo = PageMoviesRepository()
        let id = generateId(number: pageMovies.number, type: pageMovies.type)
        pageMoviesRepo._id = id
        pageMoviesRepo.number = pageMovies.number
        pageMoviesRepo.type = pageMovies.type.rawValue
        pageMoviesRepo.updateDate = Date()
        for movie in pageMovies.movies {
            let movieRepository = MovieRepository()
            movieRepository._id = movie._id
            movieRepository.posterPath = movie.posterPath.absoluteString
            movieRepository.overview = movie.overview
            movieRepository.releaseDate = movie.releaseDate
            movieRepository.originalTitle = movie.originalTitle
            movieRepository.originalLanguage = movie.originalLanguage
            movieRepository.title = movie.title
            movieRepository.voteCount = movie.voteCount
            movieRepository.voteAverage = movie.voteAverage
            movieRepository.updateDate = Date()
            pageMoviesRepo.movies.append(movieRepository)
        }
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(pageMoviesRepo, update: .modified)
        try! realm.commitWrite()
    }
    
    private func getRealmPageMovies(page: Int, type: ListMoviesType) -> PageMovies? {
        let id = generateId(number: page, type: type)
        let realm = try! Realm()
        
        let responsePage = realm.objects(PageMoviesRepository.self).filter("_id = %@", id).first
        guard let response = responsePage else {
            return nil
        }
        var movies: [Movie] = []
        for movieRepository in response.movies {
            let movie = Movie(_id: movieRepository._id,
                              posterPath: URL(string: movieRepository.posterPath)!,
                              overview: movieRepository.overview,
                              releaseDate: movieRepository.releaseDate,
                              originalTitle: movieRepository.originalTitle,
                              originalLanguage: movieRepository.originalLanguage,
                              title: movieRepository.title,
                              voteCount: movieRepository.voteCount,
                              voteAverage: movieRepository.voteAverage)
            movies.append(movie)
        }
        let pageMovies = PageMovies(number: response.number,
                                    type: ListMoviesType(rawValue: response.type) ?? .Popular ,
                                    source: .cache,
                                    movies: movies)
        return pageMovies
    }
    
    
    private func generateId(number: Int?, type: ListMoviesType) -> String {
        return "\(number ?? 0)-\(type)"
    }
}

extension ListMoviesRepository: ListMoviesRepositoryApi {
    
    func storePageMovies(pageMovies: PageMovies) {
        self.storeRealmPageMovies(pageMovies: pageMovies)
    }
    
    func getPageMovies(page: Int, type: ListMoviesType) -> PageMovies? {
        return self.getRealmPageMovies(page: page, type: type)
    }
    
}
