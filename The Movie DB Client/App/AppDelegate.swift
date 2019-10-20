//
//  AppDelegate.swift
//  The Movie DB Client
//
//  Created by Fernando Luna on 10/16/19.
//  Copyright © 2019 Fernando Luna. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let module = AppModules.ListMovies.build()
        let router = module.router as! ListMoviesRouter
        router.show(inWindow: window)
        return true
    }

}

