//
//  BlockedMessageScreen.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class BlockedManageScreen: UIViewController {
    @IBOutlet weak var LblBlockedEnterBorder: UILabel!
    @IBOutlet weak var LblBlockedEnter: UILabel!
    @IBOutlet weak var LblBlockedSpeakBorder: UILabel!
    @IBOutlet weak var LblBlockedSpeak: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var blockList = [BlockedListDatum]()
    let nilView = EmptyBlockView()
    var selectTitle = "blockEnter"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectTitle == "blockEnter"{
            apiCallBlockedList()
        }
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnBlockedSpeak(_ sender: UIButton) {
        selectTitle = "blockSpeak"
        selectedState(Income: true)
        blockList.removeAll()
        nilView.frame = CGRect(x: 0, y: 0, width: tblView.frame.size.width, height: tblView.frame.size.height)
        tblView.backgroundView = nilView
        tblView.reloadData()
    }
    @IBAction func BtnBlockedEnter(_ sender: UIButton) {
        selectTitle = "blockEnter"
        selectedState(Income: false)
        apiCallBlockedList()
    }
    func selectedState(Income: Bool){
        var incColor: UIColor!
        var incHide: Bool!
        var expColor: UIColor!
        var expHide: Bool!
        if Income{
            incColor = .white
            incHide = false
            expColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
            expHide = true
        }else{
            expColor = .white
            expHide = false
            incColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
            incHide = true
        }
        LblBlockedSpeak.textColor = incColor
        LblBlockedSpeakBorder.isHidden = incHide
        LblBlockedEnter.textColor = expColor
        LblBlockedEnterBorder.isHidden = expHide
    }
    
    
    private func apiCallBlockedList(){
        blockList.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .blockedList,parameter: nil, token: token){[weak self] (response) -> (Void) in
            guard let weak = self else{return}
            do{
                let block = try JSONDecoder().decode(BlockedListModel.self, from: response)
                weak.blockList = block.data
                
                if weak.blockList.count == 0{
                    weak.nilView.frame = CGRect(x: 0, y: 0, width: weak.tblView.frame.size.width, height: weak.tblView.frame.size.height)
                    weak.tblView.backgroundView = weak.nilView
                }else{
                    weak.tblView.restore()
                }
                weak.tblView.reloadData()
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallUnblock(userId : Int){
       guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["user_id" : userId] as [String : Any]
        WebService.shared.postMethodHeader(Api: .blockedUpdate, parameter: param, token: token){[weak self] (response) -> (Void) in
            guard let weak = self else{return}
            do{
                let block = try JSONDecoder().decode(UserBlockModel.self, from: response)
                print(block.success)
                weak.apiCallBlockedList()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    @objc func blockAction(sender : UIButton){
        print(sender.tag)
        blockSetup(index: sender.tag)
    }
    
    private func blockSetup(index : Int){
        let title = "Unblock \(blockList[index].name)?"
        let message = "\(blockList[index].name) will now be able to see your posts and follow you on Bellalive. You may start receiving messages and video chats from them. They won't be notified that you've unblocked them."
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.modalPresentationStyle = .popover
            let action1 = UIAlertAction(title: "Unblock", style: .destructive) { (action) in
                print("Default is pressed.....")
                self.apiCallUnblock(userId: self.blockList[index].id)
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
extension BlockedManageScreen : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectTitle == "blockEnter"{
            return blockList.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectTitle == "blockEnter"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BLBlockListTVC") as! BLBlockListTVC
            let block = blockList[indexPath.row]
            let imgUrl = URL(string: block.avatar)
            cell.imgView.sd_setImage(with: imgUrl, placeholderImage: nil)
            cell.userNameLbl.text = block.name
            cell.blockBtn.tag = indexPath.row
            cell.blockBtn.addTarget(self, action: #selector(blockAction), for: .touchUpInside)
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}


import Foundation

// MARK: - BlockedListModel
struct BlockedListModel: Codable {
    let data: [BlockedListDatum]
    let links: BlockedListLinks
    let meta: BlockedListMeta
    let code: Int
    let status: String
}

// MARK: - Datum
struct BlockedListDatum: Codable {
    let id: Int
    let bellaliveID, name: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case bellaliveID = "bellalive_id"
        case name, avatar
    }
}

// MARK: - Links
struct BlockedListLinks: Codable {
    let first, last: String
}

// MARK: - Meta
struct BlockedListMeta: Codable {
    let currentPage, from, lastPage: Int
    let path: String
    let perPage, to, total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case path
        case perPage = "per_page"
        case to, total
    }
}
