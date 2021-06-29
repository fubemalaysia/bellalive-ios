//
//  ChatScreen.swift
//  Bellalive
//
//  Created by APPLE on 27/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class ChatScreen: UIViewController,UITextFieldDelegate {
    var isKeyboardShowing : Bool = false
    @IBOutlet weak var ViewMessageBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var TxtFieldMessage: UITextField!
    @IBOutlet weak var ViewTxtField: UIView!
    @IBOutlet weak var ViewMessage: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TxtFieldMessage.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    @IBAction func BtnSendMessage(_ sender: UIButton) {
    }
    @objc func handleKeyboardNotification(notification:NSNotification){
        if let userInfo = notification.userInfo{
            if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue{
                print(keyboardFrame as Any)
                isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
//                if #available(iOS 11.0, *) {
//                    let window = UIApplication.shared.keyWindow
//                    _ = window?.safeAreaInsets.top
//                    let bottomPadding = window?.safeAreaInsets.bottom
//                    ViewMessageBottomConstraint.constant = isKeyboardShowing ? (keyboardFrame.height - (bottomPadding ?? 0)) : 0
//                }else{
                ViewMessageBottomConstraint.constant = isKeyboardShowing ? keyboardFrame.height + ViewMessage.frame.height : 0
//                }
                print(ViewMessageBottomConstraint.constant)
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    self.view.layoutIfNeeded()
                }) { (completion) in
                    
                }
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
