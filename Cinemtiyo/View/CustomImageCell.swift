//
//  CustomImageCell.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 05/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class CustomImageCell: UICollectionViewCell{
    
    
    @IBOutlet weak var movieImageView: UIImageView! {
        didSet {
            movieImageView.contentMode = .scaleAspectFill
            movieImageView.backgroundColor = UIColor.gray
        }
    }
}
