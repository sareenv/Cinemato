//
//  OnBoardingView.swift
//  Cinemtiyo
//
//  Created by DataBunker on 28/11/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit
import Lottie

struct Page {
    let animationName: String
}

// Changes.

class OnBoardingCell: UICollectionViewCell {
    
    // lottie animations.
    lazy var animationView: AnimationView = {
        let animationView = AnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.backgroundColor = .white
        return animationView
    }()
   
    lazy var vStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 0
        sv.distribution = .fill
        sv.axis = .vertical
        return sv
    }()
    
    // other components.
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
    
    let titleLabel: UILabel = {
        let label = UILabel(font: .systemFont(ofSize: 24), text: "Review Popular Movies", alignment: .natural)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(font: .systemFont(ofSize: 18), text: "Review Popular Movies", alignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate func setupViews() {
        let estimatedHeight = (self.frame.width) * 70 / 100
        addSubview(animationView)
        animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: estimatedHeight).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: estimatedHeight).isActive = true
    }
    
    func configureCell(page: Page) {
            setupViews()
            animationView.animation = Animation.named(page.animationName)
            animationView.animationSpeed = 1
            animationView.loopMode = .loop
            animationView.play()
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
    }
    
    

    required init?(coder: NSCoder) {
        fatalError("Error init the cell")
    }
}
