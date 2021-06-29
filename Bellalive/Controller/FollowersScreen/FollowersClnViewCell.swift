//
//  FollowersClnViewCell.swift
//  Bellalive
//
//  Created by APPLE on 20/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class FollowersClnViewCell: UICollectionViewCell {
    @IBOutlet weak var ViewBG: UIView!
    @IBOutlet weak var LblTitle: CustomLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ViewBG.frame = LblTitle.bounds
    }
}
