//
//  ListMoviesInteractor.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/19/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import Foundation
import Viperit

// MARK: - ListMoviesInteractor Class
final class ListMoviesInteractor: Interactor {
}

// MARK: - ListMoviesInteractor API
extension ListMoviesInteractor: ListMoviesInteractorApi {
}

// MARK: - Interactor Viper Components Api
private extension ListMoviesInteractor {
    var presenter: ListMoviesPresenterApi {
        return _presenter as! ListMoviesPresenterApi
    }
}
