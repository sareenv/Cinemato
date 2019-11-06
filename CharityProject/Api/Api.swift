//
//  Api.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 06/11/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import Foundation

/* Singleton Pattern
    The class below shows the singleton pattern, as shown below the init method of the class
    is private so, the user cannot directly create the instance of the class. We need toaccess the static property called instance with instantiate the class and cannot be override. Therefore, there only exist one instance of this class.
 */

class Api{
    private init(){}
    static let instance = Api()
    
    static func downloadData(){
        let session = URLSession.shared
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=48011e814c676dd12ae5d6e76288b2ae&language=en-US&page=1&include_adult=false&query=spiderman") else { return }
        session.dataTask(with: url) { (data, response, error) in
            if (error != nil){
                return
            }
            print(data ?? "")
        }.resume()
    }
}
