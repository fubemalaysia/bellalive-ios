//
//  NearbyCVCell.swift
//  Bellalive
//
//  Created by apple on 10/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class NearbyCVCell: UICollectionViewCell {
    @IBOutlet weak var rankingImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var giftPoint: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var giftCountView: UIView!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImg.layer.masksToBounds = true
        self.giftCountView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        self.profileImg.layer.cornerRadius = CGFloat(roundf(Float(self.profileImg.frame.size.height / 2.0)))
        self.giftCountView.layer.cornerRadius = CGFloat(roundf(Float(self.giftCountView.frame.size.height / 2.0)))
    }
}
