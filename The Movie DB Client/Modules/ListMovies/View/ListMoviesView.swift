//
//  ListMoviesView.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/19/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import UIKit
import Viperit

//MARK: ListMoviesView Class
final class ListMoviesView: UserInterface {
}

//MARK: - ListMoviesView API
extension ListMoviesView: ListMoviesViewApi {
}

// MARK: - ListMoviesView Viper Components API
private extension ListMoviesView {
    var presenter: ListMoviesPresenterApi {
        return _presenter as! ListMoviesPresenterApi
    }
    var displayData: ListMoviesDisplayData {
        return _displayData as! ListMoviesDisplayData
    }
}
