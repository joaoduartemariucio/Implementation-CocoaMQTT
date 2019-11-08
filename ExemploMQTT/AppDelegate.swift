//
//  AppDelegate.swift
//  ExemploMQTT
//
//  Created by João Vitor Duarte Mariucio on 07/11/19.
//  Copyright © 2019 João Duarte. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let view = ViewController()
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        
        return true
    }
}

