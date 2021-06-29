//
//  WebService.swift
//  Bellalive
//
//  Created by APPLE on 04/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
//import Crashlytics

class WebService: UIViewController{
    static let shared = WebService()
    func postMethod(Api: Base,parameter: [String:Any],OnCompletion : @escaping(Data) -> (Void)){
        
        let headerVal : HTTPHeaders  = [
                "Content-Type":"application/json",
                "accept":"application/json",
                "X-Requested-With":"XMLHttpRequest"
            ]
        
        guard let url = URL(string: "\(baseURL + Api.rawValue)") else{return}
        Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headerVal).responseJSON { (data) in
            switch data.result{
            case .success(_):
                guard let response = data.data else{return}
                guard let json = try? JSON(data: response) else{return}
                if Api == .login{
//                guard let jsonData = try? JSONDecoder().decode(loginApi.self, from: response)  else{return}
//                self.login = jsonData
                }
                print("\(url)",json)
                OnCompletion(response)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        setCrashLog(base: Api)
    }
    func getMethod(Api: Base,parameter: [String:Any],OnCompletion : @escaping(Data) -> (Void)){
        
        let headerVal : HTTPHeaders = [
                "Content-Type":"application/json",
                "accept":"application/json",
                "X-Requested-With":"XMLHttpRequest"
            ]
        
        guard let url = URL(string: "\(baseURL + Api.rawValue)") else{return}
        Alamofire.request(url, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: headerVal).responseJSON { (data) in
            switch data.result{
            case .success(_):
                guard let response = data.data else{return}
                guard let json = try? JSON(data: response) else{return}
                print("\(url)",json)
                OnCompletion(response)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        setCrashLog(base: Api)
    }
    func postMethodUrl(Api: Base,urlString:String,parameter: [String:Any]?,OnCompletion : @escaping(Data) -> (Void)){
            
            let headerVal : HTTPHeaders  = [
                    "Content-Type":"application/json",
                    "accept":"application/json",
                    "X-Requested-With":"XMLHttpRequest"
                ]
            
            guard let url = URL(string: "\(baseURL + Api.rawValue + urlString)") else{return}
            Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headerVal).responseJSON { (data) in
                switch data.result{
                case .success(_):
                    guard let response = data.data else{return}
                    guard let json = try? JSON(data: response) else{return}
                    if Api == .login{
    //                guard let jsonData = try? JSONDecoder().decode(loginApi.self, from: response)  else{return}
    //                self.login = jsonData
                    }
                    print("\(url)",json)
                    OnCompletion(response)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    //        setCrashLog(base: Api)
        }
        func getMethodUrl(Api: Base,urlString:String,parameter: [String:Any]?,OnCompletion : @escaping(Data) -> (Void)){
            
            let headerVal : HTTPHeaders = [
                    "Content-Type":"application/json",
                    "accept":"application/json",
                    "X-Requested-With":"XMLHttpRequest"
                ]
            
            guard let url = URL(string: "\(baseURL + Api.rawValue + urlString)") else{return}
            Alamofire.request(url, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: headerVal).responseJSON { (data) in
                switch data.result{
                case .success(_):
                    guard let response = data.data else{return}
                    guard let json = try? JSON(data: response) else{return}
                    print("\(url)",json)
                    OnCompletion(response)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    //        setCrashLog(base: Api)
        }
    func postMethodHeader(Api: Base,parameter: [String:Any]?,token:String,OnCompletion : @escaping(Data) -> (Void)){
        
        let headerVal : HTTPHeaders  = [
                "Authorization" : "Bearer"+" "+(token),
                "Content-Type":"application/json",
                "accept":"application/json",
                "X-Requested-With":"XMLHttpRequest"
            ]
        print(headerVal)
        guard let url = URL(string: "\(baseURL + Api.rawValue)") else{return}
        print(url)
        Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headerVal).responseJSON { (data) in
            switch data.result{
            case .success(_):
                print("success")
                guard let response = data.data else{return}
                guard let json = try? JSON(data: response) else{return}
                print("\(url)",json)
                OnCompletion(response)
                break
            case .failure(let error):
                print("failure")
                print(error.localizedDescription)
            }
        }
//        setCrashLog(base: Api)
    }
    func postMethodHeaderUrl(Api: Base,pass:String,parameter: [String:Any]?,token:String,OnCompletion : @escaping(Data) -> (Void)){
        
        let headerVal : HTTPHeaders  = [
                "Authorization" : "Bearer"+" "+(token),
                "Content-Type":"application/json",
                "accept":"application/json",
                "X-Requested-With":"XMLHttpRequest"
            ]
        
        guard let url = URL(string: "\(baseURL + Api.rawValue + pass)") else{return}
        Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: headerVal).responseJSON { (data) in
            switch data.result{
            case .success(_):
                guard let response = data.data else{return}
                guard let json = try? JSON(data: response) else{return}
                print("\(url)",json)
                OnCompletion(response)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        setCrashLog(base: Api)
    }
    func getMethodHeader(Api: Base,parameter: [String:Any]?,token:String,OnCompletion : @escaping(Data) -> (Void)){
        
        let headerVal : HTTPHeaders = [
                "Authorization" : "Bearer"+" "+(token),
                "Content-Type":"application/json",
                "accept":"application/json",
                "X-Requested-With":"XMLHttpRequest"
            ]
        
        guard let url = URL(string: "\(baseURL + Api.rawValue)") else{return}
        Alamofire.request(url, method: .get, parameters:parameter, encoding: JSONEncoding.default, headers: headerVal).responseJSON { (data) in
            switch data.result{
            case .success(_):
                guard let response = data.data else{return}
                guard let json = try? JSON(data: response) else{return}
                print("\(url)",json)
                OnCompletion(response)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        setCrashLog(base: Api)
    }
    func getMethodHeaderUrl(Api: Base,pass: String,token:String,OnCompletion : @escaping(Data) -> (Void)){
        
        let headerVal : HTTPHeaders = [
                "Authorization" : "Bearer"+" "+(token),
                "Content-Type":"application/json",
                "accept":"application/json",
                "X-Requested-With":"XMLHttpRequest"
            ]
        
        guard let url = URL(string: "\(baseURL + Api.rawValue + pass)") else{return}
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headerVal).responseJSON { (data) in
        
            switch data.result{
            case .success(_):
                guard let response = data.data else{return}
                guard let json = try? JSON(data: response) else{return}
                print("\(url)",json)
                OnCompletion(response)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        setCrashLog(base: Api)
    }
    func deleteMethodHeaderUrl(Api: Base,pass: String,token:String,OnCompletion : @escaping(Data) -> (Void)){
        
        let headerVal : HTTPHeaders = [
                "Authorization" : "Bearer"+" "+(token),
                "Content-Type":"application/json",
                "accept":"application/json",
                "X-Requested-With":"XMLHttpRequest"
            ]
        
        guard let url = URL(string: "\(baseURL + Api.rawValue + pass)") else{return}
        Alamofire.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: headerVal).responseJSON { (data) in
        
            switch data.result{
            case .success(_):
                guard let response = data.data else{return}
                guard let json = try? JSON(data: response) else{return}
                print("\(url)",json)
                OnCompletion(response)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        setCrashLog(base: Api)
    }
    func postMethodHeaderMultiForm(Api: Base,dataUpload:URL,audioURL:URL?,musicSel: Bool,audioName:String?,videoName:String,parameter: [String:Any],token:String,vc:UIViewController,OnCompletion : @escaping(Data?,_ progress:Double) -> (Void)){
        guard let url = URL(string: "\(baseURL + Api.rawValue)") else { return }
        let HeaderValue = [
            "Authorization" : "Bearer"+" "+(token),
            "Content-Type":"multipart/form-data",
            "X-Requested-With":"XMLHttpRequest"
        ]
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            do{
                let videoData = try Data(contentsOf: dataUpload)
                MultipartFormData.append(videoData, withName: "video", fileName: videoName, mimeType: "video/mp4")
                if musicSel == true{
                    let audioData = try Data(contentsOf: audioURL!)
                    MultipartFormData.append(audioData, withName: "audio", fileName: audioName!, mimeType: "audio/m4a")
                }
            }catch{
                print("error",error.localizedDescription)
            }
            for (key, value) in parameter {
                MultipartFormData.append( (value as AnyObject).data(using: String.Encoding.utf8.rawValue)! , withName: key)
            }
        }, usingThreshold: .init(), to: url, method: .post, headers: HeaderValue) { (result) in
            switch result{
            case .success(request: let upload,_,_):
                upload.uploadProgress { progress in // main queue by default
                    OnCompletion(nil,progress.fractionCompleted)
                    print("Upload Progress: \(upload.progress.fractionCompleted)")
                }
                upload.responseJSON { (response) in
                    guard let datares = response.data else{return}
                    guard let json = try? JSON(data: datares) else{return}
                    print("\(url)",json)
//                    Toast.makeToast(message: json["message"].string ?? "", in: (vc.navigationController?.view)!)
                    OnCompletion(datares,upload.progress.fractionCompleted)
                }
                
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
//        setCrashLog(base: Api)
    }
    func PostImageHeader(Api:Base,parameter: [String:Any],keyName : String,profile_pic:UIImage?,token:String,OnCompletion:@escaping (Data) -> (Void)){
        guard let url = URL(string: "\(baseURL + Api.rawValue)") else { return }
        let HeaderValue = [
            "Authorization" : "Bearer"+" "+(token),
            "Content-Type":"multipart/form-data",
            "X-Requested-With":"XMLHttpRequest"
        ]
        Alamofire.upload(multipartFormData: { (MultipartFormData) in
            if let pic = profile_pic{
                guard let data = pic.jpegData(compressionQuality: 1.0) else{return}
                MultipartFormData.append(data, withName: keyName, fileName: "picture", mimeType: "image/jpeg")
            }
            for (key, value) in parameter {
                MultipartFormData.append( (value as AnyObject).data(using: String.Encoding.utf8.rawValue)! , withName: key)
            }
        }, usingThreshold: .init(), to: url, method: .post, headers: HeaderValue) { (result) in
            switch result{
            case .success(request: let upload,_,_):
                upload.responseJSON { (response) in
                    guard let datares = response.data else{return}
                    let jjson = try? JSON(data: datares)
                    print(jjson as Any)
                    OnCompletion(datares)
                }
                
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func downloadVideo(url:String,OnCompletion : @escaping(Data?,_ progress:Double?) -> (Void)){

        Alamofire.request(url).downloadProgress(closure : { (progress) in
        print(progress.fractionCompleted)
        OnCompletion(nil,progress.fractionCompleted)
        }).responseData{ (response) in
//           print(response)
//           print(response.result.value!)
//           print(response.result.description)
            switch response.result{
            case .success(_):
                if let data = response.result.value {
                    OnCompletion(data,nil)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
//    var login : loginApi?
//    private func setCrashLog(base : Base){
        
//        if let fName = login?.first_name, let lName = login?.last_name {
//            Crashlytics.sharedInstance().setUserName(fName+" "+lName)
//        }
//        if let email = login?.email {
//            Crashlytics.sharedInstance().setUserEmail(email)
//        }
//        if let idVal = login?.id {
//            Crashlytics.sharedInstance().setUserIdentifier("\(idVal)")
//        }
//        Crashlytics.sharedInstance().setObjectValue(base.rawValue, forKey: "Last Api Called")
//    }
}

