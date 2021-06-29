//
//  HeaderTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

struct DetailsSettings{
    let Title: String
    let Cache: String?
    init(title:String,cache:String?) {
        self.Title = title
        self.Cache = cache
    }
}
class HeaderTblViewCell: UITableViewCell {

    @IBOutlet weak var LblTitleHeader: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
