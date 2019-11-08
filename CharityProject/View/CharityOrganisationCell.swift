//
//  CharityOrganisationCell.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 21/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class CharityOrganisationCell: UITableViewCell {
    
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
            self.moviePosterImageView.downloadUrlImage(imageUrlPath: movieDetail?.backdrop_path ?? movieDetail?.poster_path ?? "")
            self.movieCompanyImageView.downloadUrlImage(imageUrlPath: movieDetail?.backdrop_path ?? movieDetail?.poster_path ?? "")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieCompanyImageView.layer.cornerRadius = movieCompanyImageView.frame.width / 2
        movieCompanyImageView.clipsToBounds = true
        moviePosterImageView.layer.cornerRadius = 7
        moviePosterImageView.clipsToBounds = true
    }
}
