//
//  AppModules.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/19/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import Viperit

enum AppModules: String, ViperitModule {
    case ListMovies
    case Home
    var viewType: ViperitViewType {
        switch self {
        case .ListMovies: return .storyboard
        case .Home: return .code
        }
    }
}
