//
//  CustomView.swift
//
//  Created by Sabarish on 06/08/19.
//  Copyright © 2019 PZY Mac Mini 7. All rights reserved.
//



import Foundation
import UIKit

@IBDesignable class CustomView: UIView {
    @IBInspectable var borderWidth : CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var shadowColor : UIColor = UIColor.black {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var borderColor : UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowOffset : CGSize = CGSize(width: 0, height: 0){
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowOpacity : Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var cornerRadius : CGFloat = 10.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}

extension UILabel {

    @IBInspectable var isShadowOnText: Bool {
        get {
            return self.isShadowOnText
        }
        set {
            guard (newValue as? Bool) != nil else {
                return
            }

            if newValue == true{

                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowRadius = 2.0
                self.layer.shadowOpacity = 1.0
                self.layer.shadowOffset = CGSize(width: 2, height: 2)
                self.layer.masksToBounds = false
            }
        }
    }
}
