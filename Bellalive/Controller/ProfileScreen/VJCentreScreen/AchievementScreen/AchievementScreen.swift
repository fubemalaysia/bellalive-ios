//
//  AchievementScreen.swift
//  Bellalive
//
//  Created by APPLE on 25/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class AchievementScreen: UIViewController {
    var TitleVC = ""
    
    
    @IBOutlet weak var TblViewAchievement: UITableView!
    @IBOutlet weak var ViewAchievementRanking: UIView!
    @IBOutlet weak var LblAchievementsPoints: UILabel!
    @IBOutlet weak var LblProfileName: UILabel!
    @IBOutlet weak var ImgProfilePic: UIImageView!
    @IBOutlet weak var LblTitleOfVC: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ImgProfilePic.layer.cornerRadius = ImgProfilePic.frame.height/2
        ImgProfilePic.layer.borderColor = UIColor.white.cgColor
        ImgProfilePic.layer.borderWidth = 1
        ViewAchievementRanking.backgroundColor = nil
        ViewAchievementRanking.layer.cornerRadius = ViewAchievementRanking.frame.height/2
        ViewAchievementRanking.layer.borderColor = UIColor.white.cgColor
        ViewAchievementRanking.layer.borderWidth = 1
        TblViewAchievement.layer.borderColor = #colorLiteral(red: 0.5333333333, green: 0.2823529412, blue: 0.9725490196, alpha: 1)
        TblViewAchievement.layer.borderWidth = 3
        TblViewAchievement.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LblTitleOfVC.text = TitleVC
        TblViewAchievement.reloadData()
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnHelp(_ sender: UIButton) {
    }
    @IBAction func BtnAchievementRanking(_ sender: UIButton) {
    }
    
    
}
extension AchievementScreen: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AchievementCell", for: indexPath) as! AchievementTblViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
}
