//
//  matchViewController.swift
//  SC Login
//
//  Created by Pranav Jain on 11/19/19.
//  Copyright © 2019 Michael Hofstadter. All rights reserved.
//

import UIKit

class matchViewController: UIViewController {

    @IBOutlet weak var matchPic1: UIImageView!
    @IBOutlet weak var matchPic2: UIImageView!
    override func viewDidLoad() {
        matchPic1.layer.cornerRadius = matchPic1.frame.height / 2
        matchPic2.layer.cornerRadius = matchPic2.frame.height / 2
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
