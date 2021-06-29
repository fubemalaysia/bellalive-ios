//
//  FollowingLiveCVC.swift
//  Bellalive
//
//  Created by apple on 16/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class FollowingLiveCVC: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var likeCountLbl: UILabel!
    @IBOutlet weak var likeCountBg: CustomView!
    @IBOutlet weak var viewCountLbl: UILabel!
    @IBOutlet weak var viewCountBg: UIView!
    @IBOutlet weak var thumbLbl: UILabel!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.likeCountBg.layer.masksToBounds = true
        self.viewCountBg.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        self.viewCountBg.layer.cornerRadius = CGFloat(roundf(Float(self.viewCountBg.frame.size.height / 2.0)))
        self.likeCountBg.layer.cornerRadius = CGFloat(roundf(Float(self.likeCountBg.frame.size.height / 2.0)))
    }
    
}
