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
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var moviesWatchList: [WatchListMovie] = [WatchListMovie]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        self.tableView.reloadData()
    }
    
    fileprivate func fetchData(){
        do{
            moviesWatchList = try context.fetch(WatchListMovie.fetchRequest())
        } catch {
            print("Fetch Failed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customMovieCell")
        tableView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationSettings()
    }
    
    fileprivate func navigationSettings() {
        self.navigationItem.title = "Movies Watch List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesWatchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMovieCell", for: indexPath)
     let movie = moviesWatchList[indexPath.row]
     if let task = movie.movieName{
         cell.textLabel?.text = task
        cell.textLabel?.numberOfLines = 0
     }
        
    if let taskNote = movie.movieNote{
        cell.detailTextLabel?.text = taskNote
        cell.detailTextLabel?.numberOfLines = 0
        }
        return cell
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
