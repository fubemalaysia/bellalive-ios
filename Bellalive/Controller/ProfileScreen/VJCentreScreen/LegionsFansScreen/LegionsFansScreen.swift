//
//  LegionsFansScreen.swift
//  Bellalive
//
//  Created by APPLE on 25/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class LegionsFansScreen: UIViewController {
    @IBOutlet weak var TblLegionsFans: UITableView!
    
    var legionFansList = [LegionOfFansDatum]()
    let nilView = EmptyBlockView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCallForLegionOfFans()
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnHelp(_ sender: UIButton) {
        print("help")
    }
    
    private func apiCallForLegionOfFans(){
        legionFansList.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .vjCenterLegionFan, parameter: nil, token: token) {[weak self] (response) -> (Void) in
            guard let weak = self else {return}
            do{
                let legion = try JSONDecoder().decode(LegionOfFansModel.self, from: response)
                weak.legionFansList = legion.data
                if weak.legionFansList.count == 0{
                    weak.nilView.frame = CGRect(x: 0, y: 0, width: weak.TblLegionsFans.frame.size.width, height: weak.TblLegionsFans.frame.size.height)
                    weak.nilView.msgLbl.text = "No data found"
                    weak.TblLegionsFans.backgroundView = weak.nilView
                }else{
                    weak.TblLegionsFans.restore()
                }
                
                weak.TblLegionsFans.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
}
extension LegionsFansScreen: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legionFansList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LegionsFansTblCell", for: indexPath) as! LegionsFansTblViewCell
        let legionFans = legionFansList[indexPath.row]
        cell.bellaliveIbLbl.text = "Bellalive ID : \(legionFans.bellaliveID)"
        cell.userNameLbl.text = legionFans.name
        let imgUrl = URL(string: legionFans.avatar)
        cell.userImage.sd_setImage(with: imgUrl, placeholderImage: nil)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


import Foundation

// MARK: - LegionOfFansModel
struct LegionOfFansModel: Codable {
    let data: [LegionOfFansDatum]
    let links: LegionOfFansLinks
    let meta: LegionOfFansMeta
    let code: Int
    let status: String
}

// MARK: - Datum
struct LegionOfFansDatum: Codable {
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
struct LegionOfFansLinks: Codable {
    let first, last: String
}

// MARK: - Meta
struct LegionOfFansMeta: Codable {
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
