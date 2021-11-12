//
//  michaelProfileViewController.swift
//  SC Login
//
//  Created by Pranav Jain on 11/19/19.
//  Copyright © 2019 Michael Hofstadter. All rights reserved.
//

import UIKit

class michaelProfileViewController: UIViewController {

    @IBOutlet weak var profilePhoto: UIImageView!
    

    @IBOutlet weak var favPlaceImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePhoto.layer.cornerRadius = profilePhoto.frame.height / 2
   
        let nameTextView = UILabel(frame: CGRect(x: 0, y: favPlaceImage.frame.height - 32, width: favPlaceImage.frame.width, height: 32.0))
        nameTextView.textColor = .white
        nameTextView.backgroundColor = .black
        nameTextView.textAlignment = .center
        nameTextView.alpha = 0.8
        nameTextView.text = "Law Cafe"
        nameTextView.font = .systemFont(ofSize: 16.0)
        nameTextView.numberOfLines = 0
        favPlaceImage.addSubview(nameTextView)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        if xFromCenter > 0 {
            thumbImageView.image = UIImage(named: "favorite")
            let templateImage = thumbImageView.image?.withRenderingMode(.alwaysTemplate)
            thumbImageView.image = templateImage
            thumbImageView.tintColor = UIColor.blue
        } else {
            thumbImageView.image = UIImage(named: "unchecked")
            let templateImage = thumbImageView.image?.withRenderingMode(.alwaysTemplate)
            thumbImageView.image = templateImage
            thumbImageView.tintColor = UIColor.red
        }
        thumbImageView.alpha = abs(xFromCenter) / view.center.x
        
        if sender.state == UIGestureRecognizer.State.ended {
            if card.center.x < 75 {
                //move off to left side
                UIView.animate(withDuration: 0.3, animations: { card.center = CGPoint(x: card.center.x - 200, y: card.center.y)
                    card.alpha = 0
                })
                print("1")
                return
            } else if card.center.x > (view.frame.width - 75){
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y)
                    card.alpha = 0
                })
                print("2")
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                card.center = self.view.center
                self.thumbImageView.alpha = 0
            })
        }
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
