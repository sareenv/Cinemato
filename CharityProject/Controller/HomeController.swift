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
    }
    
    fileprivate func openState(){
        isFirstTime.set(true, forKey: "hasOpenBefore")
    }
}

