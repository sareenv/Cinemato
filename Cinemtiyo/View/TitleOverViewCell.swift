//
//  TitleOverViewCell.swift
//  Cinemtiyo
//
//  Created by DataBunker on 02/10/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit

class TitleOverViewCell: UICollectionViewCell {
    
    lazy var titleLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 18), text: "", alignment: .left)
    
    var titleOverView: String? {
        didSet {
            if let titleOverView = titleOverView {
                titleLabel.text = titleOverView
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.fillSuperView(paddingLeft: 10)
    }
    required init?(coder: NSCoder) {
        fatalError("error initialising the cell")
    }
}
