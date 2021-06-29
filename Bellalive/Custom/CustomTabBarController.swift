//
//  CustomTabBarController.swift
//  Bellalive
//
//  Created by APPLE on 20/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class CustomTabBarController:UITabBarController,UITabBarControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 0
        UserDefaults.standard.set(selectedIndex, forKey: "selectedTabIndex")
        TabBar()
        setupMiddleButton()
    }
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0 , width: 64, height: 64))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 30
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        view.layoutIfNeeded()
    }
    @objc private func menuButtonAction(sender: UIButton) {
            if UserDefaults.standard.string(forKey: "Login") == "1"{
                selectedIndex = 2
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "SignInScreenID") as! SignInScreen
                rootVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(rootVC, animated: true)
            }
           
       }
    func TabBar(){
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        let icon = #imageLiteral(resourceName: "Home")
        let selectedicon = #imageLiteral(resourceName: "Home(Colour)")
        myTabBarItem1.image = icon
        myTabBarItem1.selectedImage = selectedicon
        myTabBarItem1.title = ""
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        let icon1 = #imageLiteral(resourceName: "Follow")
        let selectedicon1 = #imageLiteral(resourceName: "Follow(Colour)")
        myTabBarItem2.image = icon1
        myTabBarItem2.selectedImage = selectedicon1
        myTabBarItem2.title = ""
        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        let icon2 = #imageLiteral(resourceName: "Broadcaster(Colour)")
        myTabBarItem3.image = icon2
        myTabBarItem3.selectedImage = icon2
        myTabBarItem3.title = "    "
        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        let icon3 = #imageLiteral(resourceName: "Message")
        let selectedicon3 = #imageLiteral(resourceName: "Message(Colour)")
        myTabBarItem4.image = icon3
        myTabBarItem4.selectedImage = selectedicon3
        myTabBarItem4.title = ""
        let myTabBarItem5 = (self.tabBar.items?[4])! as UITabBarItem
        let icon4 = #imageLiteral(resourceName: "Setting")
        let selectedicon4 = #imageLiteral(resourceName: "Setting(Colour)")
        myTabBarItem5.image = icon4
        myTabBarItem5.selectedImage = selectedicon4
        myTabBarItem5.title = ""
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("shouldselect----->\(selectedIndex)")
        UserDefaults.standard.set(selectedIndex, forKey: "lastindex")
        UserDefaults.standard.synchronize()
        return true
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Save the selected index to the UserDefaults
        UserDefaults.standard.set(self.selectedIndex, forKey: "selectedTabIndex")
        print("didselect----->\(selectedIndex)")
        UserDefaults.standard.synchronize()
        if selectedIndex == 4{
            if UserDefaults.standard.string(forKey: "Login") == "1"{
                
            }else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "SignInScreenID") as! SignInScreen
                rootVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(rootVC, animated: true)
            }
        }
    }
}
