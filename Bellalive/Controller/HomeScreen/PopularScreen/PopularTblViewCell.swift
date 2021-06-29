//
//  PopularTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 24/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class PopularTblViewCell: UITableViewCell {

    @IBOutlet weak var LblPoints: UILabel!
    @IBOutlet weak var LblProfileName: UILabel!
    @IBOutlet weak var ImgRanking: UIImageView!
    @IBOutlet weak var ImgProfilePic: UIImageView!
    @IBOutlet weak var LblCount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.ImgProfilePic.layer.cornerRadius = self.ImgProfilePic.frame.height/2
            self.ImgRanking.layer.cornerRadius = self.ImgRanking.frame.height/2
            self.ImgRanking.layer.borderWidth = 2
            self.ImgRanking.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.ImgProfilePic.clipsToBounds = true
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.ImgProfilePic.layer.cornerRadius = self.ImgProfilePic.frame.height/2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
