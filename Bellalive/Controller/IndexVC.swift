//
//  IndexVC.swift
//  Bellalive
//
//  Created by APPLE on 30/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class IndexVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        if UserDefaults.standard.string(forKey: "Welcome") == "1"{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let rootVC = storyboard.instantiateViewController(identifier: "CustomTabBarControllerID") as! CustomTabBarController
//            rootVC.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(rootVC, animated: true)
//        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "SplashScreenID") as! SplashScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
//        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
