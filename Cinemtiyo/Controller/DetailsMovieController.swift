//
//  DetailsMovieController.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 10/11/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsMovieController: UIViewController{
    
    @IBOutlet weak var movieCoverPoster: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var attributesCollectionView: UICollectionView!
    
    
    var movie: Movie? = nil
  
    
    let padding:CGFloat = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailerButtonSettings()
        setupNavigation()
        setupDetails()
    }
    
    
    fileprivate func trailerButtonSettings(){
        trailerButton.layer.cornerRadius = 5
        trailerButton.clipsToBounds = true
    }
    
   
    
   
    fileprivate func setupDetails(){
        movieTitleLabel.text = movie?.title ?? ""
        movieDescriptionTextView.text = movie?.overview
              let imagePosterUrl = "http://image.tmdb.org/t/p/original" + (movie?.backdrop_path ?? "")
              movieCoverPoster.sd_setImage(with: URL(string: imagePosterUrl), completed: nil)
    }
    
    
    fileprivate func setupNavigation(){
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.navigationController?.navigationItem.backBarButtonItem?.title = "Back"
    }
    
}


