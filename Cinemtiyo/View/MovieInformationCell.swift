//
//  MovieInformationCell.swift
//  Cinemtiyo
//
//  Created by DataBunker on 02/10/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit


class MovieInformationCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                let movieTitle = movie.title ?? "title"
                movieTitleLabel.text = "\(movieTitle)"
                textView.text = movie.overview
            }
        }
    }

    let textView: UITextView = {
        let tv = UITextView(frame: .zero)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.textColor = .systemGray
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.isSelectable = false
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.isUserInteractionEnabled = false
        sv.isBaselineRelativeArrangement = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isLayoutMarginsRelativeArrangement = true
        sv.axis = .vertical
        sv.spacing = 5
        sv.distribution = .fill
        return sv
    }()
    
    
    let tagLineStackView: UIStackView = {
        let sv = UIStackView()
        sv.isUserInteractionEnabled = false	
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .fill
        sv.distribution = .fill
        sv.axis = .horizontal
        sv.spacing = 4
        return sv
    }()
    
    
    let trailerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        button.setTitle("Trailer", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        return button
    }()
    
    
    let movieTitleLabel = UILabel(font: UIFont.boldSystemFont(ofSize: 22), text: "Title", alignment: .left)
    let descriptionTitleLabel = UILabel(font: UIFont.systemFont(ofSize: 18), text: "Storyline", alignment: .left)

    

    
    
    fileprivate func stackViewSettings() {
        addSubview(stackView)
        stackView.layoutMargins = .init(top: 10, left: 6, bottom: 0, right: 0)
        stackView.fillSuperView()
        descriptionTitleLabel.textColor = .darkGray
        stackView.addArrangedSubview(movieTitleLabel)
        stackView.addArrangedSubview(descriptionTitleLabel)
        stackView.addArrangedSubview(textView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        stackViewSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
