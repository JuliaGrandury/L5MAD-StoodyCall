//
//  musicPrefViewController.swift
//  StoodyCall
//
//  Created by Taylor Chen on 11/19/19.
//  Copyright © 2019 Taylor Chen. All rights reserved.
//

import UIKit

class musicPrefViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        selected = "Spotify Peaceful Piano playlist"
        
    }
    
    
    @IBAction func two(_ sender: Any) {
        resetStyle()
        two.backgroundColor = blueColor
        two.setTitleColor(UIColor.white, for: .normal)
        selected = "Absolute silence...stfu"
    }
    
    @IBAction func three(_ sender: Any) {
        resetStyle()
        three.backgroundColor = blueColor
        three.setTitleColor(UIColor.white, for: .normal)
        selected = "Low-Fi - Chill - Hip Hop - Vibe"
    }
    
    @IBAction func four(_ sender: Any) {
        resetStyle()
        four.backgroundColor = blueColor
        four.setTitleColor(UIColor.white, for: .normal)
        selected = "Top 50 Pop Songs"
    }
    
    @IBAction func five(_ sender: Any) {
        resetStyle()
        five.backgroundColor = blueColor
        five.setTitleColor(UIColor.white, for: .normal)
        selected = "YouTube 4hr crackling video"
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        if(selected == "") {
            return
        }
        StoodyFirebase.currentUser.music = selected;
        //Pass selected to firebase
        self.performSegue(withIdentifier: "segVibe", sender: self)
        print(selected)
        
    }

    

}
