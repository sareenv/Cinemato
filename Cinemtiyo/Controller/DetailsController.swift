//
//  DetailsController.swift
//  Cinemtiyo
//
//  Created by DataBunker on 30/09/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit


class DetailsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                updateMoviesDetails(movie: movie)
            }
        }
    }
    
    lazy var movieImages: [MovieImage] = [MovieImage]() {
        didSet {
            self.data[0] = movieImages
            self.collectionView.reloadData()
        }
    }
    
    lazy var movieCast: [MovieCast] = [MovieCast]() {
        didSet {
            self.data[4] = movieCast
            self.collectionView.reloadData()
        }
    }
    
    lazy var similarMovies: [Movie] = [Movie](){
        didSet {
            self.data[6] = similarMovies
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func updateTVShow(tvShow: TVShow?) {
        guard let show = tvShow else { return }
        self.navigationItem.title = "TVShow Details"
        
        let api = Api.instance
        guard let showID = show.id else { return }
        api.downloadWallImages(id: showID) { [unowned self] (error, movieImages) in
            if (error != nil) { return }
            guard let images = movieImages?.backdrops else { return }
            DispatchQueue.main.async {
                self.movieImages = images
            }
        }
    }
    
    
    fileprivate func updateMoviesDetails(movie: Movie) {
        navigationSettings()
        let api = Api.instance
        guard let movieId = movie.id else { return }
        api.downloadWallImages(id: movieId) { [unowned self] (error, movieImages) in
            if (error != nil) { return }
            guard let images = movieImages?.backdrops else { return }
            DispatchQueue.main.async {
                self.movieImages = images
            }
        }
        
        api.downloadMovieCast(id: movieId) { (error, cast) in
            if (error != nil) { return }
            DispatchQueue.main.async {
                guard let castinformation = cast else { return }
                self.movieCast = castinformation.cast
            }
        }
        
    }

    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.compositionalLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    fileprivate func setupLeadingNavigationItem() {
        var bookMarkimage = UIImage(systemName: "bookmark")
    
        bookMarkMovies.forEach { (bookMarkMovie) in
            if(movie?.id ?? 0 == bookMarkMovie.movieId) {
                bookMarkimage = UIImage(systemName: "bookmark.fill")
            }
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: bookMarkimage, style: .plain, target: self, action: #selector(handleBookMark))
    }
    
    var bookMarkMovies: [WatchListMovie] = [WatchListMovie]() {
        didSet {
            setupLeadingNavigationItem()
        }
    }
    
    fileprivate func fetchBookMarkMovies() {
        do {
            bookMarkMovies = try context.fetch(WatchListMovie.fetchRequest())
        }catch {
            print("Error is \(error)")
        }
    }
    
    fileprivate func navigationSettings() {
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Movie Details"
        let backItem = UIBarButtonItem()
        backItem.title = "back"
        self.navigationItem.backBarButtonItem = backItem
    }
    
    @objc func handleBookMark() {
        let watchList = WatchListMovie(context: context)
        watchList.movieName = movie?.title
        watchList.movieId = Int32(UInt32(movie?.id ?? 0))
        watchList.movieDescription = movie?.overview ?? ""
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        let bookMarkimage = UIImage(systemName: "bookmark.fill")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: bookMarkimage, style: .plain, target: self, action: #selector(handleBookMark))
    }
    
    fileprivate func collectionViewSettings() {
        collectionView.contentInset.top = 10
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MoviesImageHeaderCell.self, forCellWithReuseIdentifier: "cellId1")
        collectionView.register(MovieInformationCell.self, forCellWithReuseIdentifier: "informationCell")
        collectionView.register(TitleOverViewCell.self, forCellWithReuseIdentifier: "titleOverviewCell")
        collectionView.register(MovieCastCell.self, forCellWithReuseIdentifier: "cellId2")
        collectionView.register(SimilarMoviesCell.self, forCellWithReuseIdentifier: "similarCell")
        collectionView.register(UtilitesCell.self, forCellWithReuseIdentifier: "utilCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func fetchSimilarMovies() {
        let api = Api.instance
        if let movieId = self.movie?.id {
            api.downloadSimilarMovies(movieId: movieId) { (error, movies) in
                if (error != nil) { return }
                DispatchQueue.main.async {
                    if let movies = movies?.results {
                        self.similarMovies = movies
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationSettings()
        fetchBookMarkMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.fillSuperView()
        fetchSimilarMovies()
        collectionViewSettings()
    }
    
    lazy var data: [[Any]] = [movieImages, [""], [""] ,[""] ,movieCast, [""], similarMovies ]
    
}




extension DetailsController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let items = data[section].count
        return items
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 4) {
            let cell = collectionView.cellForItem(at: indexPath) as! MovieCastCell
            guard let moviePosterImage = cell.castImageView.image else { return }
            UIView.animate(withDuration: 0.3) {
                let actorController = ActorViewController(collectionViewLayout: UICollectionViewFlowLayout())
                actorController.data = self.movieCast
                self.present(actorController, animated: true)
            }
        }
        
        if(indexPath.section == 6) {
            let movieController = DetailsController()
            let selectedMovie = similarMovies[indexPath.item]
            movieController.movie = selectedMovie
            self.navigationController?.pushViewController(movieController, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId1", for: indexPath) as! MoviesImageHeaderCell
            let movieImage = data[indexPath.section][indexPath.item] as? MovieImage
            cell.movieImage = movieImage?.file_path
            return cell
        }else if (indexPath.section == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "informationCell", for: indexPath) as! MovieInformationCell
            cell.movie = movie
            return cell
        }else if (indexPath.section == 2) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "utilCell", for: indexPath) as! UtilitesCell
            cell.movie = movie
            return cell
        }else if (indexPath.section == 3) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleOverviewCell", for: indexPath) as! TitleOverViewCell
            cell.titleOverView = "Movie Cast"
            return cell
        }
        else if (indexPath.section == 4) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId2", for: indexPath) as! MovieCastCell
            cell.cast = data[indexPath.section][indexPath.item] as? MovieCast
            return cell
        }
        
        else if (indexPath.section == 5) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "titleOverviewCell", for: indexPath) as! TitleOverViewCell
            cell.titleOverView = "Recommended Movies"
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "similarCell", for: indexPath) as! SimilarMoviesCell
            cell.movie = similarMovies[indexPath.row]
            return cell
        }
    }
}


