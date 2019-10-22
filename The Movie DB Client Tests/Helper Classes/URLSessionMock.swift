//
//  URLSessionMock.swift
//  The Movie DB Client Tests
//
//  Created by Fernando Luna on 10/21/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    private var data: Data?
    private var error: Error?
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
    
    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
    
}
