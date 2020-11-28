//
//  SceneDelegate.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 04/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let hasOpenBefore = UserDefaults.standard.bool(forKey: "hasOpenBefore")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        
        if(hasOpenBefore == false) {
            let onBordingController = OnBoardingController()
            window?.rootViewController = onBordingController
        } else {
            let tabController = CinematoTabBarController()
            window?.rootViewController = tabController
        }
    }
}

