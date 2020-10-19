//
//  SimilarMoviesCell.swift
//  Cinemtiyo
//
//  Created by DataBunker on 17/10/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit
import SDWebImage

class SimilarMoviesCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                guard let id = movie.id else { return }
                updateMovieInformation(id: id)
            }
        }
    }
    
    let movieTitleLabel: UILabel = {
        let label = UILabel(font: UIFont.boldSystemFont(ofSize: 15), text: "Movie Title", alignment: .left)
        label.textColor = .purple
        label.layoutMargins = .init(top: 5, left: 0, bottom: 0, right: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tagLineLabel: UILabel = {
        let label = UILabel(font: UIFont.systemFont(ofSize: 14), text: "Movie Tagline", alignment: .left)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let descriptionLabel: UILabel = {
        let label = UILabel(font: UIFont.systemFont(ofSize: 12), text: "This is a dummy movie description which resembles the movie you selected", alignment: .left)
        label.textColor = .black
        label.layoutMargins = .init(top: 5, left: 0, bottom: 0, right: 0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    let movieImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 25
        return iv
    }()
    
    let movieStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fill
        sv.axis = .horizontal
        sv.isLayoutMarginsRelativeArrangement = true
        sv.alignment = .top
        sv.spacing = 6
        return sv
    }()
    
    
    let informationStackView = { () -> UIStackView in
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fill
        return sv
    }()
    
    fileprivate func updateMovieInformation(id: Int) {
        let basePath = "http://image.tmdb.org/t/p/original"
        let relativeUrl = "\(movie?.backdrop_path ?? "")"
        let urlString = basePath + relativeUrl
        guard let url = URL(string: urlString) else { return }
        movieImageView.sd_setImage(with: url, completed: nil)
        let title = movie?.title ?? ""
        self.movieTitleLabel.text = title
        if let voteCount = movie?.vote_count {
            self.tagLineLabel.text = "\(voteCount) Votes"
        }
        self.descriptionLabel.text = movie?.overview ?? ""
    }
    
    
    fileprivate func setupInformationStackView() {
        informationStackView.addArrangedSubview(movieTitleLabel)
        informationStackView.addArrangedSubview(tagLineLabel)
        informationStackView.addArrangedSubview(descriptionLabel)
    }
    
    fileprivate func setupMoviesStackView() {
        let estimatedHeight = CGFloat(50)
        let estimatedWidth = CGFloat(50)
        movieStackView.layoutMargins = .init(top: 5, left: 5, bottom: 5, right: 5)
        movieImageView.heightAnchor.constraint(equalToConstant: estimatedHeight).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: estimatedWidth).isActive = true
        self.addSubview(movieStackView)
        movieStackView.fillSuperView()
        movieStackView.addArrangedSubview(movieImageView)
        movieStackView.addArrangedSubview(informationStackView)
    }
    
  
    
    fileprivate func cellStyling() {
        let backgroundColor = UIColor.white
        self.layer.cornerRadius = 7
        self.backgroundColor = backgroundColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellStyling()
        setupInformationStackView()
        setupMoviesStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}


