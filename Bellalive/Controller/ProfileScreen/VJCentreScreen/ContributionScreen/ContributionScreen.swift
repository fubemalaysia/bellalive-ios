//
//  ContributionScreen.swift
//  Bellalive
//
//  Created by APPLE on 23/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class ContributionScreen: UIViewController {

    
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
        }
    }
    @IBOutlet weak var CustomSegmentOutlet: CustomSegmentControl!
    
    var contributionList = [VJContributionDatum]()
    var nilView = EmptyBlockView()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        apiCallVJContribution(days: 1)
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func CustomSegmentAction(_ sender: CustomSegmentControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            apiCallVJContribution(days: 1)
        case 1:
            apiCallVJContribution(days: 7)
        case 2:
            apiCallVJContribution(days: 30)
        case 3:
            apiCallVJContribution(days: 0)
        default:
            break
        }
    }
    
    private func apiCallVJContribution(days : Int){
        contributionList.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .vjCenterContribution,pass:"?days=\(days)", token: token) {[weak self] (response) -> (Void) in
            guard let weak = self else {return}
            do{
                let contribution = try JSONDecoder().decode(VJContributionModel.self, from: response)
                weak.contributionList = contribution.data
                
                if weak.contributionList.count == 0{
                    weak.nilView.frame = CGRect(x: 0, y: 0, width: weak.tblView.frame.size.width, height: weak.tblView.frame.size.height)
                    weak.nilView.imgView.image = #imageLiteral(resourceName: "Contribution(vector) – 1")
                    weak.nilView.msgLbl.text = "No data found"
                    weak.tblView.backgroundView = weak.nilView
                }else{
                    weak.tblView.restore()
                }
                weak.tblView.reloadData()
            }catch let err{
                weak.nilView.frame = CGRect(x: 0, y: 0, width: weak.tblView.frame.size.width, height: weak.tblView.frame.size.height)
                weak.nilView.imgView.image = #imageLiteral(resourceName: "Contribution(vector) – 1")
                weak.nilView.msgLbl.text = "No data found"
                weak.tblView.backgroundView = weak.nilView
                weak.tblView.reloadData()
                print(err.localizedDescription)
            }
        }
    }
    
}

extension ContributionScreen : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ContributionTblCell") as! ContributionTblCell
        let contribution = contributionList[indexPath.row]
        cell.giftIdLbl.text = "\(contribution.giftID)"
        cell.pointsLbl.text = "\(contribution.points)"
        cell.usernameLbl.text = contribution.contributor.name
        let imgUrl = URL(string: contribution.contributor.avatar)
        cell.userImage.sd_setImage(with: imgUrl, placeholderImage: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}



import Foundation

// MARK: - VJContributionModel
struct VJContributionModel: Codable {
    let data: [VJContributionDatum]
    let links: VJContributionLinks
    let meta: VJContributionMeta
    let code: Int
    let status: String
}

// MARK: - Datum
struct VJContributionDatum: Codable {
    let id: Int
    let date: String
    let timeStamp, streamVideoID, contributorID, receiverID: Int
    let points, giftID: Int
    let contributor, receiver: VJContributionContributor

    enum CodingKeys: String, CodingKey {
        case id, date
        case timeStamp = "time_stamp"
        case streamVideoID = "stream_video_id"
        case contributorID = "contributor_id"
        case receiverID = "receiver_id"
        case points
        case giftID = "gift_id"
        case contributor, receiver
    }
}

// MARK: - Contributor
struct VJContributionContributor: Codable {
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
struct VJContributionLinks: Codable {
    let first, last: String
}

// MARK: - Meta
struct VJContributionMeta: Codable {
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
