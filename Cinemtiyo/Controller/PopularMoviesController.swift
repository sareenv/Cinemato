//
//  ViewController.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 04/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit


class PopularMoviesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var moviesTableView: UITableView!
    
    let isFirstTime = UserDefaults.standard
    var selectedIndex = 0
    var timer: Timer?
    
    var movies: [Movie]?{
        didSet{
            self.moviesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSettings()
        fetchTrendingData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationSettings()
    }

    fileprivate func navigationSettings() {
        // fixed the color problem.
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(light: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), dark: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Please enter search term"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    fileprivate func fetchTrendingData(){
        let api = Api.instance
        api.downloadMovies(pageNumber: 1) { (error, movie) in
            if (error != nil) { return }
         
            DispatchQueue.main.async {
                guard let movie = movie else { return }
                self.movies = movie.results
            }
        }
    }
    
    fileprivate func tableViewSettings(){
        let popularMoviesNib = UINib(nibName: "PopularMoviesCell", bundle: nil)
        let headerCellNib = UINib(nibName: "HeaderCell", bundle: nil)
        moviesTableView.register(popularMoviesNib, forCellReuseIdentifier: "popularMoviesCell")
        moviesTableView.register(headerCellNib, forCellReuseIdentifier: "HeaderCell")
        moviesTableView.showsVerticalScrollIndicator = false
        moviesTableView.separatorStyle = .none
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.estimatedRowHeight = 40
    }

}

extension PopularMoviesController{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = moviesTableView.dequeueReusableCell(withIdentifier: "HeaderCell")
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let estimatedHeaderHeight = 32 * (self.view.frame.height / 100) // this will be 30% of the width
        return estimatedHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
      }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popularMoviesCell", for: indexPath) as! PopularMoviesCell
        cell.movieDetail = self.movies?[indexPath.item]
        return cell
      }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        let movie = self.movies?[selectedIndex]
        let detailsController = DetailsController()
        detailsController.hidesBottomBarWhenPushed = true
        detailsController.movie = movie
        self.navigationController?.pushViewController(detailsController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: -20, y: 0)
        UIView.animate(withDuration: 0.23) {
            cell.alpha = 1.5
            cell.transform = .identity
        }
    }
}


extension PopularMoviesController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.searchMovies(movieSearchTerm: searchText)
           
        })
    }
    
    func searchMovies(movieSearchTerm: String) {
        let api = Api.instance
        api.searchMovies(movieSearchTerm: movieSearchTerm) { (error, movie) in
            if (error != nil) { return }
         
            DispatchQueue.main.async {
                guard let movie = movie else { return }
                self.movies = movie.results
                self.moviesTableView.reloadData()
            }
        }
    }
    
}
