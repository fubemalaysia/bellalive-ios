//
//  BalanceDetailsScreen.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

enum BalanceDetail : String{
    case income
    case expand
}

class BalanceDetailsScreen: UIViewController {
    
    @IBOutlet weak var LblExpandBorder: UILabel!
    @IBOutlet weak var LblExpand: UILabel!
    @IBOutlet weak var LblIncomeBorder: UILabel!
    @IBOutlet weak var LblIncome: UILabel!
    @IBOutlet weak var ViewExpandDetails: UIView!
    @IBOutlet weak var TblViewBalance: UITableView!{
        didSet{
            TblViewBalance.tableFooterView = UIView()
        }
    }
    
    var balance = BalanceDetail.income.rawValue
    var incomeListData = [IncomeListData]()
    var expandListData = [IncomeListData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let connect = isNetworkReachable()
        if connect == nil{
            apiCallforIncomeList()
        }
        selectedState(Income: true)
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnIncome(_ sender: UIButton) {
        balance = BalanceDetail.income.rawValue
        let connect = isNetworkReachable()
        if connect == nil{
            apiCallforIncomeList()
        }
        selectedState(Income: true)
    }
    @IBAction func BtnExpand(_ sender: UIButton) {
        balance = BalanceDetail.expand.rawValue
        let connect = isNetworkReachable()
        if connect == nil{
            apiCallforExpandList()
        }
        selectedState(Income: false)
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
        LblIncome.textColor = incColor
        LblIncomeBorder.isHidden = incHide
        LblExpand.textColor = expColor
        LblExpandBorder.isHidden = expHide
        TblViewBalance.isHidden = false
        ViewExpandDetails.isHidden = expHide
    }
    
    private func apiCallforIncomeList(){
        incomeListData.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .incomeList,parameter: nil, token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let userData = try JSONDecoder().decode(IncomeListModel.self, from: response)
                if let data = userData.data{
                    weakself.incomeListData = data
                }
                
                if weakself.incomeListData.count == 0{
                    weakself.TblViewBalance.setEmptyMessage("No Data Found")
                }else{
                    weakself.TblViewBalance.restore()
                }
                weakself.TblViewBalance.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallforExpandList(){
        expandListData.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .expandList,parameter: nil, token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let userData = try JSONDecoder().decode(IncomeListModel.self, from: response)
                if let data = userData.data{
                    weakself.expandListData = data
                }
                
                if weakself.expandListData.count == 0{
                    weakself.TblViewBalance.setEmptyMessage("No Data Found")
                }else{
                    weakself.TblViewBalance.restore()
                }
                weakself.TblViewBalance.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
}
extension BalanceDetailsScreen: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if balance == BalanceDetail.income.rawValue{
            return incomeListData.count
        }else{
            return expandListData.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if balance == BalanceDetail.income.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell", for: indexPath) as! BalanceTblViewCell
            let income = incomeListData[indexPath.row]
            cell.LblBalance.text = "+\(income.points ?? 0) "
            cell.LblTimeDuration.text = income.date
            cell.LblActivity.text = income.receiver?.name
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell", for: indexPath) as! BalanceTblViewCell
            let expand = expandListData[indexPath.row]
            cell.LblBalance.text = "+\(expand.points ?? 0) "
            cell.LblTimeDuration.text = expand.date
            cell.LblActivity.text = expand.receiver?.name
            return cell
        }
        
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderBalanceCell") as! HeaderBalanceTblViewCell
//        header.LblTitle.text = array[section].header
//        return header
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
