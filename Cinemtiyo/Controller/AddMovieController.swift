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
    @IBOutlet weak var movieNoteTextView: UITextView!
    
    var movieTile: String? {
        didSet {
            movieLabel.text = movieTile ?? ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addToWatchListButtonPressed() {
        saveWatchListToCoreData(movieLabel.text ?? "", movieNoteTextView.text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func saveWatchListToCoreData(_ movieName: String, _ movieNote: String){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let watchList = WatchListMovie(context: context)
        watchList.movieName = movieName
        watchList.movieNote = movieNote
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}
