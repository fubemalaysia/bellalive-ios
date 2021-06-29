//
//  ProfileLiveUserScreen.swift
//  Bellalive
//
//  Created by APPLE on 26/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import Popover

class ProfileLiveUserScreen: UIViewController {

    @IBOutlet weak var ViewVideo: UIView!
    @IBOutlet weak var LblAchievementsMedalsCount: UILabel!
    @IBOutlet weak var ViewAchievementsMedals: UIView!
    @IBOutlet weak var ViewTopFans: UIView!
    @IBOutlet weak var ViewContribution: UIView!
    @IBOutlet weak var LblFansCount: UILabel!
    @IBOutlet weak var LblFollowingCount: UILabel!
    @IBOutlet weak var LblZodiacSign: Custom!
    @IBOutlet weak var ViewZodiacSign: UIView!
    @IBOutlet weak var LblCountry: Custom!
    @IBOutlet weak var ViewCountry: UIView!
    @IBOutlet weak var LblRating: Custom!
    @IBOutlet weak var ImgRating: UIImageView!
    @IBOutlet weak var ViewRating: UIView!
    @IBOutlet weak var LblRisingStar: Custom!
    @IBOutlet weak var ImgRisingStar: UIImageView!
    @IBOutlet weak var ViewRisingStar: UIView!
    @IBOutlet weak var LblProfileID: UILabel!
    @IBOutlet weak var LblProfileName: UILabel!
    @IBOutlet weak var BtnFollowOutlet: UIButton!
    @IBOutlet weak var ViewLive: UIView!
    @IBOutlet weak var ImgProfilePic: UIImageView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var reportBlockBtn: UIButton!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderImg: UIImageView!
    @IBOutlet weak var emptyMsgView: UIView!
    
    var userDetails : GuestUserDataClass?
    var guestUserVideo = [GuestUserVideoData]()
    var searchUser : SearchData?
    var isFromVC = String()
    fileprivate var texts = ["Report","Block"]
    fileprivate var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [
      .type(.auto),
      .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
    ]
    var guestUserId = Int()
    
    var guestUserProfile : GuestUserProfile?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let c1 = #colorLiteral(red: 0.5333333333, green: 0.2823529412, blue: 0.9725490196, alpha: 1)
        let c2 = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        let c3 = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        genderView.layer.cornerRadius = genderView.frame.height/2
        genderImg.layer.cornerRadius = genderImg.frame.height/2
        BtnFollowOutlet.applyGradient(colors: [c2.cgColor,c1.cgColor])
        ImgProfilePic.layer.cornerRadius = ImgProfilePic.frame.height/2
        ViewLive.layer.cornerRadius = ViewLive.frame.width/2
        ViewLive.applyGradientLive(colors: [c3.cgColor,c2.cgColor,c1.cgColor])
        ViewRisingStar.layer.cornerRadius = ViewRisingStar.frame.height/2
        ViewRating.layer.cornerRadius = ViewRating.frame.height/2
        ViewZodiacSign.layer.cornerRadius = ViewZodiacSign.frame.height/2
        ViewCountry.layer.cornerRadius = ViewCountry.frame.height/2
        ViewContribution.layer.cornerRadius = 10
        ViewTopFans.layer.cornerRadius = 10
        ViewAchievementsMedals.layer.cornerRadius = 10
        ViewVideo.layer.cornerRadius = 10
        ViewVideo.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    private func initialLoads(){
        if isFromVC == "search"{
            apiCallforUserProfile(userID: searchUser?.id ?? 0)
            apiCallforUserVideo(userID: searchUser?.id ?? 0)
        }else if isFromVC == "Following" {
            apiCallforUserProfile(userID: guestUserId)
            apiCallforUserVideo(userID: guestUserId)
        }else{
            apiCallforUserProfile(userID: userDetails?.id ?? 0)
            apiCallforUserVideo(userID: userDetails?.id ?? 0)
        }
        
    }
    
    @IBAction func BtnBack(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func BtnFollow(_ sender: UIButton) {
        if UserDefaults.standard.string(forKey: "Login") == "1"{
            if isFromVC == "search"{
                let param = ["user_id" : searchUser?.id ?? 0,
                             "stream_video_id" : ""] as [String:Any]
                apicallforUserFollowing(param: param)
            }else if isFromVC == "Following" {
                let param = ["user_id" : guestUserId,
                             "stream_video_id" : ""] as [String:Any]
                apicallforUserFollowing(param: param)
            }else{
                let param = ["user_id" : userDetails?.id ?? 0,
                             "stream_video_id" : ""] as [String:Any]
                apicallforUserFollowing(param: param)
            }
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "SignInScreenID") as! SignInScreen
            let navigationController =  UINavigationController(rootViewController: rootVC)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.isNavigationBarHidden = true
            navigationController.isToolbarHidden = true
            self.present(navigationController, animated: false, completion: nil)
        }
    }
    @IBAction func BtnContribution(_ sender: UIButton) {
    }
    @IBAction func BtnTopFans(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "TopFansScreenID") as! TopFansScreen
        rootVC.modalPresentationStyle = .fullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    @IBAction func BtnAchievementMedals(_ sender: UIButton) {
    }
    private func apiCallforUserVideo(userID : Int){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .guestUserVideoList, pass: "?user_id=\(userID)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let guestUserVideo = try JSONDecoder().decode(GuestUserVideoModel.self, from: response)
                if let videoData = guestUserVideo.data{
                    weakself.guestUserVideo = videoData
                }
                
                if weakself.guestUserVideo.count == 0{
                    weakself.emptyMsgView.isHidden = false
                }else{
                    weakself.emptyMsgView.isHidden = true
                }
                weakself.videoCollectionView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallforUserProfile(userID : Int){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .guestUserProfile, pass: "?user_id=\(userID)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let guestUser = try JSONDecoder().decode(GuestUserProfile.self, from: response)
                weakself.guestUserProfile = guestUser
                let  imgUrl = URL(string: weakself.guestUserProfile?.data.avatar ?? "")
                weakself.ImgProfilePic.sd_setImage(with: imgUrl, placeholderImage: nil)
                weakself.LblFansCount.text = "\(weakself.guestUserProfile?.data.fans ?? 0)"
                if let fname = weakself.guestUserProfile?.data.firstName,let lName = weakself.guestUserProfile?.data.lastName{
                    weakself.LblProfileName.text = fname + " " + lName
                }
                if weakself.guestUserProfile?.data.gender == "Girl"{
                    weakself.genderImg.image = UIImage(named: "female")
                }else{
                    weakself.genderImg.image = UIImage(named: "men")
                }
                weakself.LblCountry.text = weakself.guestUserProfile?.data.country?.name
                weakself.LblZodiacSign.text = weakself.guestUserProfile?.data.gender
                weakself.LblFollowingCount.text = "\(weakself.guestUserProfile?.data.following ?? 0)"
                weakself.LblRating.text = weakself.guestUserProfile?.data.level?.code
                weakself.LblRisingStar.text = weakself.guestUserProfile?.data.level?.name
                weakself.LblProfileID.text = "ID : \(weakself.guestUserProfile?.data.bellaliveId ?? "")"
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apicallforUserFollowing(param : [String:Any]){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.postMethodHeader(Api: .followUserUpdate, parameter: param, token: token){[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let following = try JSONDecoder().decode(FollowingModel.self, from: response)
                if following.success != nil{
                    Toast.makeToast(message: following.status ?? "", in: weakself.view){}
                }else{
                    Toast.makeToast(message: following.status ?? "", in: weakself.view){}
                }
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    @IBAction func userReportBlockAction(_ sender: UIButton) {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3.3, height: 60))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        popover = Popover(options: popoverOptions, showHandler: nil, dismissHandler: nil)
        self.popover.show(tableView, fromView: self.reportBlockBtn)
    }
    
    private func apicallforUserBlock(userId : Int){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["user_id" : userId]
        WebService.shared.postMethodHeader(Api: .blockedUpdate, parameter: param, token: token){[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let block = try JSONDecoder().decode(UserBlockModel.self, from: response)
                weakself.createAlertBox(title: block.success, message: "", buttonName: "OK")
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    private func blockSetup(){
        let title = "Block account"
        let message = "They won't able to find your profile post videos on Bellaive. Bellalive won't let them know that you've blocked them"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.modalPresentationStyle = .popover
            let action1 = UIAlertAction(title: "Block", style: .destructive) { (action) in
                print("Default is pressed.....")
                if self.isFromVC == "search"{
                    self.apicallforUserBlock(userId: self.searchUser?.id ?? 0)
                }else if self.isFromVC == "Following" {
                    self.apicallforUserBlock(userId: self.guestUserId)
                }else{
                    self.apicallforUserBlock(userId: self.userDetails?.id ?? 0)
                }
            }
            let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                print("Cancel is pressed......")
            }
        
        action1.setValue(UIColor(hex: "531B93"), forKey: "titleTextColor")
        action2.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.setTint(color: .black)
        alertController.setTitlet(font: UIFont(name: "SFUIDisplay-Medium", size: 15), color: .black)
        alertController.setMessage(font: UIFont(name: "SFUIDisplay-Regular", size: 12), color: .black)
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)

    }
}

extension ProfileLiveUserScreen : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guestUserVideo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BLGuestUserVideoCVC", for: indexPath) as! BLGuestUserVideoCVC
        let userVideo = guestUserVideo[indexPath.item]
        if let image = userVideo.coverPath{
            let imgUrl = URL(string: image)
            cell.thumbImg.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
        }
        
        cell.videoContentLbl.text = userVideo.title
        cell.viewCountLbl.text = "\(userVideo.totalAudience ?? 0)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width/2) - 10
        return CGSize(width: size, height: 160)
    }
}

extension ProfileLiveUserScreen: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0{
        createAlertBox(title: "coming soon", message: "", buttonName: "OK")
    }else{
        blockSetup()
    }
    self.popover.dismiss()
  }
}

extension ProfileLiveUserScreen: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return 2
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    cell.textLabel?.text = self.texts[(indexPath as NSIndexPath).row]
    cell.textLabel?.textAlignment = .center
    cell.textLabel?.font = UIFont(name: "SFUIDisplay-Medium", size: 14)
    cell.textLabel?.textColor = UIColor(hex: "531B93")
    cell.selectionStyle = .none
    return cell
  }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}


import Foundation

// MARK: - UserBlockModel
struct UserBlockModel: Codable {
    let status, success: String
    let code: Int
}
