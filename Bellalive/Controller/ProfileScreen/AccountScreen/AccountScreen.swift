//
//  AccountScreen.swift
//  Bellalive
//
//  Created by APPLE on 21/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import SwiftyJSON

class AccountScreen: UIViewController {
    
    var selectedCell = [String]()
    var viewWidth:CGFloat!
    var viewHeight:CGFloat!
    @IBOutlet weak var ClnViewAccount: UICollectionView!
    @IBOutlet weak var LblBellaBalance: UILabel!
    
    var gemsData = [GemsListData]()
    var purchaseBellacoinData : PurchaseBellacoinData?
    var onlinePaymentData : OnlinePaymentData?
    var tabIndex = 0
    var bellaPOints = String()
    let backgroundUpdate = NSNotification.Name(rawValue: "newRequest")
    override func viewDidLoad() {
        super.viewDidLoad()
        LblBellaBalance.text = "\(Appcontext.shared.user?.totalBellaPoints ?? 0)"
        apicallforGetGems()
        NotificationCenter.default.addObserver(self, selector: #selector(self.backendupdate(_:)), name: backgroundUpdate, object: nil)
    }
    
    @objc func backendupdate(_ notification: NSNotification) {
        LblBellaBalance.text = "\(Appcontext.shared.user?.totalBellaPoints ?? 0)"
    }
    
    @IBAction func BtnHelp(_ sender: UIButton) {
        print("help")
    }
    
    @IBAction func BtnDetails(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "BalanceDetailsScreenID") as! BalanceDetailsScreen
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func apicallforGetGems(){
        WebService.shared.getMethodUrl(Api: .gemsList,urlString: "?api_token=\(api_Token)", parameter: nil) {[weak self] (response) -> (Void) in
            guard let weak = self else {return}
            do{
                let json = try JSONDecoder().decode(GemsListModel.self, from: response)
                weak.gemsData = json.data
                
                weak.ClnViewAccount.reloadData()
//                let indexPath = IndexPath(row: weak.tabIndex, section: 0)
//                weak.ClnViewAccount.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)

            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apicallforPurchaseBellaCoin(gemsId : Int){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["gems_id" : gemsId] as [String : Any]
        
        WebService.shared.postMethodHeader(Api: .purchaseBellaCoin, parameter: param, token: token) {[weak self] (response) -> (Void) in
            guard let weakSelf = self else{return}
            do{
                let json = try JSON(data: response)
                print(json)
                let message = json["message"].stringValue
                Toast.makeToast(message: message , in: weakSelf.view){}
                let uuid = json["data"]["uuid"].stringValue
                weakSelf.apicallforOnlinePayment(uuid: uuid)
            }catch let err {
                print(err.localizedDescription)
            }
        }
        
//        WebService.shared.postMethodHeader(Api: .purchaseBellaCoin, parameter: param, token: token){[weak self] (response) -> (Void) in
//            guard let weak = self else{return}
//
//            do{
////                let json = try JSONDecoder().decode(PurchaseBellacoinModel.self, from: response)
////                if let data = json.data{
////                    weak.purchaseBellacoinData = data
////                }
//
//            }catch let err{
//                print(err.localizedDescription)
//            }
//        }
    }
    
    private func apicallforOnlinePayment(uuid : String){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["payment_uuid" : uuid] as [String : Any]
        
        WebService.shared.postMethodHeader(Api: .onlinePayment, parameter: param, token: token){[weak self] (response) -> (Void) in
            guard let weak = self else{return}

            do{
                let json = try JSONDecoder().decode(OnlinePaymentModel.self, from: response)
                if let data = json.data{
                    weak.onlinePaymentData = data
                }
                ProfileScreen().apicallforGetUserDetails()
                
            }catch let err{
                print(err.localizedDescription)
            }
        
        }
    }
}
extension AccountScreen: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gemsData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCell", for: indexPath) as! AccountClnViewCell
        let gems = gemsData[indexPath.item]
        
        cell.ViewAccountBalance.layer.cornerRadius = 10
        cell.layer.cornerRadius = 10
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView!.setBackground(colorTop:#colorLiteral(red: 0.5333333333, green: 0.2823529412, blue: 0.9725490196, alpha: 1), colorBottom:#colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1))
        cell.LblAmount.text = gems.name
        cell.LblMYRValue.text = "\(gems.price) USD"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tabIndex = indexPath.item
        let gemId = gemsData[indexPath.item].id
        apicallforPurchaseBellaCoin(gemsId: gemId)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewWidth = (collectionView.frame.width / 3) - 10
        viewHeight = viewWidth
        return CGSize(width: viewWidth, height: viewHeight)
    }
}

import Foundation

// MARK: - GemsListModel
struct GemsListModel: Codable {
    let status: String
    let data: [GemsListData]
}

// MARK: - Datum
struct GemsListData: Codable {
    let id: Int
    let name: String
    let point: Int
    let price: String
}
