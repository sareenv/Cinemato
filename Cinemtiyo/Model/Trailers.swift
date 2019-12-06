//
//  Trailers.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 05/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import Foundation

struct Trailer: Decodable {
    let key: String
    let name: String
}

struct Trailers: Decodable {
    let results: [Trailer]
}
