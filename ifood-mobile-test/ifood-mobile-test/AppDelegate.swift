//
//  AppDelegate.swift
//  ifood-mobile-test
//
//  Created by Gabriel Guerrero on 11/13/18.
//  Copyright © 2018 Gabriel Guerrero. All rights reserved.
//

import UIKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        TWTRTwitter.sharedInstance().start(withConsumerKey: TWITTER_CLIENT_KEY, consumerSecret: TWITTER_CLIENT_SECRET_KEY)
        
        /* Create ui-view-controller instance*/
        let tweet = TweetListRouter.createModule()
        
        /* Initiating instance of ui-navigation-controller with view-controller */
        let navigationController = UINavigationController()
        navigationController.viewControllers = [tweet]
        
        /* Setting up the root view-controller as ui-navigation-controller */
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

