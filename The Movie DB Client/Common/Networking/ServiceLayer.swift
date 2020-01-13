//
//  ServiceLayer.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/21/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation

class ServiceLayer {
    
    var session: URLSession
    
    required init(session: URLSession) {
        self.session = session
    }
    
    func request<T: Codable>(router: RouterAPI, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard response != nil else {
                return
            }
            guard let data = data else {
                return
            }
            let responseObject = try! JSONDecoder().decode(T.self, from: data)
            completion(.success(responseObject))
        }
        dataTask.resume()
        return dataTask
    }
    
}
