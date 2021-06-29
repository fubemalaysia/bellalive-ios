//
//  SystemTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class SystemTblViewCell: UITableViewCell {

    @IBOutlet weak var SwitchOutlet: UISwitch!
    @IBOutlet weak var LblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        set(width: SwitchOutlet.frame.width - 20, height: 20)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(width: CGFloat, height: CGFloat) {

        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        SwitchOutlet.transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}
