//
//  MoviePictureView.swift
//  Cinemtiyo
//
//  Created by DataBunker on 01/10/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit


class MoviePictureView: UIView {
    
    var selectedImage: UIImage? {
        didSet {
            guard let image = selectedImage else { return }
            self.setupImageView(image: image)
        }
    }
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.backgroundColor = color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    lazy var imageView = UIImageView()
    
    fileprivate func setupImageView(image: UIImage) {
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode  = .scaleAspectFill
        self.addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTap))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





