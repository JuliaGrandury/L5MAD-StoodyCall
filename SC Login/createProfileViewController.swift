//
//  createProfileViewController.swift
//  SC Login
//
//  Created by Michael Hofstadter on 12/2/19.
//  Copyright © 2019 Michael Hofstadter. All rights reserved.
//

import UIKit

class createProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBAction func pickImage(_ sender: Any) {
        let imagePicker = UIImagePickerController();
        imagePicker.delegate = self
        present(imagePicker, animated: true);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] != nil {
            profilePic.image = info[.originalImage] as? UIImage;
        }
        dismiss(animated: true);
    }
    
    //Login or Sign up
    @IBAction func nextTapped(_ sender: Any) {
        let nameText = nameField.text
        if let name = nameText {
            if(name == "") {
                inputError(type: "nameMissing")
                print("missing name")
                return
            }
            if(checkValid(input: name)) {
                nameField.layer.borderWidth = 0.0
                nameLabel.text = "First Name"
            }
            else {
                inputError(type: "nameChar")
                print("invalid character use")
                return
            }
        }
        
        let phoneText = phoneField.text
        if let phone = phoneText {
            //Missing phone
            if(phone == "") {
                inputError(type: "phone")
                return
            }
            //Valid phone
            if(checkPhone(input: phone)) {
                phoneField.layer.borderWidth = 0.0
                phoneLabel.text = "Phone Number"
                print("YES")
            }
                //Invalid phone
            else {
                inputError(type: "phone")
                print("that aint it")
                return
            }
        }
        StoodyFirebase.profileImage = profilePic.image;
        StoodyFirebase.currentUser.name = nameField.text!;
        StoodyFirebase.currentUser.phoneNumber = phoneField.text!;
        self.performSegue(withIdentifier: "segQuestions", sender: self)
        
        
    }
    
    func inputError(type:String) {
        if(type == "phone") {
            phoneField.layer.borderColor = UIColor.red.cgColor
            phoneField.layer.borderWidth = 3.0
            phoneLabel.text = "Phone – Please enter valid phone number"
        }
        
        if(type == "nameMissing") {
            nameField.layer.borderColor = UIColor.red.cgColor
            nameField.layer.borderWidth = 3.0
            nameLabel.text = "First Name – Please enter a name"
        }
        
        if(type == "nameChar") {
            nameField.layer.borderColor = UIColor.red.cgColor
            nameField.layer.borderWidth = 3.0
            nameLabel.text = "First Name – Invalid character"
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
        nameLabel.adjustsFontSizeToFitWidth = true
        phoneLabel.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }
    
    
    func checkPhone(input:String) -> Bool {
        let phoneRegEx = "[0-9]{10}"
        let phonePred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: input)
    }
    
    func checkValid(input:String) -> Bool {
        let textRegEx = "[A-Z0-9a-z]+"
        let textPred = NSPredicate(format:"SELF MATCHES %@", textRegEx)
        return textPred.evaluate(with: input)
    }
}


