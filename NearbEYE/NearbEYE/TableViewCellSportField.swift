//
//  TableViewCellSportField.swift
//  NearbEYE
//
//  Created by Aaron Cotter on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class TableViewCellSportField: UITableViewCell {

    
    @IBOutlet weak var sportParkingLabel: UILabel!
    @IBOutlet weak var sportWashroomsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func configureCell(cell : TableViewCellSportField, data : SportField) {
        cell.sportWashroomsLabel.text = (data.hasWashrooms?.boolValue == true) ? "Has washrooms" : "Doesn't have washrooms"
        cell.sportParkingLabel.text = (data.hasParking?.boolValue == true) ? "Has parking" : "Doesn't have parking"
    }
    
}
