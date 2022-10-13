//
//  CustomHeaderSlider.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 06/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit
import SDWebImage

class CustomHeaderElementCell: UICollectionViewCell{
    
    var imageUrl: URL? {
        didSet {
            headerElementImageView.sd_setImage(with: imageUrl)
        }
    }
    
    let headerElementImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.sd_imageIndicator = SDWebImageActivityIndicator.gray
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "placeholder")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 7
        return iv
    }()
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        addLayout()
    }
    
    fileprivate func addLayout(){
        self.addSubview(headerElementImageView)
        headerElementImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        headerElementImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        headerElementImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        headerElementImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("Some error")
    }
}
