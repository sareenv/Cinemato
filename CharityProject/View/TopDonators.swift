//
//  TopDonators.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 24/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class TopDonators: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var topDonatorsCollectionView: UICollectionView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        topDonatorsCollectionView.delegate = self
        topDonatorsCollectionView.dataSource = self
        topDonatorsCollectionView.register(TopDonatorElementCell.self, forCellWithReuseIdentifier: "topDonatorCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 10
       }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topDonatorCell", for: indexPath) as! TopDonatorElementCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.frame.width / 3, height: self.frame.height)
    }
    
    
}

class TopDonatorElementCell: UICollectionViewCell{
    
    let donatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "me")
        return imageView
    }()
        
    let donatorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Vinney"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        let layoutStackView = UIStackView(arrangedSubviews: [donatorImageView, donatorNameLabel])
        layoutStackView.axis = .vertical
        layoutStackView.distribution = .fill
        layoutStackView.alignment = .center
        layoutStackView.spacing = 2
        addSubview(layoutStackView)
        layoutStackView.translatesAutoresizingMaskIntoConstraints = false
        layoutStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        layoutStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        layoutStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        layoutStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    

    required init?(coder: NSCoder) {
        fatalError("some error init topdonator cell")
    }
}

