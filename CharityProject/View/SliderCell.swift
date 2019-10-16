//
//  SliderCell.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 11/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

// protocol to detect button Pressed.
protocol CellButtonDetect: class {
    func detectButtonPressed()
}

class SliderCell: UICollectionViewCell{
    
    weak var customDelegate: CellButtonDetect?
    
    var slideId = 0{
        didSet{
            setupButton()
        }
    }
    
    var sliderContent: SliderContent?{
        didSet{
            sliderImageView.image = sliderContent?.image
            contentLabel.text = sliderContent?.content
            descriptionLabel.text = sliderContent?.description
        }
    }
    
    
   
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.numberOfPages = 4
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return pageControl
    }()
 
    let getStartedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Take me to app", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        return button
    }()
    
   
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    let sliderImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupButton()
        setupPageControl()
    }
    
    
    lazy var layoutStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sliderImageView, contentLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.axis = .vertical
        return stackView
    }()
    
    fileprivate func setupLayout(){
        self.addSubview(layoutStackView)
        sliderImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        sliderImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        layoutStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        layoutStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -12).isActive = true
    }
    
    fileprivate func setupButton(){
        if(slideId == 3){
            getStartedButton.addTarget(self, action: #selector(handleGetStartedButton), for: .touchUpInside)
            self.addSubview(getStartedButton)
            getStartedButton.topAnchor.constraint(equalTo: layoutStackView.bottomAnchor, constant: 15).isActive = true
            getStartedButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            getStartedButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        }
    }
    

    
    @objc func handleGetStartedButton(){
        guard let delegate = customDelegate else { return }
        delegate.detectButtonPressed()
    }
    
    fileprivate func setupPageControl(){
        self.addSubview(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 12).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("Some error init the cell")
    }
    
}

