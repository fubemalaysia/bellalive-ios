//
//  SignInScreen.swift
//  Bellalive
//
//  Created by APPLE on 19/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignInScreen: UIViewController,UITextFieldDelegate, dismissCountry {

    @IBOutlet weak var ImgBackGround: UIImageView!
    @IBOutlet weak var ViewSignIn: UIView!
    @IBOutlet weak var BtnSignInOutlet: UIButton!
    @IBOutlet weak var BtnVerificationOutlet: UIButton!
    @IBOutlet weak var TxtViewAgreement: UITextView!
    @IBOutlet weak var BtnAgreeOutlet: UIButton!
    @IBOutlet weak var TxtFieldPhoneNo: UITextField!
    @IBOutlet weak var ImgArrow: UIImageView!
    @IBOutlet weak var LblCountryCode: UILabel!
    @IBOutlet weak var ViewPhone: UIView!
    @IBOutlet weak var ViewTopDetails: UIView!
    @IBOutlet weak var BtnRegisterOutlet: UIView!
    @IBOutlet weak var ViewPassword: UIView!
    @IBOutlet weak var TxtFieldPassword: UITextField!
    
    @IBOutlet weak var passwordViewHeight: NSLayoutConstraint!
    
    var countrySelected : Int?
    var stdcode = String()
    var loginData : loginApi?
    var userData: smsVerifyApi?
     var smsSendData : SmsSendModel?
    var termSelect = false
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordViewHeight.constant = 0
        TxtFieldPhoneNo.delegate = self
        TxtFieldPassword.delegate = self
        ViewTopDetails.layer.cornerRadius = 15
        ViewPhone.layer.cornerRadius = ViewPhone.frame.height / 2
        ViewPassword.layer.cornerRadius = ViewPassword.frame.height / 2
        BtnVerificationOutlet.layer.cornerRadius = BtnVerificationOutlet.frame.height / 2
        BtnSignInOutlet.layer.cornerRadius = BtnSignInOutlet.frame.height / 2
        let color1 :UIColor = #colorLiteral(red: 0.6431372549, green: 0.2196078431, blue: 0.6274509804, alpha: 1)
        let color2 :UIColor = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        BtnSignInOutlet.applyGradient(colors: [color1.cgColor,color2.cgColor])
//        BtnSignInOutlet.isHidden = true
//        ViewSignIn.isHidden = true
        let url = Bundle.main.url(forResource: "vid", withExtension: "gif")!
        ImgBackGround.image = UIImage.gifImageWithURL(url.absoluteString)
    }
    
    @IBAction func BtnCountryCode(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "CountryScreenID") as! CountryScreen
        rootVC.modalPresentationStyle = .overCurrentContext
        rootVC.delegateDismiss = self
        self.navigationController?.present(rootVC, animated: true)
    }
    @IBAction func BtnAgree(_ sender: UIButton) {
        termSelect = true
        BtnAgreeOutlet.isSelected = sender.isSelected ? false : true
    }
    @IBAction func BtnVerification(_ sender: UIButton) {
//        guard let phone = TxtFieldPhoneNo.text, phone.count != 0 else{
//            Alert.TextField(on: self, text: "Phone Number", type: .Empty)
//            return
//        }
//        if phone.count < 10{
//            Alert.TextField(on: self, text: "Phone Number", type: .Mobile)
//            return
//        }
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let rootVC = storyboard.instantiateViewController(identifier: "PicVerificationScreenID") as! PicVerificationScreen
//        rootVC.modalPresentationStyle = .fullScreen
//        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    @IBAction func BtnRegister(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "SignUpScreenID") as! SignUpScreen
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    @IBAction func BtnSignIn(_ sender: UIButton) {
        if sender.currentTitle?.lowercased() == "send"{
            let validate = withoutcodeValidation()
            if validate.isEmpty{
                let connect = isNetworkReachable()
                if connect == nil{
                    sendSmsCode()
                }
            }else{
                createAlertBox(title: "", message: validate, buttonName: "OK")
            }
        }else{
           let validate = withcodeValidation()
            if validate.isEmpty{
                let connect = isNetworkReachable()
                if connect == nil{
                    verifySmsCode()
                }
            }else{
                createAlertBox(title: "", message: validate, buttonName: "OK")
            }
        }
    }
    @IBAction func BtnFacebook(_ sender: UIButton) {
    }
    @IBAction func BtnTwitter(_ sender: UIButton) {
    }
    @IBAction func BtnGoogle(_ sender: UIButton) {
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func dismissCountryCode(dataCode: String, data: String, dataID: Int?, stdCode : String) {
        LblCountryCode.text = dataCode
        countrySelected = dataID
        stdcode = stdCode
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    func signInApi(params:[String:Any]){
        WebService.shared.postMethod(Api: .login, parameter: params) { (response) -> (Void) in
            do{
                let json = try JSONDecoder().decode(loginApi.self, from: response)
                self.loginData = json
                UserDefaults.standard.set(json.data?.id, forKey: "UserID")
                Toast.makeToast(message: self.loginData?.status ?? "", in: self.view) { () -> (Void) in
                    if (self.loginData?.status?.lowercased().contains("success"))!{
                        if let token = self.loginData?.data?.token{
                            UserDefaults.standard.set(token, forKey: "token")
                            tokenID = token
                            print("tokenID",token)
                            self.apicallforUpdateToken(token: token)
                        }
                        UserDefaults.standard.set(json.data?.id, forKey: "UserID")
                        UserDefaults.standard.set("1", forKey: "Login")
        //                isLogin = "1"
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let rootVC = storyboard.instantiateViewController(withIdentifier: "CustomTabBarControllerID") as! CustomTabBarController
                        rootVC.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(rootVC, animated: true)
                    }
                }
                if let errorMsg = self.loginData?.error{
                    Toast.makeToast(message: errorMsg, in: self.view) { () -> (Void) in
                    }
                }
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }

    
    private func sendSmsCode(){
        
        let url = "https://www.isms.com.my/2FA/request.php?mobile=\(TxtFieldPhoneNo.text!)&country_code=\(stdcode)&un=martinho123&pass=bellalive123&type=1&sendid=Bellalive&message="
        
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.queryString, headers: [:]).responseJSON {[weak self] (response) in
                guard let weakself = self else { return }
               debugPrint(response.result)
                switch response.result{
                    case .success(let json):
                     if let statusCode = response.response?.statusCode{
                         if statusCode == 200{
                             let value = JSON(json)
                            print(value)
                             weakself.smsSendData = (SmsSendModel(fromJson: value))
                            weakself.BtnSignInOutlet.setTitle("VERIFY", for: .normal)
                            weakself.ViewPassword.isHidden = false
                            weakself.passwordViewHeight.constant = 50
                         }else{
                             guard let dict = json as? [String: Any],
                             let message = dict["message"] as? String else{
                                 return
                             }
                            weakself.createAlertBox(title: message, message: "", buttonName: "OK")
                         }
                     }
                    case .failure(let err):
                        weakself.createAlertBox(title: err.localizedDescription, message: "", buttonName: "OK")
                        print(err.localizedDescription)
                    }
           }

    }
    
    
    private func verifySmsCode(){
        
        let url = "https://www.isms.com.my/2FA/request.php?interval=3&mobile=\(TxtFieldPhoneNo.text!)&country_code=\(stdcode)&un=martinho123&pass=bellalive123&sendid=Bellalive&method=verify&code=\(smsSendData?.code ?? "")&sms_id=\(smsSendData?.smsId ?? "")&uuid=\(smsSendData?.uuid ?? "")"
        
        
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.queryString, headers: [:]).responseJSON {[weak self] (response) in
                guard let weakself = self else { return }
                debugPrint(response.result)
                switch response.result{
                    case .success(let json):
                     if let statusCode = response.response?.statusCode{
                         if statusCode == 200{
                             let value = JSON(json)
                            print(value)
                            let params = ["phone_no": weakself.TxtFieldPhoneNo.text!,
                                          "country_id": weakself.countrySelected ?? 0] as [String : Any]
                            weakself.signInApi(params: params)
                         }else{
                             guard let dict = json as? [String: Any],
                             let message = dict["message"] as? String else{
                                 return
                             }
                            weakself.createAlertBox(title: message, message: "", buttonName: "OK")
                         }
                     }
                    case .failure(let err):
                        weakself.createAlertBox(title: err.localizedDescription, message: "", buttonName: "OK")
                        print(err.localizedDescription)
                    }

           }

    }
    
    
    private func apicallforUpdateToken(token : String){
        guard let deviceToken = UserDefaults.standard.value(forKey: "deviceToken") else{return}
        let param = ["device_token" : deviceToken] as [String : Any]
        WebService.shared.postMethodHeader(Api: .updateToken, parameter: param, token: token){ (response) -> (Void) in
            do{
                let data = try JSONDecoder().decode(UpdateTokenModel.self, from: response)
                print(data.status ?? "")
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func withoutcodeValidation() -> String{
        if TxtFieldPhoneNo.text == ""{
            return "Enter the phone number"
        }else if LblCountryCode.text == "+00"{
            return "Select the country"
        }
        return "";
    }
    
    private func withcodeValidation() -> String{
        if TxtFieldPhoneNo.text == ""{
            return "Enter the phone number"
        }else if LblCountryCode.text == "+00"{
            return "Select the country"
        }else if TxtFieldPassword.text == ""{
            return "Enter the verification code"
        }else if termSelect == false{
            return "Select the terms and conditions"
        }
        return "";
    }
}
extension UIView {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    func applyGradientButton(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 5
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyGradientLive(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.width/2
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    func applyTopBottomGradient(colors: [CGColor]){
        self.backgroundColor = nil
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.shouldRasterize = true
        gradientLayer.cornerRadius = self.frame.height/2
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor,cornerRadius:CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadius
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
/*
     func smsVerification(params:[String:Any]){
         WebService.shared.postMethod(Api: .smsVerification, parameter: params) { (response) -> (Void) in
             do{
                 let jsonData = try JSONDecoder().decode(smsVerifyApi.self, from: response)
                 self.userData = jsonData
                 if let token = self.userData?.data?.token{
                     UserDefaults.standard.set(token, forKey: "token")
                     tokenID = token
                     print("tokenID",token)
                 }
                 UserDefaults.standard.set(jsonData.data?.id, forKey: "UserID")
                 UserDefaults.standard.set("1", forKey: "Login")
 //                isLogin = "1"
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let rootVC = storyboard.instantiateViewController(withIdentifier: "CustomTabBarControllerID") as! CustomTabBarController
                 rootVC.modalPresentationStyle = .fullScreen
                 self.navigationController?.pushViewController(rootVC, animated: true)
             }catch let err{
                 print(err.localizedDescription)
             }
         }
     }
 */
