//
//  SeachCityCell.swift
//  Groute
//
//  Created by 이민재 on 28/05/2020.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit

class SeachCityCell: UITableViewCell{
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityEtc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityImage.layer.cornerRadius = cityImage.frame.height / 2
        cityImage.layer.borderWidth = 1
        cityImage.layer.borderColor = UIColor.clear.cgColor
        cityImage.clipsToBounds = true
        cityName.sizeToFit()
        cityEtc.sizeToFit()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
