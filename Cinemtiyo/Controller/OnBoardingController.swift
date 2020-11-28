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
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    let pageControl = UIPageControl()
    
    fileprivate func setupPageControl() {
        
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = animations.count
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.addSubview(pageControl)
        pageControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSettings()
        setupPageControl()
    }
    
    
    let animations = [
        Page(animationName: "animation1", title: "", description: ""),
        Page(animationName: "animation3", title: "", description: ""),
        Page(animationName: "animation2", title: "", description: ""),
        Page(animationName: "animation1", title: "", description: "")
    ]
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2

        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoardingCell", for: indexPath) as! OnBoardingCell
        cell.backgroundColor = .white
        cell.configureCell(page: animations[indexPath.item])
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


