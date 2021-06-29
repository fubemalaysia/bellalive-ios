//
//  Toast.swift
//  Bellalive
//
//  Created by APPLE on 06/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
import UIKit

class Toast: NSObject{
    static func makeToast(message: String,in vc: UIView,completion: @escaping()->(Void)){
        let ToastLbl = UILabel()
        ToastLbl.text = message
        ToastLbl.textAlignment = .center
        ToastLbl.font = UIFont.boldSystemFont(ofSize: 15)
        ToastLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ToastLbl.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ToastLbl.numberOfLines = 0
        let LblSize = ToastLbl.intrinsicContentSize
        let lblHeight = (LblSize.width / vc.frame.width) * 30
        let lblWidth = min(LblSize.width, vc.frame.width - 40)
        let ContentHeight = max(lblHeight, LblSize.height + 20)
        ToastLbl.frame = CGRect(x: 20, y: (vc.frame.height - 80) - ContentHeight, width: lblWidth + 20, height: ContentHeight)
        ToastLbl.center.x = vc.center.x
        ToastLbl.layer.cornerRadius = ToastLbl.frame.size.height / 3
        ToastLbl.layer.masksToBounds = true
        vc.addSubview(ToastLbl)
        UIView.animate(withDuration: 5.0, animations: {
            ToastLbl.alpha = 0
        }) { (_) in
            completion()
            ToastLbl.removeFromSuperview()
        }
    }
    
}
class Utility{
    static func formatDateAndTime(dateString: String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        if let formattedDate = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "EEE, MMM dd yyyy, hh:mm a"
            dateFormatter.timeZone = NSTimeZone.local
            return dateFormatter.string(from: formattedDate)
        }
        return dateString
    }
    
    static func formatDate(dateString: String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        if let formattedDate = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy/MM/dd"
            dateFormatter.timeZone = NSTimeZone.local
            return dateFormatter.string(from: formattedDate)
        }
        return dateString
    }

}
