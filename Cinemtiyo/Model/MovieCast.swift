//
//  MovieCast.swift
//  Cinemtiyo
//
//  Created by DataBunker on 02/10/2020.
//  Copyright © 2020 Vinayak Sareen. All rights reserved.
//

import Foundation

struct MovieCast: Decodable {
    let cast_id: Int?
    let character: String?
    let profile_path: String?
    let name: String?
}

struct Cast: Decodable {
    let cast: [MovieCast]
}
