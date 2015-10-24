//
//  TableViewCellRink.swift
//  NearbEYE
//
//  Created by Aaron Cotter on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class TableViewCellRink: UITableViewCell {

    @IBOutlet weak var rinkNameLabel: UILabel!
    @IBOutlet weak var rinkScheduleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //Saving description for expanded table cell as 20+ words 
    func configureCell(cell : TableViewCellRink, data : Rink) {
        rinkNameLabel.text = (data.name)
        rinkScheduleLabel.text = "Rink schedule: " + String(data.schedule_url)
    }
}
