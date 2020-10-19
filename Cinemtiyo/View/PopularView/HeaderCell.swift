//
//  HeaderCell.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 21/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit
import AVKit
import XCDYouTubeKit

class HeaderCell: UITableViewCell {
    @IBOutlet weak var headerSliderCollectionView: UICollectionView!
    
    let cellId = "HeaderCell"
    
    var headerData: [Movie] = []{
        didSet{
            self.headerSliderCollectionView.reloadData()
        }
    }
    
    fileprivate func collectionViewSettings() {
        // Initialization code
        self.translatesAutoresizingMaskIntoConstraints = false
        headerSliderCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        headerSliderCollectionView.register(CustomHeaderElementCell.self, forCellWithReuseIdentifier: "cellId")
        headerSliderCollectionView.register(CustomHeaderElementCell.self, forCellWithReuseIdentifier: cellId)
        headerSliderCollectionView.isPagingEnabled = false
        headerSliderCollectionView.delegate = self
        headerSliderCollectionView.dataSource = self
        headerSliderCollectionView.showsHorizontalScrollIndicator = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewSettings()
        fetchTrendingData()
    }
    
    
    fileprivate func fetchTrendingData(){
        let api = Api.instance
        api.downloadTrendingMovies { (error, data)  in
            if(error != nil){
                return
            }
            // Update the cell
            DispatchQueue.main.async {
                // update the cells.
                guard let data = data else { return }
                self.headerData = data.results
            }
        }
    }
}

extension HeaderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CustomHeaderElementCell
        cell.headerElementImageView.downloadUrlImage(imageUrlPath: headerData[indexPath.item].backdrop_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedWidth = self.frame.width / 1.2 - 20
        let estimatedHeight = self.frame.height - 38
        return .init(width: estimatedWidth, height: estimatedHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    fileprivate func playTrailer(videoKey: String){
            let avPlayerController = AVPlayerViewController()
            XCDYouTubeClient.default().getVideoWithIdentifier(videoKey) { (video, error) in
            if let streamURL = video?.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue]{
                avPlayerController.player = AVPlayer(url: streamURL)
                let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
                keyWindow?.rootViewController?.present(avPlayerController, animated: true, completion: {
                    avPlayerController.player?.play()
                })
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fetchMovieDetailsApi = Api.instance
        fetchMovieDetailsApi.downloadTrailers(movieId: headerData[indexPath.item].id ?? 1 ) { [unowned self] (error, trailer) in
            if(trailer?.results.count ?? 0 <= 0) { return }
            DispatchQueue.main.async {
                self.playTrailer(videoKey: trailer!.results[0].key)
            }
        }
    }
    
}


