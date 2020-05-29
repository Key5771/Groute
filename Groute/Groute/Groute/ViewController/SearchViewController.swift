//
//  SearchViewController.swift
//  Groute
//
//  Created by 이민재 on 28/05/2020.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import Kingfisher

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Get data from Firebase
    let db = Firestore.firestore()
    var cityList : [SearchCityModel] = []
    func getCitys(){
        db.collection("tour2").getDocuments { (querysnapshot, err) in
            if let err = err {
                print("Error getting document: \(err)")
            } else {
                self.cityList = []
                for document in querysnapshot!.documents{
                   let getCity : SearchCityModel = SearchCityModel (cityImage: document.get("cityImage") as? String, cityName: document.get("cityName") as? String, cityEtc: document.get("cityEtc") as? String)
                    self.cityList.append(getCity)
                }
                self.searchTable.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchList", for: indexPath) as! SeachCityCell
        let url = URL(string: cityList[indexPath.row].cityImage!)
        cell.cityImage.kf.setImage(with: url)
        cell.cityName.text = cityList[indexPath.row].cityName!
        cell.cityEtc.text = cityList[indexPath.row].cityEtc!
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTable.delegate = self
        searchTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCitys()
        print(cityList)
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
