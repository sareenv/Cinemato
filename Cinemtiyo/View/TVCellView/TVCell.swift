//
//  TVCell.swift
//  Cinemtiyo
//
//  Created by DataBunker on 2022-07-04.
//  Copyright © 2022 Vinayak Sareen. All rights reserved.
//

import UIKit

class TVCell: UICollectionViewCell {
    
    var data: TVShow? {
        didSet {
            guard let posterPath = data?.backdrop_path else { return }
            let urlPath = "http://image.tmdb.org/t/p/original\(posterPath)"
            guard let url = URL(string: urlPath) else { return }
            
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            self.title.text = data?.name ?? "NO NAME"
            guard let description = data?.overview else { return }
            self.descriptionLabel.text = "\(description)"
        }
    }

    let imageView: UIImageView =  {
        let iv = UIImageView(frame: .zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 6
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "default")
        return iv
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    let title: UILabel = {
        let label = UILabel(font: .boldSystemFont(ofSize: 13), text: "Friends", alignment: .left)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.backgroundColor = .white
        return label
    }()
    
    let spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 3).isActive = true
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(font: .systemFont(ofSize: 12), text: "••", alignment: .left)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .gray
        label.backgroundColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor =  .white
        self.layer.cornerRadius = 5
        self.addSubview(stackView)
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 5, bottom: 5, trailing: 5)
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(spacerView)
        self.stackView.addArrangedSubview(title)
        self.stackView.addArrangedSubview(descriptionLabel)
        self.stackView.fillSuperView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
