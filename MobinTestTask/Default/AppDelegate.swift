//
//  AppDelegate.swift
//  MobinTestTask
//
//  Created by Дмитрий Данилин on 13.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        createAndShowStartVC()
        
        return true
    }
    
}

// MARK: - Initial application settings

private extension AppDelegate {
    func createAndShowStartVC() {
        let mainVC = CardsViewController()
        
        PresentationAssembly().cards.config(view: mainVC)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}

