//
//  CastCell.swift
//  Cinemtiyo
//
//  Created by DataBunker on 02/10/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCastCell: UICollectionViewCell {
    
     let castTitleLabel: UILabel = {
        let label = UILabel(font: UIFont.boldSystemFont(ofSize: 15), text: "Actor", alignment: .center)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let positionTitleLabel: UILabel = {
       let label = UILabel(font: UIFont.systemFont(ofSize: 13), text: "Actor", alignment: .center)
       label.numberOfLines = 0
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    lazy var castImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        return imageView
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.isBaselineRelativeArrangement = false
        sv.distribution = .fill
        sv.spacing = 1
        sv.axis = .vertical
        return sv
    }()
    
    var cast: MovieCast? {
        didSet {
            if let cast = cast {
                castTitleLabel.text = cast.name ?? "Unknown"
                updateCastImage(relativePath: cast.profile_path ?? "")
            }
        }
    }
    
    fileprivate func updateCastImage(relativePath: String) {
        guard let imagePosterUrl = URL(string: "http://image.tmdb.org/t/p/w400" + relativePath) else {
            print("Error")
            return
        }
       
        castImageView.sd_setImage(with: imagePosterUrl) { (image, _, _, _) in
            if(image == nil) { self.castImageView.image = #imageLiteral(resourceName: "default") }
        }
    }
    
    fileprivate func setupStackView() {
        self.backgroundColor = .white
        self.addSubview(stackView)
        let heightAnchor = CGFloat(140.0)
        castImageView.heightAnchor.constraint(equalToConstant: heightAnchor).isActive = true
        stackView.addArrangedSubview(castImageView)
        stackView.addArrangedSubview(castTitleLabel)
        stackView.addArrangedSubview(positionTitleLabel)
        stackView.fillSuperView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        self.layer.shadowColor = .init(red: 256, green: 0, blue: 0, alpha: 1)
        backgroundColor = .white
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


