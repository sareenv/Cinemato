//
//  MoviesImageHeaderCell.swift
//  Cinemtiyo
//
//  Created by DataBunker on 02/10/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit

class MoviesImageHeaderCell: UICollectionViewCell {
  
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "charity1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var movieImage: String? {
        didSet {
            if let movieImage = movieImage {
                updateMovieImage(relativePath: movieImage)
            }
        }
    }
    
    fileprivate func updateMovieImage(relativePath: String) {
        guard let imagePosterUrl = URL(string: "http://image.tmdb.org/t/p/original" + relativePath) else { return }
        
        self.movieImageView.sd_setImage(with: imagePosterUrl, completed: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(movieImageView)
        movieImageView.fillSuperView()
        movieImageView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
