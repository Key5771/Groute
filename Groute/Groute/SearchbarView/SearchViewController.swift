//
//  SearchViewController.swift
//  Groute
//
//  Created by 이민재 on 18/05/2020.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDataSource{
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchResult: UITextField!
    
    var fruitArray: [String] = Array()
    var searchedArray:[String] = Array()
    
    @IBAction func backToPreviousView(_ sender: Any) {
        let viewController: UIViewController = self.storyboard!.instantiateViewController(withIdentifier: "SecondTabViewController")
        viewController.modalPresentationStyle = .overFullScreen
        self.present(viewController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        fruitArray.append("Apple")
        fruitArray.append("Orange")
        fruitArray.append("Litchi")
        fruitArray.append("PineApple")
        
        for str in fruitArray {
            searchedArray.append(str)
        }
        
        searchTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = searchedArray[indexPath.row]
        
        return cell
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
