//
//  BLGuestUserVideoCVC.swift
//  Bellalive
//
//  Created by apple on 11/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class BLGuestUserVideoCVC: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var videoContentLbl: UILabel!
    @IBOutlet weak var viewCountLbl: UILabel!
    @IBOutlet weak var countView: UIView!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.countView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        self.countView.layer.cornerRadius = CGFloat(roundf(Float(self.countView.frame.size.height / 2.0)))
    }
}
