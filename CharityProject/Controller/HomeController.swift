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
        apiFetch()
    }
    
    fileprivate func apiFetch(){
        let api = Api.instance
        Api.downloadData()
    }
    
    fileprivate func tableViewSettings(){
        let charityOrganisationNib = UINib(nibName: "CharityOrganisationCell", bundle: nil)
        let headerCellNib = UINib(nibName: "HeaderCell", bundle: nil)
        let topDonatorNib = UINib(nibName: "TopDonators", bundle: nil)
        
        charityTableView.register(charityOrganisationNib, forCellReuseIdentifier: "charityOrgCell")
        charityTableView.register(headerCellNib, forCellReuseIdentifier: "HeaderCell")
        charityTableView.register(topDonatorNib, forCellReuseIdentifier: "topDonatorsCell")
    
    
        charityTableView.showsVerticalScrollIndicator = false
        charityTableView.separatorStyle = .none
        charityTableView.delegate = self
        charityTableView.dataSource = self
        charityTableView.estimatedRowHeight = 40
    }
    
    fileprivate func openState(){
        isFirstTime.set(true, forKey: "hasOpenBefore")
    }
}


extension HomeController{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = charityTableView.dequeueReusableCell(withIdentifier: "HeaderCell")
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let estimatedHeaderHeight = 20 * (self.view.frame.height / 100) // this will be 20% of the width
        return estimatedHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 10
      }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = indexPath.row == 4 ? tableView.dequeueReusableCell(withIdentifier: "topDonatorsCell", for: indexPath) : tableView.dequeueReusableCell(withIdentifier: "charityOrgCell", for: indexPath) as! CharityOrganisationCell
        return cell
        
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 4){
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        // push to navigation controller.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(translationX: -20, y: 0)
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1.5
            cell.transform = .identity
        }
    }
    
}


