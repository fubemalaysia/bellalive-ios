//
//  VideosScreen.swift
//  Bellalive
//
//  Created by APPLE on 21/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class VideosScreen: UIViewController {

    @IBOutlet weak var collectonview: UICollectionView!{
        didSet{
            collectonview.dataSource = self
            collectonview.delegate = self
        }
    }
    
    var userVideoList = [UserVideoListDatum]()
    var nilView = EmptyBlockView()
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCallUserVideoList()
    }
    
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnUpload(_ sender: UIButton) {
        
    }
    
    private func apiCallUserVideoList(){
        userVideoList.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .userVideoList,parameter: nil, token: token){[weak self] (response) -> (Void) in
            guard let weak = self else{return}
            do{
                let message = try JSONDecoder().decode(UserVideoListModel.self, from: response)
                weak.userVideoList = message.data
                
                if weak.userVideoList.count == 0{
                    weak.nilView.frame = CGRect(x: 0, y: 0, width: weak.collectonview.frame.size.width, height: weak.collectonview.frame.size.height)
                    weak.nilView.msgLbl.text = "No data found"
                    weak.collectonview.backgroundView = weak.nilView
                }else{
                    weak.collectonview.restore()
                }
                weak.collectonview.reloadData()
                
            }catch let err{
                print(err.localizedDescription)
                weak.nilView.frame = CGRect(x: 0, y: 0, width: weak.collectonview.frame.size.width, height: weak.collectonview.frame.size.height)
                weak.nilView.msgLbl.text = "No data found"
                weak.collectonview.backgroundView = weak.nilView
            }
        }
    }
    
}
extension VideosScreen : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userVideoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoClnlCell", for: indexPath) as! VideoClnlCell
        let video = userVideoList[indexPath.item]
        cell.imgView.layer.cornerRadius = 10
        cell.videoNameLbl.text = video.title
        cell.viewCountLbl.text = "\(video.totalLikes)"
        
        let imgUrl = URL(string: video.coverPath)
        cell.imgView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "BLVideoScreenVC") as! BLVideoScreenVC
        rootVC.userVideo = userVideoList[indexPath.item]
        rootVC.isFromVC = "userVideo"
        rootVC.videoId = userVideoList[indexPath.item].id
        rootVC.userID = userVideoList[indexPath.row].userID
        rootVC.videoPath = userVideoList[indexPath.row].videoPath
        rootVC.coverPath = userVideoList[indexPath.row].coverPath
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width/2.1)
        let width = size
        let height = width
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}


import Foundation

// MARK: - UserVideoListModel
struct UserVideoListModel: Codable {
    let data: [UserVideoListDatum]
    let links: UserVideoListLinks
    let meta: UserVideoListMeta
    let code: Int
    let status: String
}

// MARK: - Datum
struct UserVideoListDatum: Codable {
    let id: Int
    let date: String
    let userID: Int
    let user: UserVideoListUser
    let title: String
    let videoPath: String
    let coverPath: String
    let totalAudience, totalLikes: Int
    let status: String
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case id, date
        case userID = "user_id"
        case user, title
        case videoPath = "video_path"
        case coverPath = "cover_path"
        case totalAudience = "total_audience"
        case totalLikes = "total_likes"
        case status
        case statusCode = "status_code"
    }
}

// MARK: - User
struct UserVideoListUser: Codable {
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
struct UserVideoListLinks: Codable {
    let first, last: String
}

// MARK: - Meta
struct UserVideoListMeta: Codable {
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
