//
//  SimilarMoviesCell.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 04/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class SimilarMoviesCell: UICollectionViewCell{
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Avangers"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieDetails: Movie?{
        didSet{
            titleLabel.text = movieDetails?.title
             let imagePosterUrlString = "http://image.tmdb.org/t/p/original" + (movieDetails?.backdrop_path ?? "")
            let imagePosterUrl = URL(string: imagePosterUrlString)
            self.movieImageView.sd_setImage(with: imagePosterUrl, completed: nil)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.348068882)
        self.layer.cornerRadius = 5
        setupBackgroundImageView()
    }
    
    fileprivate func setupBackgroundImageView(){
        let stackView = UIStackView(arrangedSubviews: [movieImageView, titleLabel])
        movieImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("error init the cell")
    }
    
}

