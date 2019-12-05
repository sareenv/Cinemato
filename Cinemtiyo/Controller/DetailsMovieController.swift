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
    @IBOutlet weak var addWatchList: UIButton!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    
    var movie: Movie? = nil
    let padding:CGFloat = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailerButtonSettings()
        setupNavigation()
        setupDetails()
        imagesCollectionViewSettings()
    }
    
    fileprivate func imagesCollectionViewSettings() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
    }
    
    @IBAction func watchTrailer() {
        // here goes the avplayer.
    }
    
    @IBAction func addtoWatchList() {
        // to watch list and store it in the core data for the presistance.
    }
    
    fileprivate func trailerButtonSettings(){
        trailerButton.layer.cornerRadius = 20
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

extension DetailsMovieController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedWidth = (self.imagesCollectionView.frame.width - 15)/3
        print(estimatedWidth)
        return .init(width: estimatedWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieImageCell", for: indexPath)
        cell.backgroundColor = UIColor.green
        return cell
    }
    
    
    
    
}


