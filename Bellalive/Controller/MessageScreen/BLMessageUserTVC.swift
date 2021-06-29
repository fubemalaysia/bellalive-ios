//
//  BLMessageUserTVC.swift
//  Bellalive
//
//  Created by apple on 01/04/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class BLMessageUserTVC: UITableViewCell {
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var actiiveView: UIView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var activeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.userImg.layer.cornerRadius = self.userImg.frame.height/2
            self.actiiveView.layer.cornerRadius = self.actiiveView.frame.height/2
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
