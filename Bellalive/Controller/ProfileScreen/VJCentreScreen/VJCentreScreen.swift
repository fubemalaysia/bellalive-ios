//
//  VJCentreScreen.swift
//  Bellalive
//
//  Created by APPLE on 21/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class VJCentreScreen: UIViewController {
    let vjCentreArr : [Options] = [Options(image: #imageLiteral(resourceName: "My Profit(VJ Centre) – 1"), title: "My Profit", level: nil),Options(image: #imageLiteral(resourceName: "Signing Guild(VJ Centre)"), title: "Signing Guild",level: nil),Options(image: #imageLiteral(resourceName: "Live Record(VJ Centre)"), title: "Live Record",level: nil),Options(image: #imageLiteral(resourceName: "My Profit(VJ Centre) – 2"), title: "Contribution",level: nil),Options(image: #imageLiteral(resourceName: "Legions of Fans(VJ Centre)"), title: "Legion of Fans",level: nil),Options(image: #imageLiteral(resourceName: "My Achievement(VJ Centre)"), title: "My Achievements",level: nil),Options(image: #imageLiteral(resourceName: "Blocked ManageVJ Centre)"), title: "Blocked Manage",level: nil)]
    @IBOutlet weak var TblViewVJCentre: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension VJCentreScreen: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vjCentreArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VJCentreCell", for: indexPath) as! VJCentreTblViewCell
        cell.ImgViewOptions.image = vjCentreArr[indexPath.row].Image
        cell.LblOptions.text = vjCentreArr[indexPath.row].Title
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfitScreenID") as! ProfitScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "SigningGuildScreenID") as! SigningGuildScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "LiveRecordScreenID") as! LiveRecordScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 3:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "ContributionScreenID") as! ContributionScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 4:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "LegionsFansScreenID") as! LegionsFansScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 5:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "AchievementScreenID") as! AchievementScreen
            rootVC.TitleVC = "VJ Achievements"
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 6:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "BlockedManageScreenID") as! BlockedManageScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
