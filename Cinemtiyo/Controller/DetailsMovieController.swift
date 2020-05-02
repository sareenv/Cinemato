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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationSettings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trailerButtonSettings()
        setupNavigation()
        setupDetails()
        imagesCollectionViewSettings()
        fetchMovieImages()
        navigationSettings()
    }
    
    
    
    
    fileprivate func navigationSettings() {
        self.navigationController?.navigationBar.barTintColor = UIColor(light: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), dark: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        if #available(iOS 13.0, tvOS 13.0, *) {
            // check the dark mode status.
            if self.traitCollection.userInterfaceStyle == .dark {
                self.navigationController?.navigationBar.isTranslucent = false
            }else {
                 self.navigationController?.navigationBar.isTranslucent = true
            }
        }
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savetoWatchList" {
            if let nextViewController = segue.destination as? AddMovieController {
                nextViewController.movieName = movie?.title
            }
        }
    }
    
    
    @IBAction func locateCinema(_ sender: Any) {
        self.performSegue(withIdentifier: "cinemaMaps", sender: nil)
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
        self.performSegue(withIdentifier: "savetoWatchList", sender: nil)
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Index is \(indexPath.item)")
        let cell = collectionView.cellForItem(at: indexPath) as! CustomImageCell
        guard let moviePosterImage = cell.movieImageView.image else { return }
        let blackView = BlackView(frame: .zero, color: .black)
        blackView.selectedImage = moviePosterImage
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        keyWindow?.rootViewController?.view.addSubview(blackView)
        blackView.fillSuperView()
    }

}



class BlackView: UIView {
    
    var selectedImage: UIImage? {
        didSet {
            print("Im comming here")
            guard let image = selectedImage else { return }
            self.setupImageView(image: image)
        }
    }
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.backgroundColor = color
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    lazy var imageView = UIImageView()
    
    fileprivate func setupImageView(image: UIImage) {
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode  = .scaleAspectFill
        self.addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        imageView.isUserInteractionEnabled = true
        
        let tapGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTap))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        self.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension UIView {
    
    func fillSuperView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superView = self.superview else { return }
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive = true
    }
}

extension UIImageView {
    convenience init(image: UIImage, contentMode: UIView.ContentMode, translateResizingMask: Bool = false) {
        self.init(frame: .zero)
        self.image = image
        self.contentMode = contentMode
        self.translatesAutoresizingMaskIntoConstraints = translateResizingMask
    }
}

