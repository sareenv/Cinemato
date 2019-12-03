//
//  TableViewCell.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 21/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit


class CustomHomeCell: UITableViewCell{
    
    @IBOutlet weak var charityOwner: UIImageView!
    @IBOutlet weak var charityCoverImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        charityOwner.layer.cornerRadius = charityOwner.frame.width / 2
        charityCoverImageView.layer.cornerRadius = 5
        
    }
    
}

