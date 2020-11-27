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


extension UIColor {

    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return dark
                }
                return light
            }
        }
        else {
            self.init(cgColor: light.cgColor)
        }
    }
}

extension UIView {
    
    func fillSuperView(paddingLeft: CGFloat?=nil) {
        if let paddingLeft = paddingLeft {
            self.translatesAutoresizingMaskIntoConstraints = false
            guard let superView = self.superview else { return }
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: paddingLeft).isActive = true
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive = true
        } else {
            self.translatesAutoresizingMaskIntoConstraints = false
            guard let superView = self.superview else { return }
            self.topAnchor.constraint(equalTo: superView.topAnchor, constant: 0).isActive = true
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive = true
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive = true
        }
    }
}

extension UIImageView {
    convenience init(image: UIImage, contentMode: UIView.ContentMode, translateResizingMask: Bool = false) {
        self.init(frame: .zero)
        self.image = image
        self.contentMode = contentMode
        self.translatesAutoresizingMaskIntoConstraints = translateResizingMask
    }
}



extension UILabel {
    
    convenience init(font: UIFont, text: String, alignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.font  = font
        self.text = text
        self.textAlignment = alignment
    }
}


extension UIColor {
    static func rgb(red: Float, green: Float, blue: Float, alpha: Double = 1) -> UIColor {
        let redColor = CGFloat(red / 255)
        let greenColor = CGFloat(green / 255)
        let blueColor = CGFloat(blue / 255)
        let color = self.init(red: redColor, green: greenColor, blue: blueColor, alpha: CGFloat(alpha))
        return color
    }
    
    /*
        Code from Hacking with Swift
        https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
     */
    
    public convenience init?(hex: String) {
           let r, g, b, a: CGFloat

           if hex.hasPrefix("#") {
               let start = hex.index(hex.startIndex, offsetBy: 1)
               let hexColor = String(hex[start...])

               if hexColor.count == 8 {
                   let scanner = Scanner(string: hexColor)
                   var hexNumber: UInt64 = 0

                   if scanner.scanHexInt64(&hexNumber) {
                       r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                       g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                       b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                       a = CGFloat(hexNumber & 0x000000ff) / 255

                       self.init(red: r, green: g, blue: b, alpha: a)
                       return
                   }
               }
           }

           return nil
       }
}



class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
