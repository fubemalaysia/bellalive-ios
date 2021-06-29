//
//  BLWithdrawelListTVC.swift
//  Bellalive
//
//  Created by apple on 01/04/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class BLWithdrawelListTVC: UITableViewCell {
    
    @IBOutlet weak var pointImg: UIImageView!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
