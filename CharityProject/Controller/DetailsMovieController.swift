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
    @IBOutlet weak var attributesCollectionView: UICollectionView!
    
    var movie: Movie? = nil
    var movieCoverImagesUrlPath: [MovieImage]? {
        didSet{
            self.attributesCollectionView.reloadData()
        }
    }
    
    let padding:CGFloat = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupDetails()
        downloadWallImages()
        collectionViewSettings()
    }
    
    fileprivate func downloadWallImages(){
        let api = Api.instance
        api.downloadWallImages(id: self.movie?.id ?? 420818) { (error, images) in
            DispatchQueue.main.async {
                self.movieCoverImagesUrlPath = images?.backdrops
            }
        }
    }
    
    fileprivate func collectionViewSettings(){
        attributesCollectionView.register(MovieCoverImageCell.self, forCellWithReuseIdentifier: "attributesCell")
        let layout = attributesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        attributesCollectionView.delegate = self
        attributesCollectionView.dataSource = self
    }
    
    fileprivate func setupDetails(){
        movieTitleLabel.text = movie?.title ?? ""
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
        return movieCoverImagesUrlPath?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "attributesCell", for: indexPath) as! MovieCoverImageCell
        cell.imageUrlPath = self.movieCoverImagesUrlPath?[indexPath.item].file_path
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width / 1.5, height: self.attributesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: padding, bottom: 0, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class MovieCoverImageCell: UICollectionViewCell{
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var imageUrlPath: String?{
        didSet{
            let urlPath = "http://image.tmdb.org/t/p/w500\(imageUrlPath ?? "")"
            self.backgroundImageView.sd_setImage(with: URL(string: urlPath))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundImageView()
        
    }
    
    fileprivate func setupBackgroundImageView(){
        addSubview(backgroundImageView)
        backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("error init the cell")
    }
    
}
