//
//  BLContributionListVC.swift
//  Bellalive
//
//  Created by apple on 02/04/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class BLContributionListVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
        }
    }
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgViewHeight: NSLayoutConstraint!
    
    var nilView = EmptyBlockView()
    var streamContribution = [StreamContributionDatum]()
    var videoContribution = [StreamContributionDatum]()
    
    var streamId = String(), videoId = Int(), isFromVC = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromVC == "stream"{
            apiCallStreamContributorList(streamId: streamId)
        }else{
            apiCallVideoContributorList(videoId: videoId)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bgView.roundCorners(corners: [.topLeft,.topRight], radius: 10)
    }
    
    private func apiCallStreamContributorList(streamId : String){
        streamContribution.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .streamContributorList,pass:"?stream_id=\(streamId)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let stream = try JSONDecoder().decode(StreamContributionListModel.self, from: response)
                weakself.streamContribution = stream.data
                
                if weakself.streamContribution.count == 0{
                    weakself.bgViewHeight.constant = UIScreen.main.bounds.height/2
                    weakself.nilView.frame = CGRect(x: 0, y: 0, width: weakself.tblView.frame.size.width, height: weakself.tblView.frame.size.height)
                    weakself.nilView.msgLbl.text = "No data found"
                    weakself.tblView.backgroundView = weakself.nilView
                }else if weakself.streamContribution.count == 1{
                    weakself.bgViewHeight.constant = 70
                }else if weakself.streamContribution.count == 2{
                    weakself.bgViewHeight.constant = 140
                }else if weakself.streamContribution.count == 3{
                    weakself.bgViewHeight.constant = 210
                }else{
                    weakself.bgViewHeight.constant = UIScreen.main.bounds.height/2
                }
                
                weakself.tblView.reloadData()
            }catch let err{
                print(err.localizedDescription)
                weakself.bgViewHeight.constant = UIScreen.main.bounds.height/2
                weakself.nilView.frame = CGRect(x: 0, y: 0, width: weakself.tblView.frame.size.width, height: weakself.tblView.frame.size.height)
                weakself.nilView.msgLbl.text = "No data found"
                weakself.tblView.backgroundView = weakself.nilView
            }
        }
    }
    
    
    private func apiCallVideoContributorList(videoId : Int){
        videoContribution.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .videoContributorList,pass:"?video_id=\(videoId)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let stream = try JSONDecoder().decode(StreamContributionListModel.self, from: response)
                weakself.videoContribution = stream.data
                
                if weakself.videoContribution.count == 0{
                    weakself.bgViewHeight.constant = UIScreen.main.bounds.height/2
                    weakself.nilView.frame = CGRect(x: 0, y: 0, width: weakself.tblView.frame.size.width, height: weakself.tblView.frame.size.height)
                    weakself.nilView.msgLbl.text = "No data found"
                    weakself.tblView.backgroundView = weakself.nilView
                }else if weakself.videoContribution.count == 1{
                    weakself.bgViewHeight.constant = 70
                }else if weakself.videoContribution.count == 2{
                    weakself.bgViewHeight.constant = 140
                }else if weakself.videoContribution.count == 3{
                    weakself.bgViewHeight.constant = 210
                }else{
                    weakself.bgViewHeight.constant = UIScreen.main.bounds.height/2
                }
                
                weakself.tblView.reloadData()
            }catch let err{
                print(err.localizedDescription)
                weakself.bgViewHeight.constant = UIScreen.main.bounds.height/2
                weakself.nilView.frame = CGRect(x: 0, y: 0, width: weakself.tblView.frame.size.width, height: weakself.tblView.frame.size.height)
                weakself.nilView.msgLbl.text = "No data found"
                weakself.tblView.backgroundView = weakself.nilView
            }
        }
    }

    @IBAction func dismissAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
extension BLContributionListVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFromVC == "stream"{
           return streamContribution.count
        }else{
            return videoContribution.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFromVC == "stream"{
           let cell = Bundle.main.loadNibNamed("BLContributionListTVC", owner: self, options: nil)?.first as! BLContributionListTVC
           let stream = streamContribution[indexPath.row]
           cell.giftNameLbl.text = stream.gift.name
           cell.userNameLbl.text = stream.user.name.capitalized
           
           let userImage = stream.user.avatar
           let imgUrl = URL(string: userImage)
           cell.userImage.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
           
           let giftImage = stream.gift.icon
           let giftUrl = URL(string: giftImage)
           cell.giftImage.sd_setImage(with: giftUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
           return cell
        }else{
            let cell = Bundle.main.loadNibNamed("BLContributionListTVC", owner: self, options: nil)?.first as! BLContributionListTVC
            let video = videoContribution[indexPath.row]
            cell.giftNameLbl.text = video.gift.name
            cell.userNameLbl.text = video.user.name.capitalized
            
            let userImage = video.user.avatar
            let imgUrl = URL(string: userImage)
            cell.userImage.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
            
            let giftImage = video.gift.icon
            let giftUrl = URL(string: giftImage)
            cell.giftImage.sd_setImage(with: giftUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}


import Foundation

// MARK: - StreamContributionListModel
struct StreamContributionListModel: Codable {
    let data: [StreamContributionDatum]
    let links: StreamContributionLinks
    let meta: StreamContributionMeta
    let code: Int
    let status: String
}

// MARK: - Datum
struct StreamContributionDatum: Codable {
    let id, points, timeStamp: Int
    let date, time: String
    let user: StreamContributionUser
    let gift: StreamContributionGift

    enum CodingKeys: String, CodingKey {
        case id, points
        case timeStamp = "time_stamp"
        case date, time, user, gift
    }
}

// MARK: - Gift
struct StreamContributionGift: Codable {
    let id, giftCategoryID: Int
    let icon: String
    let animationGIF: String
    let name: String
    let points: Int
    let giftCategory: StreamContributionGiftCategory

    enum CodingKeys: String, CodingKey {
        case id
        case giftCategoryID = "gift_category_id"
        case icon
        case animationGIF = "animation_gif"
        case name, points
        case giftCategory = "gift_category"
    }
}

// MARK: - GiftCategory
struct StreamContributionGiftCategory: Codable {
    let id: Int
    let name: String
}

// MARK: - User
struct StreamContributionUser: Codable {
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
struct StreamContributionLinks: Codable {
    let first, last: String
}

// MARK: - Meta
struct StreamContributionMeta: Codable {
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
