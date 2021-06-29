//
//  BLBlockListTVC.swift
//  Bellalive
//
//  Created by apple on 31/03/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class BLBlockListTVC: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var blockBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        let color1 = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        let color2 = #colorLiteral(red: 0.5333333333, green: 0.2823529412, blue: 0.9725490196, alpha: 1)
        blockBtn.applyGradientButton(colors: [color1.cgColor,color2.cgColor])
        DispatchQueue.main.async {
            self.imgView.layer.cornerRadius = self.imgView.frame.height/2
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
