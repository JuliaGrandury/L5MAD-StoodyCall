//
//  gradeViewController.swift
//  StoodyCall
//
//  Created by Taylor Chen on 11/19/19.
//  Copyright © 2019 Taylor Chen. All rights reserved.
//

import UIKit

    let blueColor = UIColor(displayP3Red: CGFloat(12/255.0), green: CGFloat(113/255.0), blue: CGFloat(192/255.0), alpha: 1)



class gradeViewController: UIViewController {
    var selected = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        firstYear.layer.borderWidth = 1.0
        firstYear.layer.borderColor = UIColor.black.cgColor
        sophomore.layer.borderWidth = 1.0
        sophomore.layer.borderColor = UIColor.black.cgColor
        junior.layer.borderWidth = 1.0
        junior.layer.borderColor = UIColor.black.cgColor
        senior.layer.borderWidth = 1.0
        senior.layer.borderColor = UIColor.black.cgColor
        other.layer.borderWidth = 1.0
        other.layer.borderColor = UIColor.black.cgColor
    }
    

    
    @IBOutlet weak var firstYear: UIButton!
    @IBOutlet weak var sophomore: UIButton!
    @IBOutlet weak var junior: UIButton!
    @IBOutlet weak var senior: UIButton!
    @IBOutlet weak var other: UIButton!
    let options = [firstYear, sophomore, junior, senior, other]

    
    func resetStyle() {
        firstYear.backgroundColor = UIColor.white
        firstYear.setTitleColor(UIColor.black, for: .normal)
        sophomore.backgroundColor = UIColor.white
        sophomore.setTitleColor(UIColor.black, for: .normal)
        junior.backgroundColor = UIColor.white
        junior.setTitleColor(UIColor.black, for: .normal)
        senior.backgroundColor = UIColor.white
        senior.setTitleColor(UIColor.black, for: .normal)
        other.backgroundColor = UIColor.white
        other.setTitleColor(UIColor.black, for: .normal)
    }
    
    
    @IBAction func firstYear(_ sender: Any) {
        resetStyle()
        firstYear.backgroundColor = blueColor
        firstYear.setTitleColor(UIColor.white, for: .normal)
        selected = "First Year"
    }
    
    @IBAction func sophomore(_ sender: Any) {
        resetStyle()
        sophomore.backgroundColor = blueColor
        sophomore.setTitleColor(UIColor.white, for: .normal)
        selected = "Sophomore"
    }
  
    @IBAction func junior(_ sender: Any) {
        resetStyle()
        junior.backgroundColor = blueColor
        junior.setTitleColor(UIColor.white, for: .normal)
        selected = "Junior"
    }
    
    @IBAction func senior(_ sender: Any) {
        resetStyle()
        senior.backgroundColor = blueColor
        senior.setTitleColor(UIColor.white, for: .normal)
        selected = "Senior"
    }
    
    @IBAction func other(_ sender: Any) {
        resetStyle()
        other.backgroundColor = blueColor
        other.setTitleColor(UIColor.white, for: .normal)
        selected = "Other"
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        if(selected == "") {
            return
        }
        //Pass selected to firebase
        StoodyFirebase.currentUser.year = selected;
        self.performSegue(withIdentifier: "segClasses", sender: self)
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
