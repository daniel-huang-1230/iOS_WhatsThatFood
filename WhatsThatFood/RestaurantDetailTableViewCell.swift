//
//  RestaurantDetailTableViewCell.swift
//  
//
//  Created by Daniel Huang on 21/7/2017.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class RestaurantDetailTableViewCell: UITableViewCell {

    @IBOutlet var fieldLabel:UILabel!
    @IBOutlet var valueLabel:UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
