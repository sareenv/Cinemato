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

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}



