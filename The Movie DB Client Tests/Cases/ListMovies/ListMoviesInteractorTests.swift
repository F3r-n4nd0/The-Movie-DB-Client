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
    
    private var listMoviesInteractor: ListMoviesInteractor!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        listMoviesInteractor = ListMoviesInteractor()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        disposeBag = nil
        listMoviesInteractor = nil
    }
    
    func testGetPopularMovies_fromAPI_notifyMoviesToThePresenter() {
        listMoviesInteractor.listMovieAPiClient = MockListMoviesAPIClient(response: mockDataPage, error: nil)
        let mockRepository = MockListMoviesRepository(pagesMovies: [mockDataPage])
        listMoviesInteractor.listMovieRepository = mockRepository
        
        var responseError: [Error] = []
        var responseData: [PageMovies] = []
        let expectation = XCTestExpectation(description: "process get data")
        listMoviesInteractor.requestMovies(page: 1, type: .Popular)
            .subscribe(onNext: { pageMovies in
                responseData.append(pageMovies)
            }, onError: { error in
                responseError.append(error)
            }, onCompleted: {
                expectation.fulfill()
            }
        ).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(responseError.count, 0)
        XCTAssertEqual(responseData.count, 2)
        XCTAssertEqual(responseData, [mockDataPage, mockDataPage])
    }
    
    func testGetPopularMovies_whenFailToRequest_notifyError() {
        let mockAPIClient = MockListMoviesAPIClient(response: nil,
                                                    error: ListMoviesError.internetConnectionProblem)
        listMoviesInteractor.listMovieAPiClient = mockAPIClient
        let mockRepository = MockListMoviesRepository(pagesMovies: [mockDataPage])
        listMoviesInteractor.listMovieRepository = mockRepository
        
        var responseError: [Error] = []
        var responseData: [PageMovies] = []
        let expectation = XCTestExpectation(description: "process get data")
        listMoviesInteractor.requestMovies(page: 1, type: .Popular)
            .subscribe(
                onNext: { pageMovies in
                    responseData.append(pageMovies)
            }, onError: { error in
                responseError.append(error)
                expectation.fulfill()
            }, onCompleted: {
                expectation.fulfill()
            }
        ).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(responseError.count, 1)
        XCTAssertEqual(responseData.count, 1)
        XCTAssertEqual(responseData, [mockDataPage])
    }
    
    func testGetPopularMovies_whenSetPage_notifyMovies() {
        let mockAPIClient = MockListMoviesAPIClient(response: mockDataPage, error: nil)
        listMoviesInteractor.listMovieAPiClient = mockAPIClient
        let mockRepository = MockListMoviesRepository(pagesMovies: [])
        listMoviesInteractor.listMovieRepository = mockRepository
        
        var responseError: [Error] = []
        var responseData: [PageMovies] = []
        let expectation = XCTestExpectation(description: "process get data")
        listMoviesInteractor.requestMovies(page: 1, type: .Popular)
            .subscribe(onNext: { pageMovies in
                responseData.append(pageMovies)
            }, onError: { error in
                responseError.append(error)
            }, onCompleted: {
                expectation.fulfill()
            }
        ).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(responseError.count, 0)
        XCTAssertEqual(responseData.count, 1)
        XCTAssertEqual(responseData, [mockDataPage])
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
