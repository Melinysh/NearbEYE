//
//  TableViewCellArt.swift
//  NearbEYE
//
//  Created by Aaron Cotter on 2015-10-24.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class TableViewCellArt: UITableViewCell {

    @IBOutlet weak var artNameLabel: UILabel!
    @IBOutlet weak var artArtistLabel: UILabel!
    @IBOutlet weak var artURLLabel: UILabel!
    @IBOutlet weak var artYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func configureCell(cell : TableViewCellArt, data : Art) {
        cell.artNameLabel.text = (data.name)
        cell.artArtistLabel.text = (data.artist)
		cell.artURLLabel.text = data.url != nil ? "URL: " + data.url! : ""
		cell.artYearLabel.text =  data.yearInstalled != nil ? "Year installed : " + String(data.yearInstalled!) : ""
    }
    
}
