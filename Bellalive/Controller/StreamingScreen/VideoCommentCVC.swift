//
//  VideoCommentCVC.swift
//  Bellalive
//
//  Created by apple on 20/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class VideoCommentCVC: UICollectionViewCell {
    @IBOutlet weak var videoBorderView : UIView!
    @IBOutlet weak var videoUserPic: UIImageView!
    @IBOutlet weak var crownImg: UIImageView!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.videoBorderView.layer.masksToBounds = true
        self.videoUserPic.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        
        self.videoBorderView.layer.cornerRadius = CGFloat(roundf(Float(self.videoBorderView.frame.size.height / 2.0)))
        self.videoUserPic.layer.cornerRadius = CGFloat(roundf(Float(self.videoUserPic.frame.size.height / 2.0)))
    }
}
