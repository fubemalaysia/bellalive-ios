//
//  TopFansTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class TopFansTblViewCell: UITableViewCell {

    @IBOutlet weak var BtnAddOutlet: UIButton!
    @IBOutlet weak var LblRating: UILabel!
    @IBOutlet weak var ImgRating: UIImageView!
    @IBOutlet weak var ViewRating: UIView!
    @IBOutlet weak var LblProfileID: UILabel!
    @IBOutlet weak var LblProfileName: UILabel!
    @IBOutlet weak var ImgViewProfilePic: UIImageView!
    @IBOutlet weak var LblCount: UILabel!
    @IBOutlet weak var ImgCrown: UIImageView!
    @IBAction func BtnAdd(_ sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
