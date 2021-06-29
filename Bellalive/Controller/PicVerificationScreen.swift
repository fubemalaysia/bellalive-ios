//
//  PicVerificationScreen.swift
//  Bellalive
//
//  Created by APPLE on 19/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class PicVerificationScreen: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var BtnConfirmOutlet: UIButton!
    @IBOutlet weak var TxtFieldVerificationCode: UITextField!
    @IBOutlet weak var ImgVerificationCode: UIImageView!
    @IBOutlet weak var ViewDetailsPic: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TxtFieldVerificationCode.delegate = self
        ViewDetailsPic.layer.cornerRadius = 15
        BtnConfirmOutlet.layer.cornerRadius = BtnConfirmOutlet.frame.height / 2
        let color1 :UIColor = #colorLiteral(red: 0.6431372549, green: 0.2196078431, blue: 0.6274509804, alpha: 1)
        let color2 :UIColor = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        BtnConfirmOutlet.applyGradient(colors: [color1.cgColor,color2.cgColor])
        // Do any additional setup after loading the view.
    }
    @IBAction func BtnClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func BtnConfirm(_ sender: UIButton) {
        guard let pic = TxtFieldVerificationCode.text, pic.count != 0 else{
            Alert.TextField(on: self, text: "Code", type: .Empty)
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "SmsVerificationScreenID") as! SmsVerificationScreen
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
