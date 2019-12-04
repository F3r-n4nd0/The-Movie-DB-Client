//
//  ListMoviesPresenterTests.swift
//  The Movie DB Client Tests
//
//  Created by Fernando Luna on 10/19/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

@testable import The_Movie_DB_Client

import XCTest
import RxSwift

class ListMoviesPresenterTests: XCTestCase {
    
    var mockDataPage = PageMovies(number: 1,
                                  type: .Popular,
                                  source: .api,
                                  movies:
        [
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
    )
    
    var listMoviesPresenter: ListMoviesPresenter!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        listMoviesPresenter = ListMoviesPresenter()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        listMoviesPresenter = nil
    }
    
    func testGetPopularMovies_whenSuccess_notifyUpdatedToView() {
        let mockInteractor = MockListMoviesInteractor(data: mockDataPage, error: nil)
        listMoviesPresenter._interactor = mockInteractor
        
        var responseError: [Error] = []
        var responseData: [[Movie]] = []
        let expectation = XCTestExpectation(description: "process load movies")
        listMoviesPresenter.publishUpdatedMovies
            .subscribe(onNext: { movies in
                responseData.append(movies)
                expectation.fulfill()
            }, onError: { error in
                responseError.append(error)
                expectation.fulfill()
            }
        ).disposed(by: disposeBag)
        listMoviesPresenter.loadPopularMovies()
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(responseError.count, 0)
        XCTAssertEqual(responseData.count, 1)
        XCTAssertEqual(responseData, [mockDataPage.movies])
    }
    
    func testGetPopularMovies_whenThrowError_notifyErrorToView() {
        let mockInteractor = MockListMoviesInteractor(data: nil, error: .internetConnectionProblem)
        listMoviesPresenter._interactor = mockInteractor
        
        var responseError: [Error] = []
        var responseData: [[Movie]] = []
        let expectation = XCTestExpectation(description: "process load movies")
        listMoviesPresenter.publishUpdatedMovies
            .subscribe(onNext: { movies in
                responseData.append(movies)
                expectation.fulfill()
            }, onError: { error in
                responseError.append(error)
                expectation.fulfill()
            }
        ).disposed(by: disposeBag)
        listMoviesPresenter.loadPopularMovies()
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(responseError.count, 1)
        XCTAssertEqual(responseData.count, 0)
    }
    
    func testGetMovies_whenGetNextPage_sendNotifyView() {
        let mockInteractor = MockListMoviesInteractor(data: nil, error: ListMoviesError.internetConnectionProblem)
        listMoviesPresenter._interactor = mockInteractor
        
        var responseError: [Error] = []
        var responseData: [[Movie]] = []
        let expectation = XCTestExpectation(description: "process load movies")
        listMoviesPresenter.publishUpdatedMovies
            .subscribe(onNext: { movies in
                responseData.append(movies)
            }, onError: { error in
                responseError.append(error)
            }, onCompleted: {
                expectation.fulfill()
            }
        ).disposed(by: disposeBag)
        listMoviesPresenter.loadPopularMovies()
        listMoviesPresenter.loadNextPage()
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(responseError.count, 2)
        XCTAssertEqual(responseData.count, 0)
        XCTAssertEqual(responseData, [mockDataPage.movies])
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
