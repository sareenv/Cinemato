//
//  SearchController.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 06/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class SearchController: UITableViewController{
    
    var searchResults: [String]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings()
        navigationSettings()
    }
    
    fileprivate func tableViewSettings() {
        tableView.rowHeight = 120
    }
    
    fileprivate func navigationSettings() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieSearch", for: indexPath )
        cell.textLabel?.text = "Avangers"
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "Avangers is really great movie"
        cell.detailTextLabel?.numberOfLines = 0
        cell.imageView?.image = #imageLiteral(resourceName: "movie")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
