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
    
    @IBOutlet weak var moviesTitle: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieCompanyImageView: UIImageView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    

    var movieDetail: Movie?{
        didSet{
            self.moviesTitle.text = movieDetail?.title
            self.movieReleaseDateLabel.text = movieDetail?.release_date
            self.descriptionLabel.text = movieDetail?.overview
            let imageUrl = URL(string: "http://image.tmdb.org/t/p/original"+(movieDetail?.backdrop_path ?? movieDetail?.poster_path ?? ""))
            self.moviePosterImageView?.sd_setImage(with: imageUrl, completed: nil)
            self.movieCompanyImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieCompanyImageView.layer.masksToBounds = true
        movieCompanyImageView.layer.cornerRadius = 20
        movieCompanyImageView.contentMode = .scaleAspectFill
        moviePosterImageView.layer.cornerRadius = 7
        moviePosterImageView.clipsToBounds = true
    }
}
