//
//  SampleSwipeableCard.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit
import CoreMotion
import FirebaseAuth

class SampleSwipeableCard: SwipeableCardViewCard {
    
    /// Core Motion Manager
    let motionManager = CMMotionManager()
    
    
    /// Shadow View
    weak var shadowView: UIView?
    
    /// Inner Margin
    let kInnerMargin: CGFloat = 20.0
    
    func configure(forViewModel viewModel: SampleSwipeableCellViewModel?) {
        if let viewModel = viewModel {
            name.text = viewModel.name
            courses.text = viewModel.courses
            imageBackgroundColorView.backgroundColor = viewModel.color
            userImage.image = viewModel.image
            userImage.layer.cornerRadius = userImage.frame.height / 2
            studyPlace.text = viewModel.studyspot
            studyStyle.text = viewModel.studystyle
            
            backgroundContainerView.layer.cornerRadius = 14.0
            //            addButton.layer.cornerRadius = addButton.frame.size.height/4
        }
    }
    
    func setPhoto(uid:String) {
        let ref = StoodyFirebase.storage.reference().child("profilePictures/" + Auth.auth().currentUser!.uid + ".jpg");
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        ref.getData(maxSize: 15 * 1024 * 1024) { data, error in
            if let error = error {
                print("ERROR");
                print(error);// Uh-oh, an error occurred!
            } else {
                // Data for "images/island.jpg" is returned
                self.viewModel!.image = UIImage(data: data!);
            }
        }
    }
    
    var viewModel: SampleSwipeableCellViewModel? {
        didSet {
            setPhoto(uid:viewModel!.uid);
            configure(forViewModel: viewModel)
        }
    }
    
    @IBOutlet private weak var imageBackgroundColorView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var backgroundContainerView: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var courses: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var studyPlace: UILabel!
    @IBOutlet weak var studyStyle: UILabel!
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        
        let imageBackgroundColorView = sender.view!
        let point = sender.translation(in: backgroundContainerView)
        let xFromCenter = imageBackgroundColorView.center.x - backgroundContainerView.center.x
        imageBackgroundColorView.center = CGPoint(x: backgroundContainerView.center.x + point.x, y: backgroundContainerView.center.y + point.y)
        
        
        if xFromCenter > 0 {
            thumbImageView.image = UIImage(named: "thumbsup")
            let templateImage = thumbImageView.image?.withRenderingMode(.alwaysTemplate)
            thumbImageView.image = templateImage
            thumbImageView.tintColor = UIColor.green
        } else {
            thumbImageView.image = UIImage(named: "thumbsdown")
            let templateImage = thumbImageView.image?.withRenderingMode(.alwaysTemplate)
            thumbImageView.image = templateImage
            thumbImageView.tintColor = UIColor.red
        }
        thumbImageView.alpha = abs(xFromCenter) / backgroundContainerView.center.x
        
        
        if sender.state == UIGestureRecognizer.State.ended {
            if imageBackgroundColorView.center.x < 75 {
                //move off to left side
                UIView.animate(withDuration: 0.3, animations: { imageBackgroundColorView.center = CGPoint(x: imageBackgroundColorView.center.x - 200, y: imageBackgroundColorView.center.y)
                    imageBackgroundColorView.alpha = 0
                })
                return
            } else if imageBackgroundColorView.center.x > (backgroundContainerView.frame.width - 75){
                UIView.animate(withDuration: 0.3, animations: {
                    imageBackgroundColorView.center = CGPoint(x: imageBackgroundColorView.center.x + 200, y: imageBackgroundColorView.center.y)
                    imageBackgroundColorView.alpha = 0
                })
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                imageBackgroundColorView.center = self.backgroundContainerView.center
                self.thumbImageView.alpha = 0
            })
            
        }
        
        func layoutSubviews() {
            super.layoutSubviews()
            
            //        configureShadow()
        }
        
        // MARK: - Shadow
        
        //     func configureShadow() {
        //        // Shadow View
        //        self.shadowView?.removeFromSuperview()
        //        let shadowView = UIView(frame: CGRect(x: SampleSwipeableCard.kInnerMargin,
        //                                              y: SampleSwipeableCard.kInnerMargin,
        //                                              width: bounds.width - (2 * SampleSwipeableCard.kInnerMargin),
        //                                              height: bounds.height - (2 * SampleSwipeableCard.kInnerMargin)))
        //        insertSubview(shadowView, at: 0)
        //        self.shadowView = shadowView
        //
        //        // Roll/Pitch Dynamic Shadow
        ////        if motionManager.isDeviceMotionAvailable {
        ////            motionManager.deviceMotionUpdateInterval = 0.02
        ////            motionManager.startDeviceMotionUpdates(to: .main, withHandler: { (motion, error) in
        ////                if let motion = motion {
        ////                    let pitch = motion.attitude.pitch * 10 // x-axis
        ////                    let roll = motion.attitude.roll * 10 // y-axis
        ////                    self.applyShadow(width: CGFloat(roll), height: CGFloat(pitch))
        ////                }
        ////            })
        ////        }
        //        self.applyShadow(width: CGFloat(0.0), height: CGFloat(0.0))
        //    }
        
        //    private func applyShadow(width: CGFloat, height: CGFloat) {
        //        if let shadowView = shadowView {
        //            let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 14.0)
        //            shadowView.layer.masksToBounds = false
        //            shadowView.layer.shadowRadius = 8.0
        //            shadowView.layer.shadowColor = UIColor.black.cgColor
        //            shadowView.layer.shadowOffset = CGSize(width: width, height: height)
        //            shadowView.layer.shadowOpacity = 0.15
        //            shadowView.layer.shadowPath = shadowPath.cgPath
        //        }
    }
    
}
