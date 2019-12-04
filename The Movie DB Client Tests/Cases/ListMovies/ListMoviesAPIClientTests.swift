//
//  ListMoviesAPIClientTests.swift
//  The Movie DB Client Tests
//
//  Created by Fernando Luna on 10/22/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

@testable import The_Movie_DB_Client

import XCTest

class ListMoviesAPIClientTests: XCTestCase {
    
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
    
    
    
    var mockjsonData = """
    {
          "page": 1,
          "total_results": 1,
          "total_pages": 1,
          "results": [
            {
              "popularity": 569.937,
              "vote_count": 3577,
              "video": false,
              "poster_path": "/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
              "id": 475557,
              "adult": false,
              "backdrop_path": "/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg",
              "original_language": "en",
              "original_title": "Joker",
              "genre_ids": [
                80,
                18,
                53
              ],
              "title": "Joker",
              "vote_average": 8.6,
              "overview": "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.",
              "release_date": "1970-01-01"
            }
          ]
        }
    """.data(using: .utf8)
    
    
    private var listMovieAPIClient: ListMoviesAPiClient!
    
    override func setUp() {
        listMovieAPIClient = ListMoviesAPiClient()
    }
    
    override func tearDown() {
        listMovieAPIClient = nil
    }
    
    func testConvertAPIResponse_whenJsonResponse_convertToMovies() {
        XCTAssertNotNil(mockjsonData)
        XCTAssertNoThrow(try JSONDecoder().decode(InlineResponse200.self, from: mockjsonData!))
    }
    
    func testRequestPopularMovies_whenAPIRequest_returnPageMovies() {
        let urlMockSession = URLSessionMock(data: mockjsonData, error: nil)
        let mockServiceLayer = ServiceLayer(session: urlMockSession)
        listMovieAPIClient.serviceLayer = mockServiceLayer

        var responseError: Error?
        var responseData: PageMovies?
        let expectation = XCTestExpectation(description: "process the request")
        let task = listMovieAPIClient.requestPageMovies(page: 1, type: .Popular) { result in
            switch result {
            case .success(let movies):
                responseData = movies
            case .failure(let error):
                responseError = error
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        
        XCTAssertNotNil(task)
        XCTAssertNil(responseError)
        XCTAssertNotNil(responseData)
        XCTAssertEqual(mockDataPage, responseData)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
