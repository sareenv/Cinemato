//
//  HeaderCell.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 21/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    @IBOutlet weak var headerSliderCollectionView: UICollectionView!
    
    let cellId = "HeaderCell"
    
    var headerData: [Movie] = []{
        didSet{
            self.headerSliderCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.translatesAutoresizingMaskIntoConstraints = false
        headerSliderCollectionView.register(CustomHeaderElementCell.self, forCellWithReuseIdentifier: "cellId")
        headerSliderCollectionView.register(CustomHeaderElementCell.self, forCellWithReuseIdentifier: cellId)
        headerSliderCollectionView.isPagingEnabled = false
        headerSliderCollectionView.delegate = self
        headerSliderCollectionView.dataSource = self
        headerSliderCollectionView.showsHorizontalScrollIndicator = false
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
        cell.headerElementImageView.downloadUrlImage(imageUrlPath: headerData[indexPath.item].backdrop_path)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.frame.width / 1.6 - 20, height: self.frame.height - 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        
        /*
         This needs to be replaced with the viewController'sView.
         */
        let sview = UIView()
        sview.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        /* referance:
         The keywindow is the shared window which acts the base of the herirachy.
         https://stackoverflow.com/questions/57134259/how-to-resolve-keywindow-was-deprecated-in-ios-13-0
         */
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        keyWindow?.addSubview(sview)
        
        sview.frame = CGRect(x: 0, y: 0, width:  120, height: 120)
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
            sview.frame = CGRect(x: 0, y: 0, width: keyWindow?.frame.width ?? 120, height: keyWindow?.frame.height ?? 120)
        })
        
    }
    
}


class CustomHeaderElementCell: UICollectionViewCell{
    
    let headerElementImageView: UIImageView = {
        let iv = UIImageView()
       
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "charity1") // this needs to be replaced with datasource option.
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLayout()
    }
    
    fileprivate func addLayout(){
        self.addSubview(headerElementImageView)
        
        headerElementImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        headerElementImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        headerElementImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        headerElementImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        headerElementImageView.layer.cornerRadius = 7
        headerElementImageView.clipsToBounds = true
    }
    
    @objc func handleElementTapped(){
        print("123123")
    }
    
    required init?(coder: NSCoder) {
        fatalError("Some error")
    }
}
