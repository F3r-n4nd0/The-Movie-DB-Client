//
//  PageRepository.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/23/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import RealmSwift

class PageMoviesRepository: Object {
    @objc dynamic var _id: Int = 0
    @objc dynamic var number: Int = 1
    @objc dynamic var type: Int = ListMoviesType.Popular.rawValue
    let movies = List<MovieRepository>()
    
    override static func primaryKey() -> String? {
        return "_id"
    }
    
}
