//
//  SettingsScreen.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

struct settings{
    let header: String
    let detail: [DetailsSettings]
    init(header: String,detail: [DetailsSettings]) {
        self.header = header
        self.detail = detail
    }
}
class SettingsScreen: UIViewController {
    var settingsArr : [settings] = [settings(header: "System Setting", detail: [DetailsSettings(title: "Autoplay under no-WIFI Network", cache: nil),DetailsSettings(title: "Post Video & Live under no-Wifi Network", cache: nil)]),settings(header: "Message Settings", detail: [DetailsSettings(title: "Push Notification", cache: nil)]),settings(header: "Other", detail: [DetailsSettings(title: "About", cache: nil),DetailsSettings(title: "Contact Bellalive", cache: nil),DetailsSettings(title: "Help & Feedback", cache: nil),DetailsSettings(title: "Clear Cache", cache: "9.48MB"),DetailsSettings(title: "Log Out", cache: nil)])]
    @IBOutlet weak var TblViewSettings: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func apicallforLogut(){
                guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .logout,parameter: nil, token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let logout = try JSONDecoder().decode(LogoutModel.self, from: response)
                Toast.makeToast(message: logout.data.message, in: weakself.view){}
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "SignInScreenID") as! SignInScreen
                rootVC.modalPresentationStyle = .fullScreen
                weakself.navigationController?.pushViewController(rootVC, animated: true)
                let userDef = UserDefaults.standard
                userDef.removeObject(forKey: "token")
                userDef.removeObject(forKey: "UserID")
                userDef.set("0",forKey: "Login")
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    private func blockSetup(){
        let title = "Logout"
        let message = "Are you sure want to logut?"
        
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.modalPresentationStyle = .popover
            let action1 = UIAlertAction(title: "Logout", style: .destructive) { (action) in
                print("Default is pressed.....")
                self.apicallforLogut()
            }
            let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                print("Cancel is pressed......")
            }
        
        action1.setValue(UIColor(hex: "531B93"), forKey: "titleTextColor")
        action2.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.setTint(color: .black)
        alertController.setTitlet(font: UIFont(name: "SFUIDisplay-Medium", size: 15), color: .black)
        alertController.setMessage(font: UIFont(name: "SFUIDisplay-Regular", size: 12), color: .black)
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)

    }
}
extension SettingsScreen: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArr[section].detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let sysCell = tableView.dequeueReusableCell(withIdentifier: "SystemCell", for: indexPath) as! SystemTblViewCell
            sysCell.selectionStyle = .none
            sysCell.LblTitle.text = settingsArr[indexPath.section].detail[indexPath.row].Title
            sysCell.SwitchOutlet.setOn(false, animated: false)
            return sysCell
        }else{
            let settingsCell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsTblViewCell
            settingsCell.selectionStyle = .none
            settingsCell.LblTitleSettings.text = settingsArr[indexPath.section].detail[indexPath.row].Title
            settingsCell.LblCacheMemory.text = settingsArr[indexPath.section].detail[indexPath.row].Cache
            return settingsCell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderTblViewCell
        headerCell.LblTitleHeader.text = settingsArr[section].header
        return headerCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
        }else{
            if settingsArr[indexPath.section].header == "Message Settings"{
                
            }else{
                switch settingsArr[indexPath.section].detail[indexPath.row].Title{
                case "Log Out":
                   blockSetup()
                default:
                    break
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

import Foundation

// MARK: - LogoutModel
struct LogoutModel: Codable {
    let status: String
    let data: DataClass
    let code: Int
}

// MARK: - DataClass
struct DataClass: Codable {
    let message: String
}
