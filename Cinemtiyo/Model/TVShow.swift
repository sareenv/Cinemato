//
//  TVShow.swift
//  Cinemtiyo
//
//  Created by DataBunker on 2022-07-04.
//  Copyright © 2022 Vinayak Sareen. All rights reserved.
//

import Foundation

struct TVShow: Decodable {
    let id: Int?
    let name: String?
    let overview: String?
    let vote_average: Double?
    let poster_path: String?
    let backdrop_path: String?
}


struct TVShows: Decodable {
    var results: [TVShow]
}
