//
//  LegionsFansTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 25/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class LegionsFansTblViewCell: UITableViewCell {

    @IBOutlet weak var bellaliveIbLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.userImage.layer.cornerRadius = self.userImage.frame.height/2
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
