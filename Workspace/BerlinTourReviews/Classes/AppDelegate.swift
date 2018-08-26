//
//  AppDelegate.swift
//  BerlinTourReviews
//
//  Created by VI_Business on 24/08/2018.
//  Copyright © 2018 supercorp. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        self.window!.rootViewController = UINavigationController(rootViewController:TourReviewsListViewController())
        self.window!.makeKeyAndVisible()
        
        return true
    }
}

