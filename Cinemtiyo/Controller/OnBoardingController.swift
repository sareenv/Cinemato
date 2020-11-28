//
//  OnBoardingController.swift
//  Cinemtiyo
//
//  Created by DataBunker on 28/11/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit
import Lottie

class OnBoardingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate func collectionViewSettings() {
        collectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: "onBoardingCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSettings()
    }
    
    var currentCell = 0
    let animations = [
        Page(animationName: "animation1"),
        Page(animationName: "animation2"),
        Page(animationName: "animation3")
                      
    ]
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentCell = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentCell = (currentCell > 0) ? currentCell : 0
        print(currentCell)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoardingCell", for: indexPath) as! OnBoardingCell
        cell.backgroundColor = .white
        cell.configureCell(page: animations[currentCell])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height)
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


