//
//  SecondTabTableViewCell.swift
//  Groute
//
//  Created by 이민재 on 17/05/2020.
//  Copyright © 2020 김기현. All rights reserved.
//

import UIKit

class SecondTabTableViewCell: UITableViewCell {

    @IBOutlet weak var routeImage: UIImageView!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var When: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
