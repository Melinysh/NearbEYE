//
//  TableViewCellUrbanDesign.swift
//  NearbEYE
//
//  Created by Aaron Cotter on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class TableViewCellUrbanDesign: UITableViewCell {

    
    @IBOutlet weak var urbandesignNameLabel: UILabel!
    @IBOutlet weak var urbandesignAwardLabel: UILabel!
    @IBOutlet weak var urbandesignAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(cell : TableViewCellUrbanDesign, data : UrbanDesignAward) {
        urbandesignNameLabel.text = (data.projectName)
        urbandesignAwardLabel.text = (data.awardName)
        urbandesignAddressLabel.text = (data.address)
    }
    
}
