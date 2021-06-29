//
//  PopularScreen.swift
//  Bellalive
//
//  Created by APPLE on 24/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class PopularScreen: UIViewController {
    
    var selection = [String]()
    var selectedItem = 0
    var selectedIndex = 0
    var selectedTxt = "Popular"
    var contributionArray = ["Popular", "Contribution"]
    var popularData = [PopularData]()
    var contributionData = [PopularData]()
    
    @IBOutlet weak var ImgBackground: UIImageView!
    @IBOutlet weak var ViewSilverBackground: UIView!
    @IBOutlet weak var LblSilverProfilePoints: UILabel!
    @IBOutlet weak var LblSilverProfileName: UILabel!
    @IBOutlet weak var ImgSilverProfilePic: UIImageView!
    @IBOutlet weak var ViewSilver: UIView!
    @IBOutlet weak var ViewBronzeBackground: UIView!
    @IBOutlet weak var LblBronzeProfilePoints: UILabel!
    @IBOutlet weak var LblBronzeProfileName: UILabel!
    @IBOutlet weak var ImgBronzeProfilePic: UIImageView!
    @IBOutlet weak var ViewBronze: UIView!
    @IBOutlet weak var ViewGoldBackground: UIView!
    @IBOutlet weak var LblGoldProfilePoints: UILabel!
    @IBOutlet weak var LblGoldProfileName: UILabel!
    @IBOutlet weak var ImgGoldProfilePic: UIImageView!
    @IBOutlet weak var ViewGold: UIView!
    @IBOutlet weak var TblViewPopular: UITableView!
    @IBOutlet weak var CustomSegmentOutlet: CustomSegmentControl!
    @IBOutlet weak var PopularClnView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeView()
        TblViewPopular.tableFooterView = UIView()
        if selectedTxt == "Popular"{
            apiCallforPopularList(type: "1")
            CustomSegmentOutlet.selectedSegmentIndex = 0
        }else{
            CustomSegmentOutlet.selectedSegmentIndex = 0
            apiCallforContributionList(type: "1")
        }
        
        
        // Do any additional setup after loading the view.
    }
    func shapeView(){
        ViewGoldBackground.layer.cornerRadius = 10
        ViewSilverBackground.layer.cornerRadius = 10
        ViewBronzeBackground.layer.cornerRadius = 10
        ImgGoldProfilePic.layer.cornerRadius = ImgGoldProfilePic.frame.height/2
        ImgSilverProfilePic.layer.cornerRadius = ImgSilverProfilePic.frame.height/2
        ImgBronzeProfilePic.layer.cornerRadius = ImgBronzeProfilePic.frame.height/2
        ImgGoldProfilePic.layer.borderWidth = 3
        ImgGoldProfilePic.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.6823529412, blue: 0.05098039216, alpha: 1)
        ImgSilverProfilePic.layer.borderWidth = 2
        ImgSilverProfilePic.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.9568627451, blue: 0.9960784314, alpha: 1)
        ImgBronzeProfilePic.layer.borderWidth = 2
        ImgBronzeProfilePic.layer.borderColor = #colorLiteral(red: 0.9725490196, green: 0.4196078431, blue: 0, alpha: 1)
        TblViewPopular.layer.cornerRadius = 10
    }
    
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func CustomSegmentAction(_ sender: CustomSegmentControl) {
        print(sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0{
            if  selectedTxt == "Popular" {
                apiCallforPopularList(type: "1")
            }else{
                apiCallforContributionList(type: "1")
            }
        }else if sender.selectedSegmentIndex == 1{
            if  selectedTxt == "Popular" {
                apiCallforPopularList(type: "2")
            }else{
                apiCallforContributionList(type: "2")
            }
        }else if sender.selectedSegmentIndex == 2{
            if  selectedTxt == "Popular" {
                apiCallforPopularList(type: "3")
            }else{
                apiCallforContributionList(type: "3")
            }
        }else if sender.selectedSegmentIndex == 3{
            if  selectedTxt == "Popular" {
                apiCallforPopularList(type: "0")
            }else{
                apiCallforContributionList(type: "0")
            }
        }
    }
    
    
    private func apiCallforPopularList(type : String){
        popularData.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .popularList, pass: "?type=\(type)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let popular = try JSONDecoder().decode(PopuarList.self, from: response)
                if let data = popular.data{
                   weakself.popularData = data
                }
                
                
                if weakself.popularData.count == 0{
                    weakself.TblViewPopular.setEmptyMessage("No Data Found")
                    weakself.ViewBronze.isHidden = true
                    weakself.ViewSilver.isHidden = true
                    weakself.ViewGold.isHidden = true
                }else if popular.data?.count == 1{
                    let imgUrl = URL(string: weakself.popularData[0].user?.avatar ?? "")
                    weakself.ImgGoldProfilePic.sd_setImage(with: imgUrl, placeholderImage: nil)
                    weakself.LblGoldProfileName.text = weakself.popularData[0].user?.name
                    weakself.LblGoldProfilePoints.text = weakself.popularData[0].totalPoints
                    weakself.ViewGold.isHidden = false
                    weakself.ViewBronze.isHidden = true
                    weakself.ViewSilver.isHidden = true
                    weakself.TblViewPopular.restore()
                }else if popular.data?.count == 2{
                    let imgUrl1 = URL(string: weakself.popularData[0].user?.avatar ?? "")
                    weakself.ImgGoldProfilePic.sd_setImage(with: imgUrl1, placeholderImage: nil)
                    weakself.LblGoldProfileName.text = weakself.popularData[0].user?.name
                    weakself.LblGoldProfilePoints.text = weakself.popularData[0].totalPoints
                    
                    let imgUrl2 = URL(string: weakself.popularData[1].user?.avatar ?? "")
                    weakself.ImgSilverProfilePic.sd_setImage(with: imgUrl2, placeholderImage: nil)
                    weakself.LblSilverProfileName.text = weakself.popularData[1].user?.name
                    weakself.LblSilverProfilePoints.text = weakself.popularData[1].totalPoints
                    weakself.ViewGold.isHidden = false
                    weakself.ViewBronze.isHidden = true
                    weakself.ViewSilver.isHidden = false
                    weakself.TblViewPopular.restore()
                }else if popular.data?.count ?? 0 >= 3{
                    let imgUrl1 = URL(string: weakself.popularData[0].user?.avatar ?? "")
                    weakself.ImgGoldProfilePic.sd_setImage(with: imgUrl1, placeholderImage: nil)
                    weakself.LblGoldProfileName.text = weakself.popularData[0].user?.name
                    weakself.LblGoldProfilePoints.text = weakself.popularData[0].totalPoints
                    
                    let imgUrl2 = URL(string: weakself.popularData[1].user?.avatar ?? "")
                    weakself.ImgSilverProfilePic.sd_setImage(with: imgUrl2, placeholderImage: nil)
                    weakself.LblSilverProfileName.text = weakself.popularData[1].user?.name
                    weakself.LblSilverProfilePoints.text = weakself.popularData[1].totalPoints
                    
                    let imgUrl3 = URL(string: weakself.popularData[2].user?.avatar ?? "")
                    weakself.ImgBronzeProfilePic.sd_setImage(with: imgUrl3, placeholderImage: nil)
                    weakself.LblBronzeProfileName.text = weakself.popularData[2].user?.name
                    weakself.LblBronzeProfilePoints.text = weakself.popularData[2].totalPoints
                    weakself.ViewBronze.isHidden = false
                    weakself.ViewGold.isHidden = false
                    weakself.ViewSilver.isHidden = false
                    weakself.TblViewPopular.restore()
                }else{
                    weakself.ViewBronze.isHidden = false
                    weakself.ViewSilver.isHidden = false
                    weakself.ViewGold.isHidden = false
                    weakself.TblViewPopular.restore()
                }
                
                weakself.TblViewPopular.reloadData()
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallforContributionList(type : String){
        contributionData.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .contributionList, pass: "?type=\(type)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let contribution = try JSONDecoder().decode(PopuarList.self, from: response)
                if let data = contribution.data{
                    weakself.contributionData = data
                }
               
                
                if weakself.contributionData.count == 0{
                    weakself.TblViewPopular.setEmptyMessage("No Data Found")
                    weakself.ViewBronze.isHidden = true
                    weakself.ViewSilver.isHidden = true
                    weakself.ViewGold.isHidden = true
                }else if weakself.contributionData.count == 1{
                    let imgUrl = URL(string: weakself.contributionData[0].user?.avatar ?? "")
                    weakself.ImgGoldProfilePic.sd_setImage(with: imgUrl, placeholderImage: nil)
                    weakself.LblGoldProfileName.text = weakself.contributionData[0].user?.name
                    weakself.LblGoldProfilePoints.text = weakself.contributionData[0].totalPoints
                    weakself.ViewGold.isHidden = false
                    weakself.ViewBronze.isHidden = true
                    weakself.ViewSilver.isHidden = true
                    weakself.TblViewPopular.restore()
                }else if weakself.contributionData.count == 2{
                    let imgUrl1 = URL(string: weakself.contributionData[0].user?.avatar ?? "")
                    weakself.ImgGoldProfilePic.sd_setImage(with: imgUrl1, placeholderImage: nil)
                    weakself.LblGoldProfileName.text = weakself.contributionData[0].user?.name
                    weakself.LblGoldProfilePoints.text = weakself.contributionData[0].totalPoints
                    
                    let imgUrl2 = URL(string: weakself.contributionData[1].user?.avatar ?? "")
                    weakself.ImgSilverProfilePic.sd_setImage(with: imgUrl2, placeholderImage: nil)
                    weakself.LblSilverProfileName.text = weakself.contributionData[1].user?.name
                    weakself.LblSilverProfilePoints.text = weakself.contributionData[1].totalPoints
                    weakself.ViewGold.isHidden = false
                    weakself.ViewBronze.isHidden = true
                    weakself.ViewSilver.isHidden = false
                    weakself.TblViewPopular.restore()
                }else if weakself.contributionData.count >= 3{
                    let imgUrl1 = URL(string: weakself.contributionData[0].user?.avatar ?? "")
                    weakself.ImgGoldProfilePic.sd_setImage(with: imgUrl1, placeholderImage: nil)
                    weakself.LblGoldProfileName.text = weakself.contributionData[0].user?.name
                    weakself.LblGoldProfilePoints.text = weakself.contributionData[0].totalPoints
                    
                    let imgUrl2 = URL(string: weakself.contributionData[1].user?.avatar ?? "")
                    weakself.ImgSilverProfilePic.sd_setImage(with: imgUrl2, placeholderImage: nil)
                    weakself.LblSilverProfileName.text = weakself.contributionData[1].user?.name
                    weakself.LblSilverProfilePoints.text = weakself.contributionData[1].totalPoints
                    
                    let imgUrl3 = URL(string: weakself.contributionData[2].user?.avatar ?? "")
                    weakself.ImgBronzeProfilePic.sd_setImage(with: imgUrl3, placeholderImage: nil)
                    weakself.LblBronzeProfileName.text = weakself.contributionData[2].user?.name
                    weakself.LblBronzeProfilePoints.text = weakself.contributionData[2].totalPoints
                    weakself.ViewGold.isHidden = false
                    weakself.ViewBronze.isHidden = false
                    weakself.ViewSilver.isHidden = false
                    weakself.TblViewPopular.restore()
                }else{
                    weakself.ViewBronze.isHidden = false
                    weakself.ViewSilver.isHidden = false
                    weakself.ViewGold.isHidden = false
                    weakself.TblViewPopular.restore()
                }
                
                weakself.TblViewPopular.reloadData()
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
}
extension PopularScreen: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedTxt == "Popular"{
           return popularData.count
        }else{
            return contributionData.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedTxt == "Popular"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PopularTblViewCell
            let popular = popularData[indexPath.row]
            let imgUrl = URL(string: popular.user?.avatar ?? "")
            cell.ImgProfilePic.sd_setImage(with: imgUrl, placeholderImage: nil)
            cell.ImgRanking.isHidden = true
            cell.LblProfileName.text = popular.user?.name
            cell.LblPoints.text = popular.totalPoints
            cell.LblCount.text = "\(indexPath.row + 1)"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell", for: indexPath) as! PopularTblViewCell
            let contribution = contributionData[indexPath.row]
            let imgUrl = URL(string: contribution.user?.avatar ?? "")
            DispatchQueue.main.async {
                cell.ImgProfilePic.layer.cornerRadius = cell.ImgProfilePic.frame.height/2
            }
            cell.ImgProfilePic.sd_setImage(with: imgUrl, placeholderImage: nil)
            cell.ImgRanking.isHidden = true
            cell.LblProfileName.text = contribution.user?.name
            cell.LblPoints.text = contribution.totalPoints
            cell.LblCount.text = "\(indexPath.row + 1)"
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension PopularScreen: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contributionArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularClnCell", for: indexPath) as! PopularClnViewCell
        cell.LblTitle.text = contributionArray[indexPath.item]
        if indexPath.item == selectedIndex{
            if cell.LblTitle.transform == .identity{
                cell.LblTitle.transform = cell.LblTitle.transform.scaledBy(x: 1.6, y: 1.6)
            }
            
        }else{
            cell.LblTitle.transform = .identity
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        selectedTxt = contributionArray[indexPath.item]
        CustomSegmentOutlet.selectedSegmentIndex = 0
        CustomSegmentOutlet.selectorColor = UIColor.white.withAlphaComponent(0.4)
        if selectedTxt == "Popular"{
            ImgBackground.image = #imageLiteral(resourceName: "Background")
            apiCallforPopularList(type: "1")
        }else{
            ImgBackground.image = #imageLiteral(resourceName: "Background (Contrubution)")
            apiCallforContributionList(type: "1")
        }
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularClnCell", for: indexPath) as! PopularClnViewCell
       // let width = cell.LblTitle.intrinsicContentSize.width
        let width = collectionView.frame.width/2
        return CGSize(width: width, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}



class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
