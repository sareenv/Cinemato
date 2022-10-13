//
//  ActorViewController.swift
//  Cinemtiyo
//
//  Created by DataBunker on 2022-10-12.
//  Copyright © 2022 Vinayak Sareen. All rights reserved.
//

import UIKit

class ActorViewController: UICollectionViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var data:[MovieCast]? = nil {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    private let cellId = "actorCellID"
    fileprivate func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}
