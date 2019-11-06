//
//  MainTabBarController.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 18/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller1 = generateControllers(storyBoardName: "Custom", identifier: "HomeStoryBoard", barItemTitle: "Home", barItemImage: #imageLiteral(resourceName: "home"))
        let controller2 = UIViewController()
        controller2.view.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        controller2.tabBarItem = UITabBarItem(title: "Donate", image: #imageLiteral(resourceName: "donate"), selectedImage:#imageLiteral(resourceName: "donate"))
        
        let controller3 = UINavigationController(rootViewController: TopCharitesController())
            
        controller3.tabBarItem = UITabBarItem(title: "Top Charites", image: #imageLiteral(resourceName: "charity"), selectedImage:#imageLiteral(resourceName: "charity"))
        
        let controller4 = UIViewController()
        controller4.view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        controller4.tabBarItem = UITabBarItem(title: "Account", image: #imageLiteral(resourceName: "account"), selectedImage:#imageLiteral(resourceName: "account"))
        self.viewControllers = [controller1, controller2, controller3, controller4]
        self.tabBar.tintColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 0.7514304577)
        
    }
    
    fileprivate func generateControllers(storyBoardName: String = "", identifier: String = "", barItemTitle: String, barItemImage: UIImage) -> UIViewController {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let controller = storyBoard.instantiateViewController(identifier: identifier)
        controller.tabBarItem = UITabBarItem(title: barItemTitle, image: barItemImage, selectedImage: barItemImage)
        return controller
    }
    
}
