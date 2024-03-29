//
//  CharityOrganisationCell.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 21/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit
import SDWebImage

class PopularMoviesCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviewPosterImageView: UIImageView! {
        didSet {
            moviewPosterImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieCompanyImageView: UIImageView! {
        didSet {
            movieCompanyImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        }
    }
    
    var movieDetail: Movie?{
        didSet{
            self.movieTitle.text = movieDetail?.title
            self.movieReleaseDateLabel.text = movieDetail?.release_date
            self.descriptionLabel.text = movieDetail?.overview
            let imagePosterUrl = "http://image.tmdb.org/t/p/original" + (movieDetail?.backdrop_path ?? "")
            moviewPosterImageView.sd_setImage(with: URL(string: imagePosterUrl), placeholderImage: UIImage(named: "placeholder"))
            movieCompanyImageView.sd_setImage(with: URL(string: imagePosterUrl), placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(light: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), dark: #colorLiteral(red: 0.0302177785, green: 0.0302177785, blue: 0.0302177785, alpha: 1))
        movieTitle.textColor = UIColor(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 0.7795123458, green: 0.4400732517, blue: 0.7914783955, alpha: 1))
        movieReleaseDateLabel.textColor = UIColor(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        movieCompanyImageView.layer.cornerRadius = movieCompanyImageView.frame.width / 2
        movieCompanyImageView.clipsToBounds = true
        moviewPosterImageView.layer.cornerRadius = 7
        moviewPosterImageView.clipsToBounds = true
    }
}
