//
//  TableViewCellParks.swift
//  NearbEYE
//
//  Created by Aaron Cotter on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit
import QuartzCore

class TableViewCellParks: UITableViewCell {
    
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkAddressLabel: UILabel!
    @IBOutlet weak var parkWashroomLabel: UILabel!
    @IBOutlet var bottomView : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let translucentWhite = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.55).CGColor
        
        let gradientBottom = CAGradientLayer()
        gradientBottom.frame = bottomView.bounds
        gradientBottom.colors = [translucentWhite, translucentWhite, UIColor.clearColor().CGColor, UIColor.clearColor().CGColor, translucentWhite, translucentWhite]
        gradientBottom.locations = [0.0, 0.08, 0.35, 0.65, 0.92, 0.0]
        bottomView.layer.mask = gradientBottom
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)        
        // Configure the view for the selected state
    }
    static func configureCell(cell : TableViewCellParks, data : Park) {
        cell.parkNameLabel.text = (data.name)
        cell.parkAddressLabel.text = (data.address)
		cell.parkWashroomLabel.text = "Number of washrooms : " + (data.washrooms != nil ? String(data.washrooms!) : "0")
    }
}
