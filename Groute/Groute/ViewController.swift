//
//  ViewController.swift
//  Groute
//
//  Created by 김기현 on 2020/04/25.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    
    var tourList: [TourModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDocument()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func getDocument() {
        db.collection("tour").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else {
                self.tourList = []
                
                for document in querySnapshot!.documents {
                    let tour: TourModel = TourModel(address: document.get("address") as? String, imageAddress: document.get("imageAddress") as? String, name: document.get("name") as? String, roadAddress: document.get("roadAddress") as? String)
                    print(tour)
                    self.tourList.append(tour)
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func segmentSelect(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            
        } else {
            
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tourList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainList", for: indexPath) as! MainTableViewCell
        
        let url = URL(string: tourList[indexPath.row].imageAddress!)
        cell.locationImageView.kf.setImage(with: url)
        cell.locationName.text = tourList[indexPath.row].name!
        cell.locationAddress.text = tourList[indexPath.row].roadAddress ?? ""
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
