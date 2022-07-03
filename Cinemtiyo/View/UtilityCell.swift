//
//  UtilityCell.swift
//  Cinemtiyo
//
//  Created by DataBunker on 18/10/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import UIKit
import AVKit
import YouTubeiOSPlayerHelper


class UtilitesCell: UICollectionViewCell {
    var movie: Movie?
   
    
    fileprivate func playVideo(videoKey: String){
        print("Playing content")
        let keyWindow = UIApplication.shared.windows.first {$0.isKeyWindow}
        let view: YTPlayerView = {
            let view = YTPlayerView(frame: .zero)
            view.backgroundColor = .red
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        keyWindow?.rootViewController?.view.addSubview(view)
        view.load(withVideoId: videoKey)
        view.playVideo()
        
        view.fillSuperView()
    }
    
    
    let watchTrailerButton = {() -> UIButton in
        let btn = UIButton(type: .system)
        btn.setTitle("Watch Trailer", for: .normal)
        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.tintColor = .black
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
