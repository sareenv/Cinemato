//
//  ViewController.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 04/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var charityTableView: UITableView!
    let isFirstTime = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openState()
        tableViewSettings()
    }
    
    fileprivate func tableViewSettings(){
        charityTableView.delegate = self
        charityTableView.dataSource = self
        charityTableView.estimatedRowHeight = 40
    }
    
    fileprivate func openState(){
        isFirstTime.set(true, forKey: "hasOpenBefore")
    }
}


extension HomeController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 10
      }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charityCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
}


