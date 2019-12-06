//
//  DetailsMovieController.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 10/11/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit
import SDWebImage
import AVKit
import XCDYouTubeKit

class DetailsMovieController: UIViewController{
    
    @IBOutlet weak var movieCoverPoster: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var addWatchList: UIButton!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var locateCinemaButton: UIButton!
    
    
    var movie: Movie? = nil
    var images: [MovieImage]?{
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.imagesCollectionView.reloadData()
            }
        }
    }
    
    
    let padding:CGFloat = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailerButtonSettings()
        setupNavigation()
        setupDetails()
        imagesCollectionViewSettings()
        fetchMovieImages()
    }
    
    
    fileprivate func fetchMovieImages() {
        let api = Api.instance
        api.downloadWallImages(id: movie?.id ?? 0) { (error, images) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                self.images = images?.backdrops
            }
        }
    }
    
    
    fileprivate func imagesCollectionViewSettings() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self        
    }
    
    fileprivate func playVideo(videoKey: String){
        XCDYouTubeClient.default().getVideoWithIdentifier(videoKey) { [unowned self] (video, error) in
            if let streamURL = video?.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue]{
                let playerController = AVPlayerViewController()
                playerController.player = AVPlayer(url: streamURL)
                self.present(playerController, animated: true) {
                    playerController.player?.play()
                }
            }
        }
    }
    
    @IBAction func watchTrailer() {
        // here goes the avplayer.
        print("Playing the trailer video")
        let fetchMovieDetailsApi = Api.instance
        fetchMovieDetailsApi.downloadTrailers(movieId: movie?.id ?? 0) { (error, trailer) in
            if(trailer?.results.count ?? 0 <= 0) { return }
            DispatchQueue.main.async {
                self.playVideo(videoKey: trailer?.results[0].key ?? "")
            }
        }
        
    }
    
    @IBAction func addtoWatchList() {
        // to watch list and store it in the core data for the presistance.
        print("123123")
        tabBarController?.tabBar.items?[1].badgeValue = "1"
    }
    
    fileprivate func trailerButtonSettings(){
        trailerButton.layer.cornerRadius = 8
        trailerButton.clipsToBounds = true
        addWatchList.layer.cornerRadius = 5
        addWatchList.clipsToBounds = true
        locateCinemaButton.layer.cornerRadius = 5
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
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedWidth = (self.imagesCollectionView.frame.width - 15)/3
        return .init(width: estimatedWidth, height: 120)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieImageCell", for: indexPath) as! CustomImageCell
        let imagePath = "http://image.tmdb.org/t/p/original" + (images?[indexPath.item].file_path ?? "")
        cell.movieImageView.sd_setImage(with: URL(string: imagePath), completed: nil)
        
        cell.movieImageView.contentMode = .scaleAspectFill
        cell.movieImageView.clipsToBounds = true
        //guard let image = cell.movieImageView.image else { return cell}
        return cell
    }

}


