//
//  ViewController.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 04/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
   let isFirstTime = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        openState()
    }
    
    fileprivate func openState(){
        isFirstTime.set(true, forKey: "hasOpenBefore")
    }
}

