//
//  SmsVerificationScreen.swift
//  Bellalive
//
//  Created by APPLE on 20/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

var main_string = "SMS verification has been sent to your mobile phone"
var phone_number = "1234567890"
class SmsVerificationScreen: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var TxtFieldCode4: UITextField!
    @IBOutlet weak var TxtFieldCode3: UITextField!
    @IBOutlet weak var TxtFieldCode2: UITextField!
    @IBOutlet weak var TxtFieldCode1: UITextField!
    @IBOutlet weak var LblTextPhoneNo: UILabel!
    @IBOutlet weak var BtnGetCodeOutlet: UIButton!
    @IBOutlet weak var BtnLogInOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnLogInOutlet.layer.cornerRadius = BtnLogInOutlet.frame.height / 2
        TxtFieldCode1.becomeFirstResponder()
        TxtFieldCode1.setLeftPaddingPoints(TxtFieldCode1.frame.width/2)
        TxtFieldCode2.setLeftPaddingPoints(TxtFieldCode2.frame.width/2)
        TxtFieldCode3.setLeftPaddingPoints(TxtFieldCode3.frame.width/2)
        TxtFieldCode4.setLeftPaddingPoints(TxtFieldCode4.frame.width/2)
        TxtFieldCode1.addBottomBorderTo()
        TxtFieldCode2.addBottomBorderTo()
        TxtFieldCode3.addBottomBorderTo()
        TxtFieldCode4.addBottomBorderTo()
        phone_number = replace(myString: phone_number, [3,4,5,6,7], "*")
        main_string = main_string + " " + phone_number
        let range = (main_string as NSString).range(of: phone_number)
        let color : UIColor = #colorLiteral(red: 1, green: 0.6498119235, blue: 0, alpha: 1)
        let attribute = NSMutableAttributedString.init(string: main_string)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: range)
        LblTextPhoneNo.attributedText = attribute
        // Do any additional setup after loading the view.
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnLogIn(_ sender: UIButton) {
        guard let otp1 = TxtFieldCode1.text, otp1.count != 0 else{
            Alert.TextField(on: self, text: "OTP", type: .Empty)
            return
        }
        guard let otp2 = TxtFieldCode2.text, otp2.count != 0 else{
            Alert.TextField(on: self, text: "OTP", type: .Empty)
            return
        }
        guard let otp3 = TxtFieldCode3.text, otp3.count != 0 else{
            Alert.TextField(on: self, text: "OTP", type: .Empty)
            return
        }
        guard let otp4 = TxtFieldCode4.text, otp4.count != 0 else{
            Alert.TextField(on: self, text: "OTP", type: .Empty)
            return
        }
        UserDefaults.standard.set("1", forKey: "Login")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "CustomTabBarControllerID") as! CustomTabBarController
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    @IBAction func BtnGetCode(_ sender: UIButton) {
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if ((textField.text?.count)! < 1 ) && (string.count > 0) {
               if textField == TxtFieldCode1 {
                   TxtFieldCode2.becomeFirstResponder()
               }
               
               if textField == TxtFieldCode2 {
                   TxtFieldCode3.becomeFirstResponder()
               }
               
               if textField == TxtFieldCode3 {
                   TxtFieldCode4.becomeFirstResponder()
               }
               
               if textField == TxtFieldCode4 {
                   TxtFieldCode4.resignFirstResponder()
               }
               
               textField.text = string
               return false
           } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
               if textField == TxtFieldCode2 {
                   TxtFieldCode1.becomeFirstResponder()
               }
               if textField == TxtFieldCode3 {
                   TxtFieldCode2.becomeFirstResponder()
               }
               if textField == TxtFieldCode4 {
                   TxtFieldCode3.becomeFirstResponder()
               }
               if textField == TxtFieldCode1 {
                   TxtFieldCode1.resignFirstResponder()
               }
               
               textField.text = ""
               return false
           } else if (textField.text?.count)! >= 1 {
               textField.text = string
               return false
           }
        return true
       }
    func replace(myString: String, _ index: [Int], _ newChar: Character) -> String {
        var modifiedString: String!
        var chars = Array(myString)
        for ind in index {                // gets an array of characters
            chars[ind] = newChar
        }
        modifiedString = String(chars)
        return modifiedString
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    func addBottomBorderTo() {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = CGRect(x: 0.0, y: self.frame.size.height - 2.0, width: self.frame.size.width, height: 2.0)
        self.layer.addSublayer(layer)
    }
}
