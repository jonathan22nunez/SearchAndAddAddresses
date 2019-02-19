//
//  SearchedTableViewCell.swift
//  NunezJonathan_CE08
//
//  Created by Jonathan Nunez on 12/9/18.
//  Copyright © 2018 Jonathan Nunez. All rights reserved.
//

import UIKit

class SearchedTableViewCell: UITableViewCell {
    
    // MARK: Preparations
    @IBOutlet weak var cityStateLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitutdeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
