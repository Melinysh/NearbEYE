//
//  TableViewCellParks.swift
//  NearbEYE
//
//  Created by Aaron Cotter on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class TableViewCellParks: UITableViewCell {
    
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkAddressLabel: UILabel!
    @IBOutlet weak var parkWashroomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(cell : TableViewCellParks, data : Park) {
        parkNameLabel.text = (data.name)
        parkAddressLabel.text = (data.address)
        parkWashroomLabel.text = "Number of washrooms : " + String(data.washrooms)
    }
}
