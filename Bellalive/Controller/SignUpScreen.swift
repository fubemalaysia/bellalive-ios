//
//  SignUpScreen.swift
//  Bellalive
//
//  Created by APPLE on 05/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpScreen: UIViewController,UITextFieldDelegate, dismissCountry {

    @IBOutlet weak var ImgBackGround: UIImageView!
    @IBOutlet weak var ViewTopDetails: UIView!
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var ViewFirstName: UIView!
    @IBOutlet weak var TxtFieldFirstName: UITextField!
    @IBOutlet weak var ViewLastName: UIView!
    @IBOutlet weak var TxtFieldLastName: UITextField!
    @IBOutlet weak var ViewPhone: UIView!
    @IBOutlet weak var LblCountryCode: UILabel!
    @IBOutlet weak var IMgArrow: UIImageView!
    @IBOutlet weak var TxtFieldPhoneNo: UITextField!
    @IBOutlet weak var ViewPassword: UIView!
    @IBOutlet weak var TxtFieldPassword: UITextField!
    @IBOutlet weak var BtnSignUpOutlet: UIButton!
    @IBOutlet weak var BtnBackOutlet: UIButton!
    @IBOutlet weak var passwordViewHeight: NSLayoutConstraint!
    var countrySelected : Int?
    var registerData : signUpApi?
    var smsSendData : SmsSendModel?
    var stdcode = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewPassword.isHidden = true
        passwordViewHeight.constant = 0
        TxtFieldPhoneNo.delegate = self
        TxtFieldPassword.delegate = self
        TxtFieldLastName.delegate = self
        TxtFieldFirstName.delegate = self
        ViewTopDetails.layer.cornerRadius = 15
        ViewPhone.layer.cornerRadius = ViewPhone.frame.height / 2
        ViewPassword.layer.cornerRadius = ViewPassword.frame.height / 2
        ViewLastName.layer.cornerRadius = ViewLastName.frame.height / 2
        ViewFirstName.layer.cornerRadius = ViewFirstName.frame.height / 2
        BtnSignUpOutlet.layer.cornerRadius = BtnSignUpOutlet.frame.height / 2
        let color1 :UIColor = #colorLiteral(red: 0.6431372549, green: 0.2196078431, blue: 0.6274509804, alpha: 1)
        let color2 :UIColor = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        BtnSignUpOutlet.applyGradient(colors: [color1.cgColor,color2.cgColor])
        let url = Bundle.main.url(forResource: "vid", withExtension: "gif")!
        ImgBackGround.image = UIImage.gifImageWithURL(url.absoluteString)
        // Do any additional setup after loading the view.
    }
    @IBAction func BtnCountryCode(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "CountryScreenID") as! CountryScreen
        rootVC.modalPresentationStyle = .overCurrentContext
        rootVC.delegateDismiss = self
        self.navigationController?.present(rootVC, animated: true)
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnSignUp(_ sender: UIButton) {
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
    func registerApi(params: [String: Any]){
        WebService.shared.postMethod(Api: .register, parameter: params) { (response) -> (Void) in
            do{
                let json = try JSONDecoder().decode(signUpApi.self, from: response)
                self.registerData = json
                //Toast.makeToast(message: self.registerData?.status ?? "", in: self.view){}
                if (self.registerData?.status?.lowercased().contains("success"))!{
                    self.navigationController?.popViewController(animated: true)
                }

                if let errorMsg = self.registerData?.error{
                    if let msg = errorMsg.phone_no{
                        Toast.makeToast(message: msg.first ?? "", in: self.view) { () -> (Void) in
                        }
                    }
                }
            }catch let err{
                print(err.localizedDescription)
            }
        }
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
                            weakself.BtnSignUpOutlet.setTitle("VERIFY", for: .normal)
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
                             let status = value["status"].stringValue
                            
                             if status.lowercased() == "success"{
                                let params = ["phone_no": weakself.TxtFieldPhoneNo.text!,
                                              "first_name": weakself.TxtFieldFirstName.text!,
                                              "last_name": weakself.TxtFieldLastName.text!,
                                              "country_id": weakself.countrySelected ?? 0 ] as [String : Any]
                                weakself.registerApi(params: params)
                             }else{
                                weakself.createAlertBox(title: App.Name, message: "Your OTP is expired please resend the OTP to your mobile number", buttonName: "OK")
                                weakself.BtnSignUpOutlet.setTitle("SEND", for: .normal)
                                weakself.ViewPassword.isHidden = true
                                weakself.passwordViewHeight.constant = 0
                                weakself.TxtFieldPassword.text = ""
                             }
                            
                            
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
    
    private func withoutcodeValidation() -> String{
        if TxtFieldFirstName.text == ""{
            return "Enter the firstname"
        }else if TxtFieldLastName.text == ""{
            return "Enter the lastname"
        }else if TxtFieldPhoneNo.text == ""{
            return "Enter the phone number"
        }else if LblCountryCode.text == "+00"{
            return "Select the country"
        }
        return "";
    }
    
    private func withcodeValidation() -> String{
        if TxtFieldFirstName.text == ""{
            return "Enter the firstname"
        }else if TxtFieldLastName.text == ""{
            return "Enter the lastname"
        }else if TxtFieldPhoneNo.text == ""{
            return "Enter the phone number"
        }else if LblCountryCode.text == "+00"{
            return "Select the country"
        }else if TxtFieldPassword.text == ""{
            return "Enter the verification code"
        }
        return "";
    }
    
}
