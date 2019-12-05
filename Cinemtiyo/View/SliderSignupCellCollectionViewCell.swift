//
//  SliderSignupCellCollectionViewCell.swift
//  Cinemtiyo
//
//  Created by Vinayak Sareen on 04/12/2019.
//  Copyright © 2019 Vinayak Sareen. All rights reserved.
//

import UIKit

class SliderSignupCellCollectionViewCell: UICollectionViewCell {
    
    weak var customDelegate: CellButtonDetect?
    
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
    @IBOutlet weak var emailTextField: UITextField!
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
        if(username.count == 0 || email.count <= 0 || password.count <= 0) {return true}
        return false
    }
    
    func isValidEmail(email: String) -> Bool{
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regex)
        return pred.evaluate(with: email)
    }
    
    func showAlertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func registerationChecks(){
        let missingChecksResults = missingChecks(username: usernameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        if(missingChecksResults == true){
            showAlertController(title: "Missing Details Error", message: "Missing details are entered into the system")
            return
        }else if(isValidEmail(email: emailTextField.text ?? "") == false){
            showAlertController(title: "Invalid Email Error", message: "The entered email donot conforms to valid email pattern")
            return
        }else if(checkShortPassword(password: passwordTextField.text ?? "") == true){
            showAlertController(title: "Weak Password Error", message: "The password length is very short")
            return
        }
    }
    
    @IBAction func signupBtnPressed(_ sender: Any) {
        registerationChecks()
    }
    
    
    @IBAction func alreadyHaveAccount() {
        print("Already have an account")
        guard let delegate = customDelegate else { return }
        delegate.detectButtonPressed()
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
