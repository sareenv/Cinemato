//
//  SliderSignupCellCollectionViewCell.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 04/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class SliderSignupCellCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imagePickerButton: UIButton!{
        didSet{
            let attributedString = NSAttributedString(string: "Select Profile Image", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black])
            imagePickerButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.3132702465)
            imagePickerButton.layer.cornerRadius = 5
            imagePickerButton.setAttributedTitle(attributedString, for: .normal)
            imagePickerButton.addTarget(self, action: #selector(setProfileImage), for: .touchUpInside)
        }
    }
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var singupButton: UIButton!{
        didSet{
            singupButton.layer.cornerRadius = 5
        }
    }
    
    lazy var imagePickerController = UIImagePickerController()
    lazy var imagePickerView = imagePickerController.view
    
    @objc func setProfileImage(){
        
        imagePickerController.delegate = self
        addSubview(imagePickerView!)
        imagePickerView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imagePickerView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        imagePickerView?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imagePickerView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    
    func checkShortPassword(password: String) -> Bool {
        if(password.count < 6) {
           return true
        }
        return false
    }
    
    func missingChecks(username: String, email: String, password: String) -> Bool {
        if(username.count == 0 || email.count <= 0 || password.count <= 0) {return false}
        return true
    }
    
    func isValidEmail(email: String) -> Bool{
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regex)
        return pred.evaluate(with: email)
    }
    
    func showAlertController() {
        
    }
    
    @IBAction func signupBtnPressed(_ sender: Any) {
        
        usernameTextField.layer.borderWidth = 1.2
        usernameTextField.layer.borderColor = UIColor.red.cgColor
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessibilityIdentifier = "RegisterationCell"
    }
}

extension SliderSignupCellCollectionViewCell: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    imagePickerButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        imagePickerButton.titleLabel?.removeFromSuperview()
    imagePickerView?.removeFromSuperview()
    }
}
