//
//  ContributionTblCell.swift
//  Bellalive
//
//  Created by apple on 03/04/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class ContributionTblCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var pointsLbl: UILabel!
    @IBOutlet weak var giftIdLbl: UILabel!
    
    
    
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
