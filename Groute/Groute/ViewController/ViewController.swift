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
    
    var documentId: String = "doc"
    
    var tourList: [TourModel] = []
    var content: [Content] = []
    var favorite: [Favorite] = []
    var favoriteCount: [Int] = []
    var count = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        getDocument()
        getContent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        favoriteCount.append(5)
        favoriteCount.append(3)
        favoriteCount.append(6)
        favoriteCount.append(2)
        favoriteCount.append(1)
    }
    
    func getContent() {
        db.collection("Content").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else {
                self.content = []
                
                for doc in snapshot!.documents {
                    let content: Content = Content(email: doc.get("email") as? String ?? "", title: doc.get("title") as? String ?? "", memo: doc.get("memo") as? String ?? "", timestamp: doc.get("timestamp") as? String ?? "", imageAddress: doc.get("imageAddress") as? String ?? "")
                    
                    self.content.append(content)
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
//    func getDocument() {
//        db.collection("tour").getDocuments { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting document: \(err)")
//            } else {
//                self.tourList = []
//
//                for document in querySnapshot!.documents {
//                    let tour: TourModel = TourModel(address: document.get("address") as? String, imageAddress: document.get("imageAddress") as? String, name: document.get("name") as? String, roadAddress: document.get("roadAddress") as? String)
//                    print(tour)
//                    self.tourList.append(tour)
//                }
//
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    
    // TODO: - Segment Control
    @IBAction func segmentSelect(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            // 이 부분은 HOT Segment에 관한 코드를 남기면 됩니다.
            favoriteCount.sort { (lhs, rhs) -> Bool in
                return lhs < rhs
            }
            content.sort { (lhs, rhs) -> Bool in
                return lhs.timestamp < rhs.timestamp
            }
            tableView.reloadData()
            print("Hot")
            print("favorite: \(favorite)")
            print("favoriteCount: \(favoriteCount)")
        } else {
            // 이 부분은 NEW Segment에 관한 코드를 남기면 됩니다.
            content.sort { (lhs, rhs) -> Bool in
                return lhs.timestamp > rhs.timestamp
            }
            tableView.reloadData()
            print("New")
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


// MARK: - UITableViewController
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainList", for: indexPath) as! MainTableViewCell
        
//        let url = URL(string: tourList[indexPath.row].imageAddress!)
//        cell.locationImageView.kf.setImage(with: url)
//        cell.locationName.text = tourList[indexPath.row].name!
//        cell.locationAddress.text = tourList[indexPath.row].roadAddress ?? ""
        
        let url = URL(string: content[indexPath.row].imageAddress)
        cell.locationImageView.kf.setImage(with: url)
        cell.locationName.text = content[indexPath.row].title
        cell.locationAddress.text = content[indexPath.row].timestamp
        cell.favoriteCountLabel.text = "좋아요 \(favoriteCount[indexPath.row])개"
//        cell.favoriteCountLabel.text = String(favoriteCount[indexPath.row])
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
