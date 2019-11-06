//
//  DetailsController.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 30/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//


/*
 
 Setting the touches delayed to false is not working anymore which ensures that there is no delay when the button is pressed which is present in tableViewCell. However, it is not working anymore, because now in the view hirechy the scollview is present in tableView which further has the contentView so, the code helps to add touches delayed to false on scroll view.
 
 https://stackoverflow.com/questions/31700012/delayscontenttouches-false-not-working-in-uitableview-swift
 
 */


import UIKit

class DetailsController: UITableViewController{
    
    @IBOutlet weak var donationAmountCollectedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.showsVerticalScrollIndicator = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
        /*
         CADisplayLink:- A smart and fast way to draw and ativates based of frames per second.
         Referance Sources :
         https://www.hackingwithswift.com/example-code/system/how-to-synchronize-code-to-drawing-using-cadisplaylink
         
         https://www.youtube.com/watch?v=b3kZH1vfG2U&t=2s
         **/
        let displayLink = CADisplayLink(target: self, selector: #selector(handleAnimation))
        displayLink.add(to: .current, forMode: .common)
    }
        
    @objc func handleAnimation(){
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
}
