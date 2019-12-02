//
//  SliderContent.swift
//  CharityProject
//
//  Created by Vinayak Sareen on 09/10/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class SliderContent{
    let image: UIImage
    let content: String
    let description: String
    init(image: UIImage, content: String, description: String) {
        self.image = image
        self.content = content
        self.description = description
    }
    
    static public func slides() -> [SliderContent] {
    
        let slide1Title = "Digital Charity Application"
        let slide2Title = "Connect with community"
        let slide4Title = "You can also join our team"
        let slide3Title = "Awesome Feeling"
        let slide1Description = "Help people directly through our mobile service"
        let slide2Description = "Connect with other charity organisations."
        let slide3Description = "It feels awesome to help others within community"
        let slide4Description = "Share your information and we will you to join our team"
        
        let image1 = #imageLiteral(resourceName: "slider1")
        let image2 = #imageLiteral(resourceName: "slider2")
        let image3 = #imageLiteral(resourceName: "slider3")
        let image4 = #imageLiteral(resourceName: "slider4")
      
        let slide1 = SliderContent.init(image: image1, content: slide1Title, description: slide1Description)
        let slide2 = SliderContent.init(image: image2, content: slide2Title, description: slide2Description)
        let slide3 = SliderContent.init(image: image3, content: slide3Title, description: slide3Description)
        let slide4 = SliderContent.init(image: image4, content: slide4Title, description: slide4Description)
        return [slide1, slide2, slide3, slide4]
    }
    
}
