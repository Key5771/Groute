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
    @IBOutlet weak var tableView: UITableView!
    
    var mapView: MTMapView?
    var cellCount: Int = 0
    
    // Jeju National University Point
    let mapPoint: MTMapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 33.457856, longitude: 126.561679))
    // Jeju City Hall
    let mapPoint2: MTMapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 33.499598, longitude:  126.531259))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        innerView.backgroundColor = UIColor.gray
        innerView.addSubview(loadKakaoMap())
//        loadKakaoMap()
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

extension AddRouteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "5월 11일"
        } else if section == 1 {
            return "5월 12일"
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            cellCount = 1
        } else if section == 1 {
            cellCount = 1
        }
        
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "route", for: indexPath) as! AddRouteTableViewCell
        
        if indexPath.section == 0 {
            cell.locationLabel.text = "제주대학교"
        } else if indexPath.section == 1 {
            cell.locationLabel.text = "제주시청"
        }
        
        return cell
    }
    
    
}

extension AddRouteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AddRouteViewController: MTMapViewDelegate {
    
    func createMarker() -> [MTMapPOIItem] {
        let positionItem = MTMapPOIItem()
        positionItem.itemName = "제주대학교"
        positionItem.mapPoint = mapPoint
        positionItem.markerType = .bluePin
        positionItem.markerSelectedType = .bluePin
        positionItem.tag = 0
        
        let positionItem2 = MTMapPOIItem()
        positionItem2.itemName = "제주시청"
        positionItem2.mapPoint = mapPoint2
        positionItem2.markerType = .bluePin
        positionItem2.markerSelectedType = .bluePin
        positionItem2.tag = 1
        
        return [positionItem, positionItem2]
    }
    
    func createPolyline() -> MTMapPolyline {
        let polyLine = MTMapPolyline()
        polyLine.addPoints([mapPoint, mapPoint2])
        
        return polyLine
    }
    
    func loadKakaoMap() -> MTMapView {
        mapView = MTMapView(frame: CGRect(x: 0, y: 0, width: self.innerView.frame.width, height: self.innerView.frame.height))
        guard let mapView = mapView else { return MTMapView.init() }
        
        mapView.delegate = self
        
        // Center Point
        mapView.setMapCenter(mapPoint2, animated: true)
        // Zoom To
        mapView.setZoomLevel(4, animated: true)
        mapView.baseMapType = .standard
        mapView.showCurrentLocationMarker = true
        print("Marker: \(mapView.showCurrentLocationMarker)")
        mapView.currentLocationTrackingMode = .onWithoutHeading
        
        mapView.addPOIItems(createMarker())
        mapView.addPolyline(createPolyline())
        
        return mapView
    }
}
