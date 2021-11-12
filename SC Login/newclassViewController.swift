//
//  ViewController.swift
//  InClassDemo2
//
//  Created by Todd Sproull on 10/7/19.
//  Copyright © 2019 Todd Sproull. All rights reserved.
//

import UIKit

class newclassViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    struct Info: Codable{
        var name:String
    }
    
    var theNewData: [String] = ["CSE 131", "CSE 247", "CSE 330", "CSE 438", "CSE 222", "Engr 310", "Drama 365C", "ESE 326", "Econ 1021", "Math 310", "Span 307D", "CWP 100", "Math 233", "Math 132", "Physics 197"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theNewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel!.text = theNewData[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    

   // @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
         setupTableView()
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchDataForTableView()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    func fetchDataForTableView() {
        //nada
    }

    var myClasses: [String] = []
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myCell = tableView.cellForRow(at: indexPath)
        if(myCell?.backgroundColor == UIColor.lightGray) {
            myCell?.backgroundColor = UIColor.white
            for aClass in myClasses {
                if aClass == theNewData[indexPath.row]{
                    myClasses.removeAll { $0 == theNewData[indexPath.row] }
                }
            }
        }
        else {
            myCell?.backgroundColor = UIColor.lightGray
            myClasses.append(theNewData[indexPath.row])
        }
        


//        let detailedVC = DetailedViewController()
//        detailedVC.image = theImageCache[indexPath.row]
//        detailedVC.imageName = theData[indexPath.row].name
//
//        navigationController?.pushViewController(detailedVC, animated: true)
        
    }

    @IBAction func continueTapped(_ sender: Any) {
        //PASS DATA TO FIREBASE
        for aClass in myClasses {
            print(aClass)
        }
        if(myClasses.count == 0) {
            return
        }
        StoodyFirebase.currentUser.classes = myClasses;
        self.performSegue(withIdentifier: "segStudy", sender: self)
    }
}

