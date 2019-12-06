//
//  TVController.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 06/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit


class TVController: UITableViewController{

    let data: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings()
    }
    
    fileprivate func tableViewSettings(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TVControllerCell")
        self.tableView.contentInset = UIEdgeInsets(top: 35,left: 0,bottom: 0,right: 0)
        tableView.tableFooterView = UIView()
        tableView.separatorEffect = .none
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
}
