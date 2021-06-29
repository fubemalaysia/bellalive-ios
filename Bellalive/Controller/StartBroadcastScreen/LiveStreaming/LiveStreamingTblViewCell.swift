//
//  LiveStreamingTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 25/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

struct liveStreamData{
    let rating: Int
    let name:String
    let message:String
    let ratingColor:UIColor
    init(rating: Int,name:String,message:String,ratingColor:UIColor) {
        self.rating = rating
        self.name = name
        self.message = message
        self.ratingColor = ratingColor
    }
}
class LiveStreamingTblViewCell: UITableViewCell {

    @IBOutlet weak var LblMessage: UILabel!
    @IBOutlet weak var LblUser: UILabel!
    @IBOutlet weak var LblRating: UILabel!
    @IBOutlet weak var ImgRating: UIImageView!
    @IBOutlet weak var ViewRating: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewRating.layer.cornerRadius = ViewRating.frame.height/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


