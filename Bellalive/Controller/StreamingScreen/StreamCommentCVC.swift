//
//  StreamCommentCVC.swift
//  Bellalive
//
//  Created by apple on 15/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class StreamCommentCVC: UICollectionViewCell {
    @IBOutlet weak var borderView : UIView!
    @IBOutlet weak var userPic: UIImageView!
    
   
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.borderView.layer.masksToBounds = true
        self.userPic.layer.masksToBounds = true
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        self.borderView.layer.cornerRadius = CGFloat(roundf(Float(self.borderView.frame.size.height / 2.0)))
        self.userPic.layer.cornerRadius = CGFloat(roundf(Float(self.userPic.frame.size.height / 2.0)))
      
    }
}
