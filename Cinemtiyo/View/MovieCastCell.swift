//
//  CastCell.swift
//  Cinemtiyo
//
//  Created by DataBunker on 02/10/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit

class MovieCastCell: UICollectionViewCell {
    
     let castTileLabel: UILabel = {
        let label = UILabel(font: UIFont.systemFont(ofSize: 15), text: "Actor", alignment: .center)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var castImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "charity1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isBaselineRelativeArrangement = false
        sv.distribution = .fill
        sv.axis = .vertical
        return sv
    }()
    
    var cast: MovieCast? {
        didSet {
            if let cast = cast {
                castTileLabel.text = cast.name
                updateCastImage(relativePath: cast.profile_path ?? "")
            }
        }
    }
    
    fileprivate func updateCastImage(relativePath: String) {
        guard let imagePosterUrl = URL(string: "http://image.tmdb.org/t/p/w300" + relativePath) else {
            print("Error")
            return
        }
        self.castImageView.sd_setImage(with: imagePosterUrl, placeholderImage: #imageLiteral(resourceName: "charity1"), completed: nil)
    }
    
    fileprivate func setupStackView() {
        self.backgroundColor = .white
        self.addSubview(stackView)
        let heightAnchor = CGFloat(150.0)
        castImageView.heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true
        stackView.addArrangedSubview(castImageView)
        stackView.addArrangedSubview(castTileLabel)
        stackView.fillSuperView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
    }
   
    
    fileprivate func applyGradient() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = .zero
        gradient.frame = self.bounds
        gradient.opacity = 0.2
        DispatchQueue.main.async {
            self.layer.addSublayer(gradient)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


