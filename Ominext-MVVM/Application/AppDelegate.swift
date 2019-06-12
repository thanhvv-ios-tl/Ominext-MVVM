//
//  AppDelegate.swift
//
//  Copyright © 2019 Ominext. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        _ = DIContainer.shared
        
        var rootVC: BaseVC!
        Session.currentSession.reloadSession()
        if Session.currentSession.token != nil {
            rootVC = DrugsVC()
        } else {
            rootVC = LoginVC()
        }
        
        let rootNaviVC = BaseNaviVC(rootViewController: rootVC)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootNaviVC
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return OrientationManager.shared.supportOrientation
    }
}

