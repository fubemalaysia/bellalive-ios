//
//  GiftScreen.swift
//  Bellalive
//
//  Created by APPLE on 26/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

struct giftData{
    let image: UIImage
    let price: String
    init(image: UIImage,price: String) {
        self.image = image
        self.price = price
    }
}

protocol dismissGift : class{
    func dismissView(categoryGift: CategoryGiftList)
}

class GiftScreen: UIViewController {
    
    var titleSelected = [String]()
    var giftSelected = [String]()
    let TitleClnID = "GiftTitleCell"
    let GiftClnID = "GiftDetailsCell"
    var ViewWidth : CGFloat!
    var ViewHeight : CGFloat!
    
    var streamController : StreamingScreen?
    
    @IBOutlet weak var BtnSendOutlet: UIButton!
    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var LblAmountToBeRecharge: UILabel!
    @IBOutlet weak var GiftDetailsClnView: UICollectionView!
    @IBOutlet weak var GiftTitleClnView: UICollectionView!
    @IBOutlet weak var ViewGift: UIView!
    @IBOutlet weak var giftAddView: UIView!
    @IBOutlet weak var giftCountLbl: UILabel!
    
    var delegate : dismissGift?
    var categoryGiftData = [CategoryGiftData]()
    var categoryList = [CategoryGiftList]()
    var category : CategoryGiftList!
    var tabPosition = 0 , selectedIndex = 0, addGemCount = 1
    var streamId = String(), giftId = Int(), isFromVC = String()
    var videoId = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apicallforGift()
       

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        giftAddView.layer.cornerRadius = giftAddView.frame.height/2
        BtnSendOutlet.layer.cornerRadius = BtnSendOutlet.frame.height/2
    }
    @IBAction func BtnSend(_ sender: UIButton) {
        if Appcontext.shared.user?.totalBellaPoints ?? 0 >= category.points{
            if isFromVC == "stream"{
               apicallforSendStreamGift()
            }else{
               apicallforSendVideoGift()
            }
            
        }else{
            pointStatus()
        }
        
    }
    
    
    private func pointStatus(){
        let title = "Alert"
        let message = "Your bella points lower than gift point"
        
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.modalPresentationStyle = .popover
            let action1 = UIAlertAction(title: "OK", style: .destructive) { (action) in
                self.dismiss(animated: true)
            }
        
        action1.setValue(UIColor(hex: "531B93"), forKey: "titleTextColor")
        alertController.setTint(color: .black)
        alertController.setTitlet(font: UIFont(name: "SFUIDisplay-Medium", size: 15), color: .black)
        alertController.setMessage(font: UIFont(name: "SFUIDisplay-Regular", size: 12), color: .black)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func apicallforGift(){
        WebService.shared.getMethodUrl(Api: .giftCategoryList,urlString: "?api_token=\(api_Token)", parameter: nil) {[weak self] (response) -> (Void) in
            guard let weakself = self else{return}
            do{
                let json = try JSONDecoder().decode(CategoryGiftModel.self, from: response)
                weakself.categoryGiftData = json.data
                
                weakself.GiftTitleClnView.reloadData()
                weakself.GiftTitleClnView.selectItem(at: IndexPath(row: weakself.tabPosition, section: 0), animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
                weakself.categoryList = weakself.categoryGiftData[weakself.tabPosition].giftList.filter({(data) -> Bool in
                    return data.giftCategoryID == weakself.categoryGiftData[weakself.tabPosition].id
                })
                weakself.GiftDetailsClnView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    @IBAction func dimissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reduceAction(_ sender: Any) {
        if addGemCount == 1{
            createAlertBox(title: "Can't reduce minimum count of 1", message: "", buttonName: "OK")
        }else{
            if addGemCount > 1{ addGemCount -= 1}
            giftCountLbl.text = "\(addGemCount)"
        }
    }
    
    
    private func apicallforSendStreamGift(){
       guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["stream_id" : streamId,
                     "gift_id" : giftId] as [String : Any]
        WebService.shared.postMethodHeader(Api: .streamGiftSend, parameter: param, token: token){[weak self] (response) -> (Void) in
        guard let weakself = self else {return}
            do{
                let streamGift = try JSONDecoder().decode(StreamGiftSendModel.self, from: response)
                print(streamGift)
                weakself.delegate?.dismissView(categoryGift: weakself.category)
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apicallforSendVideoGift(){
       guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["video_id" : streamId,
                     "gift_id" : giftId] as [String : Any]
        WebService.shared.postMethodHeader(Api: .videoGiftSend, parameter: param, token: token){[weak self] (response) -> (Void) in
        guard let weakself = self else {return}
            do{
                let streamGift = try JSONDecoder().decode(StreamGiftSendModel.self, from: response)
                print(streamGift)
                weakself.delegate?.dismissView(categoryGift: weakself.category)
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        addGemCount += 1
        giftCountLbl.text = "\(addGemCount)"
    }
}
extension GiftScreen: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == GiftTitleClnView{
            return categoryGiftData.count
        }else{
            return categoryList.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == GiftTitleClnView{
            let cellTitle = collectionView.dequeueReusableCell(withReuseIdentifier: TitleClnID, for: indexPath) as! GiftTitleClnViewCell
            let category = categoryGiftData[indexPath.item]
            cellTitle.LblTitle.text = category.name
            
           // let color1 :UIColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
           // let color2 :UIColor = #colorLiteral(red: 0.5333333333, green: 0.2823529412, blue: 0.9725490196, alpha: 1)
            
            cellTitle.selectedBackgroundView = UIView(frame: cellTitle.LblTitle.bounds)
            cellTitle.selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.5333333333, green: 0.2823529412, blue: 0.9725490196, alpha: 1)
            //setGradientBackground(colorTop: color2, colorBottom: color1, cornerRadius: cellTitle.layer.cornerRadius)
            cellTitle.layer.cornerRadius = cellTitle.frame.height/2 - 10
            return cellTitle
        }else{
           let cellGift = collectionView.dequeueReusableCell(withReuseIdentifier: GiftClnID, for: indexPath) as! GiftDetailsClnViewCell
           // cellGift.ViewWidth.constant = ViewWidth
           // cellGift.ViewHeight.constant = ViewHeight
            let category = categoryList[indexPath.item]
            let imgUrl = URL(string: category.icon)
            cellGift.ImgGift.sd_setImage(with: imgUrl, placeholderImage: nil)
            cellGift.LblAmount.text = "\(category.points)"
            cellGift.contentView.layer.borderColor = UIColor.darkGray.cgColor
            cellGift.contentView.layer.borderWidth = 0.8
            cellGift.ViewInCell.layer.borderColor = UIColor.clear.cgColor
            cellGift.ViewInCell.layer.borderWidth = 0
            cellGift.ViewInCell.backgroundColor = .clear
            return cellGift
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == GiftTitleClnView{
            tabPosition = indexPath.row
            categoryList = categoryGiftData[indexPath.item].giftList.filter({(data) -> Bool in
                return data.giftCategoryID == categoryGiftData[indexPath.item].id
            })
            GiftDetailsClnView.reloadData()
        }else{
            if let cellGift = collectionView.cellForItem(at: indexPath) as? GiftDetailsClnViewCell {
                cellGift.contentView.layer.borderColor = UIColor.clear.cgColor
                cellGift.contentView.layer.borderWidth = 0
                cellGift.ViewInCell.layer.borderColor = #colorLiteral(red: 0.6980392157, green: 0.3568627451, blue: 1, alpha: 1)
                cellGift.ViewInCell.layer.borderWidth = 1
                cellGift.ViewInCell.backgroundColor = #colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9960784314, alpha: 0.2)
            }
            giftId = categoryList[indexPath.item].id
            selectedIndex = indexPath.item
            category = categoryList[indexPath.item]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView != GiftTitleClnView{
            if let cellGift = collectionView.cellForItem(at: indexPath) as? GiftDetailsClnViewCell {
                cellGift.contentView.layer.borderColor = UIColor.darkGray.cgColor
                cellGift.contentView.layer.borderWidth = 0.8
                cellGift.ViewInCell.layer.borderColor = UIColor.clear.cgColor
                cellGift.ViewInCell.layer.borderWidth = 0
                cellGift.ViewInCell.backgroundColor = .clear
                category = nil
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == GiftTitleClnView{
            let width = collectionView.frame.size.width / 4
            return CGSize(width: width, height: 50)
        }else{
            ViewWidth = collectionView.frame.width / 4 - 1
            ViewHeight = 95
            return CGSize(width: ViewWidth, height: ViewHeight)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

import Foundation

// MARK: - CategoryGiftModel
struct CategoryGiftModel: Codable {
    let status: String
    let data: [CategoryGiftData]
    let code: Int
}

// MARK: - Datum
struct CategoryGiftData: Codable {
    let id: Int
    let name: String
    let giftList: [CategoryGiftList]

    enum CodingKeys: String, CodingKey {
        case id, name
        case giftList = "gift_list"
    }
}

// MARK: - GiftList
struct CategoryGiftList: Codable {
    let id, giftCategoryID: Int
    let icon: String
    let animationGIF: String?
    let name: String
    let points: Int

    enum CodingKeys: String, CodingKey {
        case id
        case giftCategoryID = "gift_category_id"
        case icon
        case animationGIF = "animation_gif"
        case name, points
    }
}
