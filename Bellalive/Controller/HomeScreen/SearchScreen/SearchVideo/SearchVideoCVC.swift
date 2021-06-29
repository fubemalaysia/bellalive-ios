//
//  SearchVideoCVC.swift
//  Bellalive
//
//  Created by apple on 29/03/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class SearchVideoCVC: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var thumbLbl: UILabel!
    @IBOutlet weak var viewCountLbl: UILabel!
    @IBOutlet weak var viewCountBg: CustomView!
    
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewCountBg.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        
        self.viewCountBg.layer.cornerRadius = CGFloat(roundf(Float(self.viewCountBg.frame.size.height / 2.0)))
    }

}
