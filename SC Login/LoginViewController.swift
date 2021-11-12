//
//  LoginViewController.swift
//  SC Login
//
//  Created by Michael Hofstadter on 11/18/19.
//  Copyright © 2019 Michael Hofstadter. All rights reserved.
//

//swiping external library from https://github.com/phillfarrugia/swipeable-view-stack

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    var isLogin = false //used for the enter button
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var inputStack: UIStackView!
    @IBAction func signUpTapped(_ sender: Any) {
        loginButton.isHidden = true
        signUpButton.isHidden = true
        headerText.text = "Sign Up"
        headerText.isHidden = false
        inputStack.isHidden = false
        backButton.isHidden = false
        isLogin = false
    }
    @IBAction func loginTapped(_ sender: Any) {
        loginButton.isHidden = true
        signUpButton.isHidden = true
        headerText.text = "Login"
        headerText.isHidden = false
        inputStack.isHidden = false
        backButton.isHidden = false
        isLogin = true
    }
    
    //Login or Sign up
    @IBAction func enterTapped(_ sender: Any) {
        let emailText = emailField.text
        if let email = emailText {
            //Missing email
            if(email == "") {
                inputError(type: "email")
                return
            }
            //Valid email
            if(checkEmail(input: email)) {
                emailField.layer.borderWidth = 0.0
                emailLabel.text = "Email"
            }
                //Invalid email
            else {
                inputError(type: "email")
                print("that aint it")
                return
            }
        }
        let passwordText = passwordField.text
        if let password = passwordText {
            if(password == "") {
                inputError(type: "passwordMissing")
                print("missing password")
                return
            }
            if(checkValid(input: password)) {
                passwordField.layer.borderWidth = 0.0
                passwordLabel.text = "Password"
            }
            else {
                inputError(type: "passwordChar")
                print("invalid character use")
                return
            }
        }
        
        //Loggin in
        if(isLogin == true) {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { authResult, error in
                if error == nil {
                    StoodyFirebase.db.collection("users").document(authResult!.user.uid).getDocument { (document, error) in
                        if let document = document, document.exists {
                            let data = document.data();
                            print(document.data()!)
                            StoodyFirebase.currentUser.name = data?["name"] as? String;
                           StoodyFirebase.currentUser.year = data?["year"] as? String;
                            StoodyFirebase.currentUser.music = data?["music"] as? String;
                           StoodyFirebase.currentUser.vibe = data?["vibe"] as? String;
                              StoodyFirebase.currentUser.phoneNumber = data?["music"] as? String;
                            StoodyFirebase.currentUser.classes = data?["classes"] as? [Any] ?? [];
                            print("REFUWI");
                           StoodyFirebase.currentUser.likes = data?["likes"] as? [Any] ?? [];
                           StoodyFirebase.currentUser.matches = data?["matches"] as? [Any] ?? [];
                            self.performSegue(withIdentifier: "segLogin", sender: self);
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
                else{
                    
                    self.inputError(type: "wrong");
                }
            }
        }
        //Signing up
        else {
            Auth.auth().fetchSignInMethods(forEmail: emailField.text!){ authResult, error in
                if error == nil {
                    if authResult == nil{
                        StoodyFirebase.email = self.emailField.text!;
                        StoodyFirebase.password = self.passwordField.text!;
                        self.performSegue(withIdentifier: "segSignUp", sender: self);
                    }
                    else{
                        self.emailField.layer.borderColor = UIColor.red.cgColor
                        self.emailField.layer.borderWidth = 3.0
                    }
                }
                else{
                    self.emailField.layer.borderColor = UIColor.red.cgColor
                    self.emailField.layer.borderWidth = 3.0
                    self.passwordField.layer.borderColor = UIColor.red.cgColor
                    self.passwordField.layer.borderWidth = 3.0
                }
            }
        }
    }
    
    func inputError(type:String) {
        if(type == "email") {
            emailField.layer.borderColor = UIColor.red.cgColor
            emailField.layer.borderWidth = 3.0
            emailLabel.text = "Email – Enter valid email address"
            return;
        }
        
        if(type == "passwordMissing") {
            passwordField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderWidth = 3.0
             passwordLabel.text = "Password – Please enter a password"
            return;
        }
        
        if(type == "passwordChar") {
            passwordField.layer.borderColor = UIColor.red.cgColor
            passwordField.layer.borderWidth = 3.0
             passwordLabel.text = "Password – Invalid character"
            return;
        }
        passwordField.layer.borderColor = UIColor.red.cgColor
        passwordField.layer.borderWidth = 3.0
//        errorLabel.text = "Email- " + type;
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        inputStack.isHidden = true
        headerText.isHidden = true
        loginButton.isHidden = false
        signUpButton.isHidden = false
        backButton.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        headerText.isHidden = true
        inputStack.isHidden = true
        backButton.isHidden = true
        emailLabel.adjustsFontSizeToFitWidth = true
        passwordLabel.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
    }
    
    
    func checkEmail(input:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: input)
    }
    
    func checkValid(input:String) -> Bool {
        let textRegEx = "[A-Z0-9a-z!@#$%^&*()]{6,64}"
        let textPred = NSPredicate(format:"SELF MATCHES %@", textRegEx)
        return textPred.evaluate(with: input)
    }


}

