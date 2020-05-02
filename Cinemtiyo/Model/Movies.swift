//
//  Movies.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 08/11/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import Foundation

struct Movie: Decodable{
    let id: Int?
    let title: String?
    let overview: String?
    let backdrop_path: String?
    let poster_path: String?
    let release_date: String?
}

struct Movies: Decodable {
    let results: [Movie]
}
