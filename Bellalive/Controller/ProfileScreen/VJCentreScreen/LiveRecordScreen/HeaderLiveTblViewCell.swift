//
//  HeaderLiveTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

struct liveDetail{
    let time: String
    let points: String
    init(time: String,points: String) {
        self.time = time
        self.points = points
    }
}
class HeaderLiveTblViewCell: UITableViewCell {

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
