//
//  TrendingMovies.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 08/11/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import Foundation

struct Movie: Decodable{
    let id: Int
    let release_date: String
    let original_language: String
    let title: String
    let overview: String
    let poster_path: String
    let backdrop_path: String
}

struct Movies: Decodable{
    let results: [Movie]
}
