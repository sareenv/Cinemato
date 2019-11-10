//
//  MainTabBarController.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 18/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class CinematoTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller1 = generateControllers(storyBoardName: "Custom", identifier: "HomeStoryBoard", barItemTitle: "Popular", barItemImage: #imageLiteral(resourceName: "fire"))
        
        
        let controller2 = UIViewController()
        controller2.view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        controller2.tabBarItem = UITabBarItem(title: "Search", image: #imageLiteral(resourceName: "search"), tag: 0)
        let controller3 = UINavigationController(rootViewController: UIViewController())
            
        controller3.tabBarItem = UITabBarItem(title: "TV Shows", image: #imageLiteral(resourceName: "tv"), tag: 0)
        
        let controller4 = UIViewController()
        controller4.view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        controller4.tabBarItem = UITabBarItem(title: "Account", image: #imageLiteral(resourceName: "account"), selectedImage:#imageLiteral(resourceName: "account"))
        self.viewControllers = [controller1, controller2, controller3, controller4]
        self.tabBar.tintColor = #colorLiteral(red: 0.7795123458, green: 0.4400732517, blue: 0.7914783955, alpha: 1)
        self.tabBar.isTranslucent = false
    }
    
    fileprivate func generateControllers(storyBoardName: String = "", identifier: String = "", barItemTitle: String, barItemImage: UIImage) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let controller = storyBoard.instantiateViewController(identifier: identifier)
        controller.tabBarItem = UITabBarItem(title: barItemTitle, image: barItemImage, selectedImage: barItemImage)
        return controller
    }
    
}
