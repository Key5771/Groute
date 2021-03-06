//
//  ContentViewController.swift
//  Groute
//
//  Created by 김기현 on 2020/05/29.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ContentViewController: UIViewController {
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var routeTable: UITableView!
    
    var contentId: String = ""

    var content: [routeName] = []
    let db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    override func viewDidLoad() {
        super.viewDidLoad()
        getContent()
        getRoute()
        routeTable.delegate = self
        routeTable.dataSource = self
    }
    func getRoute(){
        db.collection("Content").document(contentId).collection("Route").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting Documents: \(err)")
            } else {
                self.content = []
                for document in querySnapshot!.documents{
//                    print("\(document.documentID) => \(document.data())")
                    let getRouteName : routeName = routeName(name: document.documentID)
                    self.content.append(getRouteName)
                    self.routeTable.reloadData()
                    print(getRouteName)
                }
            }
        }
    }
    func getContent() {
        db.collection("Content").document(contentId).getDocument { (snapshot, err) in
            if let err = err {
                print("Error getting ContentViewController : \(err)")
            } else {
                if let location = snapshot?.get("location") as? String {
                    self.locationLabel.text = location + " 여행"
                }
                if let memo = snapshot?.get("memo") as? String {
                    self.memoLabel.text = memo
                }
                
                if let user = snapshot?.get("email") as? String {
                    self.userLabel.text = user
                }
                
                if let timestamp = snapshot?.get("timestamp") as? Timestamp {
                    let dateFormat: DateFormatter = DateFormatter()
                    dateFormat.dateFormat = "yyyy년 MM월 dd일"
                    let time = dateFormat.string(from: timestamp.dateValue())
                    self.timeLabel.text = time
                }
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

extension ContentViewController :UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeListCell",  for: indexPath) as! ContentRouteTableViewCell
        cell.locationName.text = content[indexPath.row].name
        cell.routeIndex.text = String(indexPath.row + 1)
        cell.reviewButton.setTitle("리뷰", for: .normal)
        return cell
    }
}

extension ContentViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
