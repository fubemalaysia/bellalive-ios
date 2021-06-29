//
//  CustomLabel.swift
//  Bellalive
//
//  Created by APPLE on 20/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class CustomLabel : UILabel{
    override var intrinsicContentSize: CGSize{
        let originalsize = super.intrinsicContentSize
        let height = originalsize.height + 12
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: originalsize.width + 22, height: height)
    }
}

class Custom : UILabel{
    override var intrinsicContentSize: CGSize{
        let originalsize = super.intrinsicContentSize
        let height = originalsize.height + 12
        layer.masksToBounds = true
        return CGSize(width: originalsize.width + 10, height: height)
    }
}

