//
//  WithdrawalRecordsScreen.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class WithdrawalRecordsScreen: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
        }
    }
    
    var withDrawelData = [WithdrawelDatum]()
    var nilView = EmptyBlockView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCallforUserProfile(status: 1)
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func apiCallforUserProfile(status : Int){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .withdrawalList, pass: "?status=\(status)", token: token) {[weak self] (response) -> (Void) in
            guard let weak = self else {return}
            do{
                let withDraw = try JSONDecoder().decode(WithdrawelListModel.self, from: response)
                weak.withDrawelData = withDraw.data
                
                if weak.withDrawelData.count == 0{
                    weak.nilView.frame = CGRect(x: 0, y: 0, width: weak.tblView.frame.size.width, height: weak.tblView.frame.size.height)
                    weak.nilView.imgView.image = #imageLiteral(resourceName: "Legions of Fans(vector) – 1")
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


extension WithdrawalRecordsScreen : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return withDrawelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BLWithdrawelListTVC") as! BLWithdrawelListTVC
        let withdraw = withDrawelData[indexPath.row]
        cell.dateLbl.text = withdraw.date
        cell.pointLbl.text = "\(withdraw.points)"
        cell.statusLbl.text = "Status : \(withdraw.status)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}


import Foundation

// MARK: - WithdrawelListModel
struct WithdrawelListModel: Codable {
    let data: [WithdrawelDatum]
    let links: WithdrawelLinks
    let meta: WithdrawelMeta
    let code: Int
    let status: String
}

// MARK: - Datum
struct WithdrawelDatum: Codable {
    let id: Int
    let date: String
    let timeStamp, points: Int
    let currencyCode, amount, status: String
    
    enum CodingKeys: String, CodingKey {
        case id, date
        case timeStamp = "time_stamp"
        case points
        case currencyCode = "currency_code"
        case amount, status
    }
}

// MARK: - Links
struct WithdrawelLinks: Codable {
    let first, last: String
}

// MARK: - Meta
struct WithdrawelMeta: Codable {
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
