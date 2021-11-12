//
//  ViewController.swift
//  Swipeable-View-Stack
//
//  Created by Phill Farrugia on 10/21/17.
//  Copyright © 2017 Phill Farrugia. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet private weak var swipeableCardView: SwipeableCardViewContainer!
    
    var viewModels: [SampleSwipeableCellViewModel] = []
    var sortingArray: [Int] = [];
    var compatToUser:[Int:[String]] = [:];
    var userToData: [String:SampleSwipeableCellViewModel] = [:];
    var index = 0;
    var compatIndex = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateArray()
        
        print("viewModels Count: ", String(viewModels.count))
    }
    
}

// MARK: - SwipeableCardViewDataSource

extension ViewController: SwipeableCardViewDataSource {
    
    func numberOfCards() -> Int {
        return viewModels.count
    }
    
    func card(forItemAtIndex index: Int) -> SwipeableCardViewCard {
        
        let viewModel = viewModels[index]
        let cardView = SampleSwipeableCard()
        cardView.viewModel = viewModel
        return cardView
    }
    
    func viewForEmptyCards() -> UIView? {
        return nil
    }
    
}

extension ViewController {
    
    func populateArray() {
        
        StoodyFirebase.db.collection("users").getDocuments() { (querySnapshot, err) in
            print("made it");
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if(document.documentID != Auth.auth().currentUser?.uid ?? "1"){
                        print(StoodyFirebase.currentUser.classes);
                        print(StoodyFirebase.currentUser.name);
                        let data = document.data();
                        var courseString = "";
                        for course in data["classes"] as! [String] {
                            courseString = course + ", ";
                        }
                        let viewData = SampleSwipeableCellViewModel(name: data["name"] as! String, courses: courseString, studyspot: data["vibe"] as! String, studystyle: data["music"] as! String,
                                                                    color: UIColor.white,
                                                                    uid: document.documentID, image: nil)
                        self.userToData[document.documentID] = viewData;
                        var compatNum = 0;
                        for subject in document.data()["classes"] as! [String] {
                            print(document.data()["classes"]);
                            print(StoodyFirebase.currentUser.classes);
                            for userClass in StoodyFirebase.currentUser.classes as! [String]{
                                if(subject==userClass){
                                    compatNum+=1;
                                }
                            }
                        }
                        print(compatNum);
                        if self.compatToUser[compatNum] == nil{
                            self.compatToUser[compatNum] = [document.documentID];
                        }
                        else{
                            self.compatToUser[compatNum]!.append(document.documentID);
                        }
                    }
                    else{
                        print("same document");
                    }
                }
                self.sortingArray = Array(self.compatToUser.keys).sorted(by: <);
                for num in self.sortingArray {
                    print ("num: ", String(num))
                    let userArray = self.compatToUser[num]!;
                    for user in userArray{
                        self.viewModels.append(self.userToData[user]!);
                    }
                }
                print("viewModels countt: ", String(self.viewModels.count))
            }
            self.swipeableCardView.dataSource = self
        }
    }
}
