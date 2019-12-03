//
//  CharityOrganisationCell.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 21/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class PopularMoviesCell: UITableViewCell {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviewPosterImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieCompanyImageView: UIImageView!
    
    var movieDetail: Movie?{
        didSet{
            self.movieTitle.text = movieDetail?.title
            self.movieReleaseDateLabel.text = movieDetail?.release_date
            self.descriptionLabel.text = movieDetail?.overview
            let imagePosterUrl = "http://image.tmdb.org/t/p/original" + (movieDetail?.backdrop_path ?? "") 
            self.moviewPosterImageView.sd_setImage(with: URL(string: imagePosterUrl), completed: nil)
            
            self.movieCompanyImageView.sd_setImage(with: URL(string: imagePosterUrl), completed: nil)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieCompanyImageView.layer.cornerRadius = movieCompanyImageView.frame.width / 2
        movieCompanyImageView.clipsToBounds = true
        moviewPosterImageView.layer.cornerRadius = 7
        moviewPosterImageView.clipsToBounds = true
    }
}
