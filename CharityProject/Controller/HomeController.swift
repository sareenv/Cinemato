//
//  ViewController.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 04/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    // UserDefault to manage the state of application launching for first time.
    let isFirstTime = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openState()
        navigationSettings()
    }
    
    fileprivate func navigationSettings(){
        let item = UIBarButtonItem(image: UIImage.init(systemName: "list.dash"), style: .plain, target: self, action: nil)
        item.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationItem.leftBarButtonItem = item
    }
    
    fileprivate func openState(){
        isFirstTime.set(true, forKey: "hasOpenBefore")
    }
}

