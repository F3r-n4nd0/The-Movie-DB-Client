//
//  ListMoviesView.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/19/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import UIKit
import Viperit
import RxSwift
import RxCocoa
import Kingfisher
import ESPullToRefresh
import AMScrollingNavbar

//MARK: ListMoviesView Class
final class ListMoviesView: UserInterface {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var barButtonConnectionStatus: UIBarButtonItem!
    
    private var disposeBagTable = DisposeBag()
    private var disposableTable: Disposable?
    private var disposableInternetStatus: Disposable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTabBar()
        presenter.loadPopularMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeTableUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unsubscribeTableUpdate()
        super.viewWillDisappear(animated)
    }
    
    private func configureNavBar() {
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView, delay: 50.0)
        }
    }
    
    private func configureTabBar() {
        tabBar.selectedItem = tabBar.items?.first
    }
    
    private func subscribeTableUpdate() {
        tableView.register(R.nib.movieTableViewCell)
        disposableTable = presenter.publishUpdatedMovies
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: R.nib.movieTableViewCell.name))
            { row, movie, cell in
                let cellMovie = cell as! MovieTableViewCell
                cellMovie.imageViewFront.kf.setImage(with: movie.posterPath)
                cellMovie.labelTitle.text = movie.title
                cellMovie.labelDetail.text = movie.overview
        }
        if let disposableTable = disposableTable {
            disposeBagTable.insert(disposableTable)
        }
        tableView.es.addInfiniteScrolling { [unowned self] in
            self.presenter.loadNextPage()
        }
    }
    
    private func unsubscribeTableUpdate() {
        if let disposableTable = disposableTable {
            disposableTable.dispose()
        }
    }
    
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
