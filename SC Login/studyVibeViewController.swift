//
//  studyVibeViewController.swift
//  StoodyCall
//
//  Created by Taylor Chen on 11/19/19.
//  Copyright © 2019 Taylor Chen. All rights reserved.
//

import UIKit
import FirebaseAuth

class studyVibeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        one.layer.borderWidth = 1.0
        one.layer.borderColor = UIColor.black.cgColor
        two.layer.borderWidth = 1.0
        two.layer.borderColor = UIColor.black.cgColor
        three.layer.borderWidth = 1.0
        three.layer.borderColor = UIColor.black.cgColor
        four.layer.borderWidth = 1.0
        four.layer.borderColor = UIColor.black.cgColor
        five.layer.borderWidth = 1.0
        five.layer.borderColor = UIColor.black.cgColor
        
        
    }
    

    
    @IBOutlet weak var one: UIButton!
    
    @IBOutlet weak var two: UIButton!
    
    @IBOutlet weak var three: UIButton!
    
    @IBOutlet weak var four: UIButton!
    
    @IBOutlet weak var five: UIButton!
    var selected = ""
    
    func resetStyle() {
        one.backgroundColor = UIColor.white
        one.setTitleColor(UIColor.black, for: .normal)
        two.backgroundColor = UIColor.white
        two.setTitleColor(UIColor.black, for: .normal)
        three.backgroundColor = UIColor.white
        three.setTitleColor(UIColor.black, for: .normal)
        four.backgroundColor = UIColor.white
        four.setTitleColor(UIColor.black, for: .normal)
        five.backgroundColor = UIColor.white
        five.setTitleColor(UIColor.black, for: .normal)
    }
    
    
    
    @IBAction func one(_ sender: Any) {
        resetStyle()
        one.backgroundColor = blueColor
        one.setTitleColor(UIColor.white, for: .normal)
        selected = "2am law on a Tuesday"
        
    }
    
    
    @IBAction func two(_ sender: Any) {
        resetStyle()
        two.backgroundColor = blueColor
        two.setTitleColor(UIColor.white, for: .normal)
        selected = "Whispers on a Saturday night"
    }
    
    @IBAction func three(_ sender: Any) {
        resetStyle()
        three.backgroundColor = blueColor
        three.setTitleColor(UIColor.white, for: .normal)
        selected = "East Asian Lib all day everyday"
    }
    
    @IBAction func four(_ sender: Any) {
        resetStyle()
        four.backgroundColor = blueColor
        four.setTitleColor(UIColor.white, for: .normal)
        selected = "BD booths under the blue light"
    }
    
    @IBAction func five(_ sender: Any) {
        resetStyle()
        five.backgroundColor = blueColor
        five.setTitleColor(UIColor.white, for: .normal)
        selected = "30 mins before the exam"
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        if(selected == "") {
            return
        }
        StoodyFirebase.currentUser.vibe = selected;
        Auth.auth().createUser(withEmail: StoodyFirebase.email , password: StoodyFirebase.password) { authResult, error in
            
            if error == nil {
                let user = StoodyFirebase.currentUser
                StoodyFirebase.db.collection("users").document(authResult!.user.uid).setData([
                    "name": user.name!,
                    "year": user.year!,
                    "music": user.music!,
                    "vibe": self.selected,
                    "classes": user.classes,
                    "matches": [],
                    "likes": [],
                    "phoneNumber": user.phoneNumber!
                    
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        let data = StoodyFirebase.profileImage?.pngData();
                        let storageRef = StoodyFirebase.storage.reference();
                        // Create a reference to the file you want to upload
                        let ref = storageRef.child("profilePictures/"+Auth.auth().currentUser!.uid+".jpg")
                        
                        // Upload the file to the path "images/rivers.jpg"
                        ref.putData(data!, metadata: nil) { (metadata, error) in
                            guard metadata != nil else {
                                // Uh-oh, an error occurred!
                                return
                            }
                            // Metadata contains file metadata such as size, content-type.
                            //            let size = metadata.size
                            // You can also access to download URL after upload.
                            ref.downloadURL { (url, error) in
                                guard url != nil else {
                                    // Uh-oh, an error occurred!
                                    return
                                }
                            }
                        }
                        self.performSegue(withIdentifier: "segCard", sender: self);
                    }
                }
            }
            else{
                print(error!);
            }
        }
        //Pass selected to firebase
        print(selected)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
