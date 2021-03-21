//
//  AppDelegate.swift
//  CodingChallenge
//
//  Created by Andrii Kravchenko on 27.01.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootNavigation = UINavigationController()
        coordinator = AppCoordinator(rootNavigation: rootNavigation)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigation
        window?.makeKeyAndVisible()

        coordinator.start()
        return true
    }
}
