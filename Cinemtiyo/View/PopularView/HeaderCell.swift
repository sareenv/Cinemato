//
//  HeaderCell.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 21/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit
import AVKit

import MapKit

class HeaderCell: UITableViewCell, UIScrollViewDelegate{
    
    
    
    let headerSliderCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { sectionNumber, env in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1)), subitems: [item])
        
            group.contentInsets.leading = 0
            group.contentInsets.trailing = 12
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            
            return section
        })
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let cellId = "HeaderCell"
    
    var headerData: [Movie] = []{
        didSet{
            self.headerSliderCollectionView.reloadData()
        }
    }
    
    fileprivate func collectionViewSettings() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.headerSliderCollectionView.backgroundColor = .white
        self.contentView.addSubview(headerSliderCollectionView)
        headerSliderCollectionView.fillSuperView()
        headerSliderCollectionView.isPagingEnabled = true
        headerSliderCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        headerSliderCollectionView.register(CustomHeaderElementCell.self, forCellWithReuseIdentifier: cellId)
        headerSliderCollectionView.isPagingEnabled = false
        headerSliderCollectionView.delegate = self
        headerSliderCollectionView.dataSource = self
        headerSliderCollectionView.showsHorizontalScrollIndicator = false
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionViewSettings()
        fetchTrendingData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func fetchTrendingData(){
        
        let api = Api.instance
    
        api.downloadTrendingMovies { (error, data)  in
            if(error != nil){ fatalError() }
            // Update the cell
            DispatchQueue.main.async { [weak self] in
                guard let data = data else { return }
                self?.headerData = data.results
            }
        }
    }
}



extension HeaderCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomHeaderElementCell
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
        print(videoKey)
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


