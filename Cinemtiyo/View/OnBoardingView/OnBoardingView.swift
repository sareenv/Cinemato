//
//  OnBoardingView.swift
//  Cinemtiyo
//
//  Created by DataBunker on 28/11/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit
import Lottie



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
        sv.spacing = 10
        sv.distribution = .fill
        sv.axis = .vertical
        return sv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(font: .boldSystemFont(ofSize: 24), text: "Review Popular Movies", alignment: .natural)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(font: .systemFont(ofSize: 18), text: "Review Popular Movies", alignment: .left)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    fileprivate func setupAnimatedView() {
        let estimatedHeight = CGFloat(220)
        addSubview(animationView)
        animationView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: estimatedHeight).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: estimatedHeight).isActive = true
    }
    
    fileprivate func setupDetailsLabels() {
        vStackView.addArrangedSubview(titleLabel)
        vStackView.addArrangedSubview(descriptionLabel)
        addSubview(vStackView)
        vStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        vStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        vStackView.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 5).isActive = true
    }
    
    fileprivate func setupViews() {
        setupAnimatedView()
        setupDetailsLabels()
    }
    
    func configureCell(page: Page) {
            setupViews()
            animationView.animation = Animation.named(page.animationName)
            animationView.animationSpeed = 1
            animationView.loopMode = .loop
            animationView.play()
            titleLabel.text = page.title
            descriptionLabel.text = page.description
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
