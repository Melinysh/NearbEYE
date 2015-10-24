//
//  TableViewCellPOI.swift
//  NearbEYE
//
//  Created by Aaron Cotter on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class TableViewCellPOI: UITableViewCell {

    @IBOutlet weak var poiNameLabel: UILabel!
    @IBOutlet weak var poiOwnerLabel: UILabel!
    @IBOutlet weak var poiTypeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(cell : TableViewCellPOI, data : PointOfInterest) {
        poiNameLabel.text = (data.name)
        poiOwnerLabel.text = (data.owner)
        poiTypeLabel.text = (data.type)
    }
    
}
