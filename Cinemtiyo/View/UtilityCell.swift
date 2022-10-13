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


class UtilitesCell: UICollectionViewCell, YTPlayerViewDelegate {
    var movie: Movie?
   
    lazy var view: YTPlayerView = {
        let view = YTPlayerView(frame: .zero)
        view.delegate = self
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // this view will help to remove the item when the closed btn is pressed.
    
    let playerView: UIView =  {
        let view = UIView(frame: .zero);
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = .black
        return view;
    }()
    
    
    fileprivate func playVideo(videoKey: String){
        
        let playerViewController = UIViewController()
        playerViewController.view.backgroundColor = .red
        let keyWindow = UIApplication.shared.windows.first {$0.isKeyWindow}
        keyWindow?.rootViewController?.present(playerViewController, animated: true)
        playerViewController.view.addSubview(playerView)
        playerView.fillSuperView()
        UIView.animate(withDuration: 0.40, delay: 0.24, options: .curveEaseOut) {
            self.playerView.alpha = 1.0
            self.playerView.addSubview(self.view)
            self.view.fillSuperView()
            self.view.load(withVideoId: videoKey)
        }
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        
    }
    
    let watchTrailerButton = {() -> UIButton in
        let btn = UIButton(type: .system)
        btn.setTitle("Watch Trailer", for: .normal)
//        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
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
