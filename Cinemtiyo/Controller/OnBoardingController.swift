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
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = animations.count
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    fileprivate func collectionViewSettings() {
        collectionView.register(OnBoardingCell.self, forCellWithReuseIdentifier: "onBoardingCell")
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }

    fileprivate func setupPageControl() {
        self.collectionView.addSubview(pageControl)
        pageControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true

        pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16).isActive = true
    }
    
    
    let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get Started", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.tintColor = .white
        button.backgroundColor = .systemRed
        button.isHidden = true // turn this to true.
        button.layer.cornerRadius = 5
        button.addTarget(OnBoardingController.self, action: #selector(handleGetStarted), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func handleGetStarted() {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        keyWindow?.rootViewController = CinematoTabBarController()
    }
    
    fileprivate func setupStartedButton() {
        collectionView.addSubview(getStartedButton)
        getStartedButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        getStartedButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        getStartedButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        getStartedButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSettings()
        setupPageControl()
        setupStartedButton()
    }
    
    
    let animations = [
        Page(animationName: "animation1", title: "Review Popular Movies", description: "We provide extensive list of movies to choose from with trailers and short storyline"),
        Page(animationName: "animation3", title: "Locate to nearby cinema", description: "We use your location and display all the available cinema in your area"),
        Page(animationName: "animation2", title: "Build Your watch list", description: "Now keep track of all the movies and tv shows you want to enjoy on weekends"),
        Page(animationName: "animation4", title: "Share movie information", description: "We allow you to plan and share movie information with your friends and family")
    ]


    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension OnBoardingController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        let currentPage = Int(offSet + horizontalCenter) / Int(width)
        getStartedButton.isHidden = (currentPage == 3) ? false : true
        pageControl.currentPage = currentPage
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
}
