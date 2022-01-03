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
        
        let PopularController = generateControllers(storyBoardName: "Custom", identifier: "HomeStoryBoard", barItemTitle: "Popular", barItemImage: #imageLiteral(resourceName: "fire"))
        let WatchListViewController = generateCodeController(viewController: WatchListController(), barItemTitle: "Watch List", barItemImage: UIImage(systemName: "eyeglasses") ?? #imageLiteral(resourceName: "search"))
        let tvController = generateCodeController(viewController: TVController(), barItemTitle: "TV Shows", barItemImage: #imageLiteral(resourceName: "tv"))
        let cinemaLocation = generateCodeController(viewController: CinemaLocationController(), barItemTitle: "Local Cinema", barItemImage: UIImage(systemName: "map") ?? #imageLiteral(resourceName: "search"))
        self.viewControllers = [PopularController, tvController, WatchListViewController, cinemaLocation]
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = #colorLiteral(red: 0.7795123458, green: 0.4400732517, blue: 0.7914783955, alpha: 1)
        self.tabBar.isTranslucent = false
    }
    
    // changes to support storyBoards and programmatic.
    fileprivate func generateControllers(storyBoardName: String = "", identifier: String = "", barItemTitle: String, barItemImage: UIImage) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let controller = storyBoard.instantiateViewController(identifier: identifier)
        controller.tabBarItem = UITabBarItem(title: barItemTitle, image: barItemImage, selectedImage: barItemImage)
        return controller
    }
    
    
    fileprivate func generateCodeController(viewController: UIViewController, barItemTitle: String, barItemImage: UIImage) -> UIViewController {
        let viewController = viewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: barItemTitle, image: barItemImage, selectedImage: barItemImage)
        return navigationController
    }
    
}
