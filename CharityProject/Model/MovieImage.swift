//
//  MovieImage.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 11/11/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

struct MovieImage: Decodable{
    let file_path: String
    let height: Double
    let width: Double
}


struct MovieImages: Decodable{
    let backdrops: [MovieImage]
}
