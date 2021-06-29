//
//  CountryTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 30/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class CountryTblViewCell: UITableViewCell {

    @IBOutlet weak var LblCountryCode: UILabel!
    @IBOutlet weak var LblCountryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
