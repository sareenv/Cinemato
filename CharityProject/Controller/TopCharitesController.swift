//
//  TopCharitesController.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 01/11/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class TopCharitesController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

    let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Trending Charites"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationSetting()
        collectionViewSettings()
    }
    
    fileprivate func navigationSetting(){
        self.navigationItem.title = "Trending Charities"
    }
    
    fileprivate func collectionViewSettings(){
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    
        layout.scrollDirection = .horizontal
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.automaticallyAdjustsScrollIndicatorInsets = false
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView.isPagingEnabled = true
        collectionView.register(TopCharitiesCell.self, forCellWithReuseIdentifier: "topCharityCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width - 24, height: self.view.frame.height / 1.4 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topCharityCell", for: indexPath) as! TopCharitiesCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
        
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


import AVFoundation

class TopCharitiesCell: UICollectionViewCell{
    
    /**
        The AVFoundation is apple's API for play media related files such as mp3, mp4 and other file.
        The fundamental element for playing the video is AVPlayer object, By instantiating the class of AVPlayerLayer, we can add AVPlayer to the layer of the view. The following video view will contain the playerlayer which will play the video on sub layer of the view and provide my application will custom element.
        Referance Source: AVPlayerLayer.
        https://riptutorial.com/ios/example/18195/playing-media-using-avplayer-and-avplayerlayer
     */
    
    let videoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 230).isActive = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        setupVideoView()
    }
    
    fileprivate func setupVideoView(){
        guard let pathUrl = Bundle.main.url(forResource: "education", withExtension: ".mp4") else { return }
        let player = AVPlayer(url: pathUrl)
//        player.externalPlaybackVideoGravity = .resizeAspectFill
        let playerLayer = AVPlayerLayer(player: player)
        videoView.layer.addSublayer(playerLayer)
        player.play()
        
        self.addSubview(videoView)
        videoView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        videoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        videoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("some error")
    }
    
}
