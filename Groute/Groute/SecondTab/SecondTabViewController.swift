//
//  SecondTabViewController.swift
//  Groute
//
//  Created by 이민재 on 15/05/2020.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Kingfisher

class SecondTabViewController: UIViewController {
    
    @IBOutlet weak var secondTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        secondTableview.delegate = self
        secondTableview.dataSource = self
    }
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()

    var secondTabList: [SecondTabModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDocument()
    }
    func getDocument() {
        db.collection("Test").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else {
                self.secondTabList = []
                for document in querySnapshot!.documents {
                    let Testone : SecondTabModel = SecondTabModel(When: document.get("When") as? String, address: document.get("address") as? String, imageAddress: document.get("imageAddress") as? String)
            self.secondTabList.append(Testone)
                }
                self.secondTableview.reloadData()
            }
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

extension SecondTabViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return secondTabList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondTabCell", for: indexPath) as! SecondTabTableViewCell
        let url = URL(string: secondTabList[indexPath.row].imageAddress!)
        cell.When.text = secondTabList[indexPath.row].When!
        cell.addressName.text = secondTabList[indexPath.row].address!
        cell.routeImage.kf.setImage(with: url)
        cell.routeImage.layer.cornerRadius = cell.routeImage.frame.height / 2
        cell.routeImage.layer.borderWidth = 1
        cell.routeImage.layer.borderColor = UIColor.clear.cgColor
        cell.routeImage.clipsToBounds = true
        cell.addressName.sizeToFit()
        cell.When.sizeToFit()
        return cell
    }
}

extension SecondTabViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
