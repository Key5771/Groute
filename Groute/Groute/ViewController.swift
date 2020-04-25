//
//  ViewController.swift
//  Groute
//
//  Created by 김기현 on 2020/04/25.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "hot"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentSelect(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            label.text = "hot"
        } else {
            label.text = "new"
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
