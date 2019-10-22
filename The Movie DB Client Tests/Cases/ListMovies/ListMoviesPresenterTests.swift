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
    
    var listMoviesPresenter: ListMoviesPresenterApi!
    var mockListMoviesInteractor: MockListMoviesInteractor!
    var disposeBag: DisposeBag!
    
     var mockData = [

        Movie(_id: 0, posterPath: URL(string: "http://www.google.com")!, overview: "detail", releaseDate: Date(), originalTitle: "Original Title", originalLanguage: "es", title: "Title", voteCount: 0, voteAverage: 0)
    ]
    
    override func setUp() {
        listMoviesPresenter = ListMoviesPresenter()
        mockListMoviesInteractor = MockListMoviesInteractor()
        disposeBag = DisposeBag()
        listMoviesPresenter._interactor = mockListMoviesInteractor
    }
    
    override func tearDown() {
        listMoviesPresenter._interactor = nil
        disposeBag = nil
        listMoviesPresenter = nil
        mockListMoviesInteractor = nil
    }
    
    func testGetPopularMovies_whenSuccess_notificateUpdatedToView() {
        let expectation = XCTestExpectation(description: "view get update notification from the presenter")
        var responseError: Error?
        var responseData: [Movie]?
        mockListMoviesInteractor.dataMovies = mockData
        mockListMoviesInteractor.error = nil
        listMoviesPresenter.publishUpdatedMovies
            .subscribe(onNext: { movies in
                responseData = movies
                expectation.fulfill()
            }, onError: { (error) in
                responseError = error
                expectation.fulfill()
            }).disposed(by: disposeBag)
        listMoviesPresenter.showPopularMovies()
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseData)
        XCTAssertEqual(mockData, responseData!)
    }
    
    func testGetPopularMovies_whenThrowError_notificateErrorToView() {
        let expectation = XCTestExpectation(description: "view get error notification from the presenter")
        var responseError: Error?
        var responseData: [Movie]?
        mockListMoviesInteractor.dataMovies = nil
        mockListMoviesInteractor.error = .internetConnectionProblem
        listMoviesPresenter.publishUpdatedMovies
            .subscribe(onNext: { (movies) in
                responseData = movies
                expectation.fulfill()
            }, onError: { (error) in
                responseError = error
                expectation.fulfill()
            }).disposed(by: disposeBag)
        listMoviesPresenter.showPopularMovies()
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertNil(responseData)
        XCTAssertNotNil(responseError)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
