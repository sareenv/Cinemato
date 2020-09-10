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
        let controller2 = generateControllers(storyBoardName: "Search", identifier: "SearchStoryBoard", barItemTitle: "Search", barItemImage: #imageLiteral(resourceName: "search"))
        let controller3 = UINavigationController(rootViewController: WatchListController())
        controller3.tabBarItem = UITabBarItem(title: "Watch List", image: #imageLiteral(resourceName: "tv"), tag: 0)
        
      
        self.viewControllers = [controller1, controller3, controller2]
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
    
}
