//
//  HeaderBalanceTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

struct balanceDetail{
    let balance: String
    let time: String
    let activity: String
    init(balance: String,time: String,activity: String) {
        self.balance = balance
        self.time = time
        self.activity = activity
    }
}
class HeaderBalanceTblViewCell: UITableViewCell {

    @IBOutlet weak var LblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
