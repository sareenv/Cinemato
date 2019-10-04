//
//  Sliders.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 04/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class SliderController: UIViewController{
    
    let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btn.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        btn.setTitle("Goto Home Page", for: .normal)
        btn.addTarget(self, action: #selector(handleBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        setupBtn()
        navigationSettings()
    }
    
    
    fileprivate func navigationSettings(){
        self.navigationController?.isNavigationBarHidden = true
    }
 
    fileprivate func setupBtn(){
        view.addSubview(button)
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func handleBtn(){
        let storyBoard = UIStoryboard(name: "Custom", bundle: nil)
        let homeController = storyBoard.instantiateViewController(identifier: "HomeStoryBoard")
        self.navigationController?.pushViewController(homeController, animated: true)
    }
}
