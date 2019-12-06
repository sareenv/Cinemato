//
//  CustomHeaderSlider.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 06/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit


class CustomHeaderElementCell: UICollectionViewCell{
    
    let headerElementImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "charity1") // this needs to be replaced with datasource option.
        iv.contentMode = .scaleAspectFill
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
        headerElementImageView.layer.cornerRadius = 7
        headerElementImageView.clipsToBounds = true
    }
    
    @objc func handleElementTapped(){}
    
    required init?(coder: NSCoder) {
        fatalError("Some error")
    }
}
