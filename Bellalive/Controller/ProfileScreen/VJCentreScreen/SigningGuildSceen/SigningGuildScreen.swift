//
//  SelectGuildScreen.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class SigningGuildScreen: UIViewController {
    @IBOutlet weak var LblNoWithdrawal: UILabel!
    @IBOutlet weak var ImgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnSearch(_ sender: UIButton) {
    }
}
