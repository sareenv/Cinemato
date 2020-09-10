//
//  Sliders.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 04/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class SliderController: UICollectionViewController{

    fileprivate let cellId = "customCellId"
    fileprivate let cellId1 = "cellId1"
    
    let sliderContent: [SliderContent] = SliderContent.slides()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSettings()
        navigationSettings()
    }
    
    
    fileprivate func collectionViewSettings(){
        collectionView.delaysContentTouches = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collectionView.register(SliderCell.self, forCellWithReuseIdentifier: cellId)
        
        let signupNib = UINib(nibName: "SliderSignupCellCollectionViewCell", bundle: nil)
        collectionView.register(signupNib, forCellWithReuseIdentifier: cellId1)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.scrollDirection = .horizontal
    }
    
  
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SliderCell
        cell.customDelegate = self
        cell.sliderContent = sliderContent[indexPath.item]
        cell.slideId = indexPath.item
        cell.pageControl.currentPage = indexPath.item
        cell.backgroundColor = .white
        return cell
    }
    
    
    
    fileprivate func navigationSettings(){
        self.navigationController?.isNavigationBarHidden = true
    }
     
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension SliderController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension SliderController: CellButtonDetect{
    func detectButtonPressed() {
        let controller = CinematoTabBarController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
}


