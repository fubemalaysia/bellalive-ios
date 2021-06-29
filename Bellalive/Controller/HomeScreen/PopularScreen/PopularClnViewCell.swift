//
//  PopularClnViewCell.swift
//  Bellalive
//
//  Created by APPLE on 24/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class PopularClnViewCell: UICollectionViewCell {
    @IBOutlet weak var LblTitle: CustomLbl!
    
}
class CustomLbl : UILabel{
    override var intrinsicContentSize: CGSize{
        let originalsize = super.intrinsicContentSize
        let height = originalsize.height + 12
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: originalsize.width + 50, height: height)
    }
}
