//
//  ProfitScreen.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class ProfitScreen: UIViewController {
   
    @IBOutlet weak var LblAvailableAmount: UILabel!
    @IBOutlet weak var LblWithdrawingAmount: UILabel!
    @IBOutlet weak var LblAmount: UILabel!
    @IBOutlet weak var todayCountLbl: UILabel!
    @IBOutlet weak var monthCountLbl: UILabel!
    @IBOutlet weak var totalCountLbl: UILabel!
    
    var myProfitData : MyProfitModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apicallforMyProfit()
    }
    
    
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnWithdrawalRecords(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "WithdrawalRecordsScreenID") as! WithdrawalRecordsScreen
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    
    private func apicallforMyProfit(){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .vjCenterMyProfit,parameter: nil, token: token){[weak self] (response) -> (Void) in
            guard let weak = self else{return}
            do{
                let myProfit = try JSONDecoder().decode(MyProfitModel.self, from: response)
                weak.myProfitData = myProfit
                weak.LblAmount.text = "\(myProfit.data.bellaPoints)"
                weak.LblWithdrawingAmount.text = "\(myProfit.data.withdraw)"
                weak.LblAvailableAmount.text = "\(myProfit.data.available)"
                weak.todayCountLbl.text = "\(myProfit.data.today)"
                weak.monthCountLbl.text = "\(myProfit.data.month)"
                weak.totalCountLbl.text = "\(myProfit.data.total)"
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
}

import Foundation

// MARK: - MyProfitModel
struct MyProfitModel: Codable {
    let status: String
    let data: MyProfitDataClass
    let code: String
}

// MARK: - DataClass
struct MyProfitDataClass: Codable {
    let bellaPoints, withdraw, available, today: Int
    let week, month: Int
    let total: Int

    enum CodingKeys: String, CodingKey {
        case bellaPoints = "bella_points"
        case withdraw, available, today, week, month, total
    }
}
