
import UIKit


class TVController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let searchMessageLabel: UILabel = UILabel(font: .systemFont(ofSize: 14), text: "Please search the TV Shows", alignment: .center)
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "TV Shows"
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        let tvSearchController = UISearchController()
        tvSearchController.searchBar.placeholder = "Enter the TV Show"
        tvSearchController.hidesNavigationBarDuringPresentation = false
        tvSearchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = tvSearchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    fileprivate func setupLabel() {
        self.collectionView.addSubview(searchMessageLabel)
        searchMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        searchMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        searchMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    fileprivate func collectionViewSettings() {
        setupLabel()
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(TVCell.self, forCellWithReuseIdentifier: "tvCell")
    }
    
    // this needs to be changed as per the schema of TVShows
    let data = [String]()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchMessageLabel.isHidden = (data.count == 0) ? false : true
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tvCell", for: indexPath) as! TVCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedWidth = view.frame.width / 3 - 10
        let size = CGSize(width: estimatedWidth, height: 150)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func viewDidLoad() {
        collectionViewSettings()
    }
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class TVCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
