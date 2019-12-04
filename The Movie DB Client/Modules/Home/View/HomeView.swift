//
//  HomeView.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/22/19.
//Copyright © 2019 Fernando Luna. All rights reserved.
//

import UIKit
import Viperit
import AMScrollingNavbar

//MARK: HomeView Class
final class HomeView: ScrollingNavigationController {

    public var _presenter: PresenterProtocol!
    public var _displayData: DisplayData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _presenter.viewHasLoaded()
        setNavigationBar()
        setLogo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _presenter.viewIsAboutToAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _presenter.viewHasAppeared()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _presenter.viewIsAboutToDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _presenter.viewHasDisappeared()
    }
    
    private var imageView: UIImageView?
    
    private func setNavigationBar() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .clear
        navigationBar.tintColor = R.color.primaryColor()
    }
    
    private func setLogo() {
        let logo = R.image.logoNavigationBar()!
        let bannerWidth = self.navigationBar.frame.size.width
        let bannerHeight = self.navigationBar.frame.size.height
        imageView = UIImageView(image: logo)
        imageView?.contentMode = .scaleAspectFit
        imageView?.backgroundColor = .clear
        imageView?.frame = CGRect(x: 0, y: 0, width: bannerWidth, height: bannerHeight)
        self.navigationBar.addSubview(imageView!)
    }
    
}

//MARK: - HomeView API
extension HomeView: HomeViewApi {
}

// MARK: - HomeView Viper Components API
private extension HomeView {
    var presenter: HomePresenterApi {
        return _presenter as! HomePresenterApi
    }
    var displayData: HomeDisplayData {
        return _displayData as! HomeDisplayData
    }
}
