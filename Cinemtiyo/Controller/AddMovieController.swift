//
//  AddMovieController.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 06/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class AddMovieController: UIViewController{
    
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    fileprivate func saveNotesToCoreData(_ movieName: String){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let watchList = WatchListMovie(context: context)
        watchList.movieName = movieName
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
