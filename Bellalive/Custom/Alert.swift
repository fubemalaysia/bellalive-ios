//
//  Alert.swift
//  Bellalive
//
//  Created by APPLE on 27/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
enum AlertType : String{
    case Empty = "Please Enter Your"
    case Select = "Please Select"
    case Camera = "Please Run"
    case Invalid = "Please Enter Valid"
    case LessChar = "Please Enter Aleast 6 Character in"
    case MisMatch = "Please Enter Same"
    case Mobile = "Please Enter Aleast 10 Character in"
    case CodeMissing = "Please Enter 4 Digit Code Sended to your"
}
class Alert: NSObject {
    private static func ShowAlert(on vc: UIViewController, with title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addColorInTitleAndMessage(titleColor: .darkGray, messageColor: .lightGray, titleFont: <#T##UIFont#>, messageFont: <#T##UIFont#>)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        vc.present(alert,animated: true)
    }
    static func TextField(on vc: UIViewController,text:String,type : AlertType){
        var msg : String!
        if type == .Camera{
            msg = type.rawValue + " " + text + " "  + "on Real Device"
        }else{
            msg = type.rawValue + " " + text
        }
        ShowAlert(on: vc, with: text, message: msg)
    }
}
