//
//  VideoCommentTVC.swift
//  Bellalive
//
//  Created by apple on 20/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class VideoCommentTVC: UITableViewCell {

    @IBOutlet weak var LblVideoMessage: UILabel!
    @IBOutlet weak var LblVideoUser: UILabel!
    @IBOutlet weak var LblVideoRating: UILabel!
    @IBOutlet weak var ImgVideoRating: UIImageView!
    @IBOutlet weak var ViewVideoRating: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewVideoRating.layer.cornerRadius = ViewVideoRating.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
