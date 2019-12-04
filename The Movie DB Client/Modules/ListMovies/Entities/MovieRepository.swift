//
//  MovieRepository.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/22/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import RealmSwift

class MovieRepository: Object {
    @objc dynamic var _id: Int = 0
    @objc dynamic var posterPath: String = "https://www.themoviedb.org"
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: Date = Date()
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var originalLanguage: String?
    @objc dynamic var title: String = ""
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var voteAverage: Float = 0.0
    @objc dynamic var updateDate: Date = Date()
    
    override static func primaryKey() -> String? {
        return "_id"
    }
    
}
