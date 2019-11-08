//
//  ImageExtension.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 08/11/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

extension UIImageView{
    func downloadUrlImage(imageUrlPath: String) {
        let imagePosterUrl = "http://image.tmdb.org/t/p/original" + imageUrlPath
        let session = URLSession.shared
        guard let posterUrl = URL(string: imagePosterUrl) else { return }
        session.dataTask(with: posterUrl) { (data, resp, error) in
            if(error != nil){ return }
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.contentMode = .scaleAspectFill
                self.clipsToBounds = true
            }
        }.resume()
    }
}
