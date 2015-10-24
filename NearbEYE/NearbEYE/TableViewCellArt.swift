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
    func configureCell(cell : TableViewCellArt, data : Art) {
        artNameLabel.text = (data.name)
        artArtistLabel.text = (data.artist)
        artURLLabel.text = "URL" + String(data.url)
        artYearLabel.text = "Year installed : " + String(data.yearInstalled)
    }
    
}
