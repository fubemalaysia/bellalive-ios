//
//  MessageScreen.swift
//  Bellalive
//
//  Created by APPLE on 21/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class MessageScreen: UIViewController {
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
        }
    }
    
    var messageUserList = [MessageUserDatum]()
    var nilView = EmptyBlockView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiCallBlockedList()
    }
    
    private func apiCallBlockedList(){
        messageUserList.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .messageUserList,parameter: nil, token: token){[weak self] (response) -> (Void) in
            guard let weak = self else{return}
            do{
                let message = try JSONDecoder().decode(MessageUserModel.self, from: response)
                weak.messageUserList = message.data
                
                if weak.messageUserList.count == 0{
                    weak.nilView.frame = CGRect(x: 0, y: 0, width: weak.tblView.frame.size.width, height: weak.tblView.frame.size.height)
                    weak.nilView.msgLbl.text = "No data found"
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
    
}
extension MessageScreen : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BLMessageUserTVC") as! BLMessageUserTVC
        let message = messageUserList[indexPath.row]
        let imgUrl = URL(string: message.avatar)
        cell.userImg.sd_setImage(with: imgUrl, placeholderImage: nil)
        cell.userNameLbl.text = message.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}


import Foundation

// MARK: - MessageUserModel
struct MessageUserModel: Codable {
    let data: [MessageUserDatum]
    let links: MessageUserLinks
    let meta: MessageUserMeta
    let code: Int
    let status: String
}

// MARK: - Datum
struct MessageUserDatum: Codable {
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
struct MessageUserLinks: Codable {
    let first, last: String
}

// MARK: - Meta
struct MessageUserMeta: Codable {
    let currentPage, lastPage: Int
    let path: String
    let perPage, total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
        case path
        case perPage = "per_page"
        case total
    }
}

