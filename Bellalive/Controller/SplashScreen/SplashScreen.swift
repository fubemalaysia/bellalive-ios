//
//  SplashScreen.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class SplashScreen: UIViewController {

    @IBOutlet weak var BtnWelcomeOutlet: UIButton!
    var timer : Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(withTimeInterval: 1.4, repeats: false) { (_) in
            if UserDefaults.standard.string(forKey: "Login") == "1"{
                self.apicallforGetUserDetails()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "CustomTabBarControllerID") as! CustomTabBarController
                rootVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(rootVC, animated: true)
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "SignInScreenID") as! SignInScreen
                rootVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(rootVC, animated: true)
            }
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func BtnWelcome(_ sender: UIButton) {
        timer.invalidate()
//        UserDefaults.standard.set("1", forKey: "Welcome")
        if UserDefaults.standard.string(forKey: "Login") == "1"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "CustomTabBarControllerID") as! CustomTabBarController
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "SignInScreenID") as! SignInScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        }
    }
    
    private func apicallforGetUserDetails(){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .profile,parameter: nil, token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let userData = try JSONDecoder().decode(UserProfileModel.self, from: response)
                if let data = userData.data{
                    Appcontext.shared.user = data
                }
                UserDefaults.standard.set(userData.data?.id, forKey: "UserID")
                
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
}
