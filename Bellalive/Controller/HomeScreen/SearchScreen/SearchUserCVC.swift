//
//  SearchUserCVC.swift
//  Bellalive
//
//  Created by apple on 29/03/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class SearchUserCVC: UICollectionViewCell {
    @IBOutlet weak var bgView: UIView!
     @IBOutlet weak var imgView: UIImageView!
     @IBOutlet weak var userNameLbl: UILabel!
     @IBOutlet weak var bellaliveIdLbl: UILabel!
    
     override func awakeFromNib() {
         super.awakeFromNib()
         self.bgView.layer.masksToBounds = true
         self.imgView.layer.masksToBounds = true
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         
         self.setCircularImageView()
     }
     
     func setCircularImageView() {
         self.bgView.layer.cornerRadius = CGFloat(roundf(Float(self.bgView.frame.size.height / 2.0)))
         self.imgView.layer.cornerRadius = CGFloat(roundf(Float(self.imgView.frame.size.height / 2.0)))
     }
}
