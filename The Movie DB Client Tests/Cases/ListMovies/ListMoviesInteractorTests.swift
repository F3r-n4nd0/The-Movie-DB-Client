//
//  ListMoviesInteractorTests.swift
//  The Movie DB Client Tests
//
//  Created by Fernando Luna on 10/20/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

@testable import The_Movie_DB_Client

import XCTest
import RxSwift

class ListMoviesInteractorTests: XCTestCase {
    
    var listMoviesInteractor: ListMoviesInteractor!
    var disposeBag: DisposeBag!
    
    var mockData = [
        Movie(_id: 475557,
              posterPath: MovieListObject.decodePosterPath(path: "/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg"),
              overview: "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.",
              releaseDate: MovieListObject.decodeReleaseDate(date: "1970-01-01"),
              originalTitle: "Joker",
              originalLanguage: "en",
              title: "Joker",
              voteCount: 3577,
              voteAverage: 8.6)
    ]
    
    override func setUp() {
        listMoviesInteractor = ListMoviesInteractor()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        listMoviesInteractor = nil
    }
    
    
    func testGetPopularMovies_fromAPI_notificateMoviesToThePresenter() {
        let expectation = XCTestExpectation(description: "presenter get update notification from the interactor")
        var responseError: Error?
        var responseData: [Movie]?
        listMoviesInteractor.listMovieAPiClient = MockListMoviesAPIClient(response: mockData, error: nil)
        listMoviesInteractor.getPopularMovies().subscribe(onNext: { movies in
            responseData = movies
            expectation.fulfill()
        }, onError: { (error) in
            responseError = error
            expectation.fulfill()
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseData)
        XCTAssertEqual(mockData, responseData)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
