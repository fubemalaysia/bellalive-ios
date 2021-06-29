//
//  BLTopView.swift
//  Bellalive
//
//  Created by apple on 17/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
import UIKit

class BLTopviewController: NSObject {
    class func topViewController() -> UIViewController {
        
        let tempInstance = BLTopviewController()
        return tempInstance.giveTopViewController((UIApplication.shared.keyWindow?.rootViewController)!)
    }
    
    func giveTopViewController(_ topVC:UIViewController) -> UIViewController {
        
        if topVC.isKind(of: UINavigationController.self){
            let navigationController = topVC as! UINavigationController
            return giveTopViewController(navigationController.viewControllers.last!)
        }
        var vc = topVC
        while let presentedViewController = vc.presentedViewController {
            vc = presentedViewController
        }
        return vc
    }
}
