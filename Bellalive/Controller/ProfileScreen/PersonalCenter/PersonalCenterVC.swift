//
//  PersonalCenterVC.swift
//  Bellalive
//
//  Created by apple on 12/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class PersonalCenterVC: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    var image = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgUrl = URL(string: image)
        userImage.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userImage.layer.cornerRadius = userImage.frame.height/2
    }
    
    @IBAction func personalInfoAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @IBAction func realNameAuthAction(_ sender: UIButton) {
        
    }
    
    @IBAction func accountManageAction(_ sender: UIButton) {
        
    }
    
    @IBAction func blocklistAction(_ sender: UIButton) {
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
}
