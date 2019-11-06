//
//  DetailsCharity.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 24/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class DetailCharityController: UIViewController{
    
    @IBOutlet weak var donationTitle: UILabel!

    
    var initialValue = 0
    let donationAmmount = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
       
        /*
            Need some sort of percentage mechanism
        */
        
        if(initialValue < donationAmmount){
            initialValue = initialValue  + 1
//            recievedLabel.text = "£ \(initialValue)"
        }else{
//            recievedLabel.text = "£ \(donationAmmount)"
        }
    }
}
