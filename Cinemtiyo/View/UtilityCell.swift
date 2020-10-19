//
//  UtilityCell.swift
//  Cinemtiyo
//
//  Created by DataBunker on 18/10/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit
import AVKit
import XCDYouTubeKit

class UtilitesCell: UICollectionViewCell {
    var movie: Movie?
    
    fileprivate func playVideo(videoKey: String){
        XCDYouTubeClient.default().getVideoWithIdentifier(videoKey) { (video, error) in
            if let streamURL = video?.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue]{
                let playerController = AVPlayerViewController()
                playerController.player = AVPlayer(url: streamURL)
                let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
                keyWindow?.rootViewController?.present(playerController, animated: true) {
                    playerController.player?.play()
                }
            }
        }
    }
    
    
    let watchTrailerButton = {() -> UIButton in
        let btn = UIButton(type: .system)
        btn.setTitle("Watch Trailer", for: .normal)
        btn.backgroundColor = .purple
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(watchTrailerButton)
        watchTrailerButton.fillSuperView()
        watchTrailerButton.addTarget(self, action: #selector(handleBtn), for: .touchUpInside)
    }
    
    @objc func handleBtn() {
        let fetchMovieDetailsApi = Api.instance
        fetchMovieDetailsApi.downloadTrailers(movieId: movie?.id ?? 0) { (error, trailer) in
            if(trailer?.results.count ?? 0 <= 0) { return }
            DispatchQueue.main.async {
                self.playVideo(videoKey: trailer?.results[0].key ?? "")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
}
