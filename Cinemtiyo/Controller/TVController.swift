
import UIKit
import Combine


class TVController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let searchMessageLabel: UILabel = UILabel(font: .systemFont(ofSize: 14), text: "Please search the TV Shows", alignment: .center)
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "TV Shows"
        setupSearchBar()
    }
    
    let tvSearchController = UISearchController()
    
    fileprivate func setupSearchBar() {
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
    var data = [TVShow]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchMessageLabel.isHidden = (data.count == 0) ? false : true
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tvCell", for: indexPath) as! TVCell
        cell.data = data[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let estimatedWidth = view.frame.width / 3 - 10
        let size = CGSize(width: estimatedWidth, height: 180)
        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    fileprivate func setupSearchBarListener() {
        let textField: UISearchTextField = tvSearchController.searchBar.searchTextField
        
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: textField)
        
        publisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) .sink { notification in
                guard let title = textField.text else { return }
                DispatchQueue.main.async {
                    Api.instance.searchTVShows(tvShowName: title) { error, shows in
                        self.data = []
                        self.data = shows?.results ?? []
                    }
                }
                
        }.store(in: &cancellables)
    }
    
    fileprivate func fetchTrendingShows() {
        Api.instance.downloadTrendingShows { errors, shows in
            guard let showData = shows?.results else { return }
            self.data = showData
        }
    }
    
    
    override func viewDidLoad() {
        collectionViewSettings()
        setupSearchBarListener()
        fetchTrendingShows()
    }
    
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
