//
//  AddRouteViewController.swift
//  Groute
//
//  Created by 김기현 on 2020/06/01.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit

class AddRouteViewController: UIViewController {
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var pickerView: UIDatePicker!
    @IBOutlet weak var innerView: UIView!
    
    var mapView: MTMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pickerView.isHidden = true
        loadKakaoMap()
    }
    
    @IBAction func selectDate(_ sender: Any) {
        pickerView.isHidden = false
        createDatePicker()
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(AddRouteViewController.doneClick))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        dateTextfield.inputAccessoryView = toolbar
        dateTextfield.inputView = pickerView
    }
    
    @objc func doneClick() {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        let selectedDate: String = dateFormatter.string(from: pickerView.date)
        dateTextfield.text = selectedDate
        dateTextfield.resignFirstResponder()
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

extension AddRouteViewController: MTMapViewDelegate {
    
    func loadKakaoMap() {
        mapView = MTMapView(frame: self.innerView.frame)
        
        if let mapView = mapView {
            mapView.setMapCenter(MTMapPoint(geoCoord:
                MTMapPointGeo(latitude: 33.364228, longitude: 126.542096)), animated: true)
            // Zoom To
            mapView.setZoomLevel(8, animated: true)

            mapView.delegate = self
            mapView.baseMapType = .standard
            self.innerView.addSubview(mapView)
        }
    }
}
