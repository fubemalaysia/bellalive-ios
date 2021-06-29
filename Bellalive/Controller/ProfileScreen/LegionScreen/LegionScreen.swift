//
//  LegionScreen.swift
//  Bellalive
//
//  Created by APPLE on 21/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class LegionScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnHelp(_ sender: UIButton) {
    }
    
}
