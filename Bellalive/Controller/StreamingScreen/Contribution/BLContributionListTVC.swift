//
//  BLContributionListTVC.swift
//  Bellalive
//
//  Created by apple on 02/04/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class BLContributionListTVC: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var giftNameLbl: UILabel!
    @IBOutlet weak var giftImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var giftCountLbl: UILabel!
    
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
