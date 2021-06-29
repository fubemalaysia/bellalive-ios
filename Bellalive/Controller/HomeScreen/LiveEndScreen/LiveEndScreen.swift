//
//  LiveEndScreen.swift
//  Bellalive
//
//  Created by APPLE on 24/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class LiveEndScreen: UIViewController {
   // let scene = SceneDelegate()
    @IBOutlet weak var BtnBackHomeOutlet: UIButton!
    @IBOutlet weak var LblShareNumber: UILabel!
    @IBOutlet weak var LblNewFollowers: UILabel!
    @IBOutlet weak var LblMaximumAudience: UILabel!
    @IBOutlet weak var LblTotalAudience: UILabel!
    @IBOutlet weak var LblStartPoint: UILabel!
    @IBOutlet weak var LblLiveDuration: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let color1 = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        let color2 = #colorLiteral(red: 0.7215686275, green: 0.2274509804, blue: 0.9529411765, alpha: 1)
        BtnBackHomeOutlet.applyGradient(colors: [color2.cgColor,color1.cgColor])
        // Do any additional setup after loading the view.
    }
    @IBAction func BtnBackHome(_ sender: UIButton) {
        self.parent?.navigationController?.popToRootViewController(animated: false)
    }
    
}
