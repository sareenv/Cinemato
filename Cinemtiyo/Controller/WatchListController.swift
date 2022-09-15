//
//  WatchListController.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 05/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit
import CoreData


class WatchListController: UITableViewController {
    
    let watchListMessageLabel: UILabel = UILabel(font: .systemFont(ofSize: 14), text: "No movies or shows are saved to watch list.", alignment: .center)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var moviesWatchList: [WatchListMovie] = [WatchListMovie]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    fileprivate func setupLabel() {
        self.tableView.addSubview(watchListMessageLabel)
        watchListMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        watchListMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        watchListMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.reloadData()
    }
    
    fileprivate func fetchData(){
        do{
            moviesWatchList = try context.fetch(WatchListMovie.fetchRequest())
        } catch {
            print("Fetch Failed")
        }
    }
    
    fileprivate func tableViewSettings() {
        tableView.rowHeight = 70
        tableView.register(BookMarkCell.self, forCellReuseIdentifier: "customMovieCell")
        tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings()
        navigationSettings()
        setupLabel()
    }
    
    fileprivate func navigationSettings() {
        self.navigationItem.title = "Watch List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.separatorStyle = (moviesWatchList.count == 0) ? .none : .singleLine
        watchListMessageLabel.isHidden = (moviesWatchList.count == 0) ? false : true
        return moviesWatchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMovieCell", for: indexPath) as! BookMarkCell
        let movie = moviesWatchList[indexPath.row]
        cell.textLabel?.text = movie.movieName ?? ""
        cell.textLabel?.font = .boldSystemFont(ofSize: 14)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = movie.movieDescription ?? ""
        cell.detailTextLabel?.numberOfLines = 2
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.present(FriendsController(), animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               let deletionTask = self.moviesWatchList[indexPath.row]
               context.delete(deletionTask)
               (UIApplication.shared.delegate as! AppDelegate).saveContext()
               do {
                    self.moviesWatchList = try context.fetch(WatchListMovie.fetchRequest())
               } catch {
                     print("Fetching Failed")
                }
            }
            tableView.reloadData()
    }
}

