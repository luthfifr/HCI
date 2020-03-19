//swiftlint:disable line_length
//
//  AppDelegate.swift
//  HCI
//
//  Created by Luthfi Fathur Rahman on 17/03/20.
//  Copyright © 2020 Stand Alone. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    typealias Constants = HCConstants.TabBar

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        UINavigationBar.appearance().barTintColor = Constants.barTintColor
        UINavigationBar.appearance().titleTextAttributes = Constants.titleColor

        HCReachability.shared.startMonitoring()

        if #available(iOS 13, *) {
            //skip anything here if iOS v13 or later
        } else {
            let window = UIWindow()
            let mainVC = HCMainViewController()
            let navigation = UINavigationController(rootViewController: mainVC)
            window.rootViewController = navigation
            self.window = window
            window.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        HCReachability.shared.stopMonitoring()
    }
}

// MARK: UISceneSession Lifecycle (iOS 13 and later)
@available(iOS 13, *)
extension AppDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
