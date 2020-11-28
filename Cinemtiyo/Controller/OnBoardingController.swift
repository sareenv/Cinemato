//
//  OnBoardingController.swift
//  Cinemtiyo
//
//  Created by DataBunker on 28/11/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit

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
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onBoardingCell", for: indexPath) as! OnBoardingCell
        cell.backgroundColor = (indexPath.item % 2 == 0) ? .red : .yellow
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


// Changes.

class OnBoardingCell: UICollectionViewCell {
    
    // lottie animations.
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Press Me", for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }()
    
    @objc func handleTap() {
        let dummyController = UIViewController()
        dummyController.view.backgroundColor = .yellow
        self.window?.rootViewController = dummyController
    }
    
    
    fileprivate func setupButton() {
        addSubview(button)
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("Error init the cell")
    }
}
