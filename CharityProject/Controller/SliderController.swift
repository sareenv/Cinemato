//
//  Sliders.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 04/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class SliderController: UICollectionViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSettings()
    }
    
    fileprivate func navigationSettings(){
        self.navigationController?.isNavigationBarHidden = true
    }
     
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
