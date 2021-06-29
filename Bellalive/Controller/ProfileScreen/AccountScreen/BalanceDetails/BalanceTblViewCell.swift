//
//  BalanceTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class BalanceTblViewCell: UITableViewCell {

    @IBOutlet weak var LblBalance: UILabel!
    @IBOutlet weak var LblTimeDuration: UILabel!
    @IBOutlet weak var LblActivity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
