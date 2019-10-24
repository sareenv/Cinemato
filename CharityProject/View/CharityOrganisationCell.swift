//
//  CharityOrganisationCell.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 21/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class CharityOrganisationCell: UITableViewCell {

    @IBOutlet weak var charityRepImageView: UIImageView!
    @IBOutlet weak var charityLogoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        charityRepImageView.layer.cornerRadius = charityRepImageView.frame.width / 2
        charityRepImageView.clipsToBounds = true
        charityLogoImageView.layer.cornerRadius = 7
        charityLogoImageView.clipsToBounds = true
    }
}
