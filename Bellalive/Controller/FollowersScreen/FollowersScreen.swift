//
//  FollowersScreen.swift
//  Bellalive
//
//  Created by APPLE on 20/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
enum Tab : String{
    case All
    case Users
    case Live
    case Video
}

class FollowersScreen: UIViewController {
    let titlesArr = ["All","Users","Live","Videos"]
    @IBOutlet weak var MainClnView: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var dataColloectionView: UICollectionView!
    
    var tabPosition = 0
    var followingUserList = [FollowingUserListData]()
    var followingUserVideo = [FollowingUserVideoData]()
    var followingStreamList = [FollowingStreamListData]()
    var headerArray = ["Users","Live","Video"]
    var liveImgWidth = CGFloat()
    var liveImgHeight = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainClnView.reloadData()
        MainClnView.selectItem(at: IndexPath(row: tabPosition, section: 0), animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.videoNotification(_:)), name: NSNotification.Name(rawValue: "BLVideoScreenVC_Notification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.streamNotification(_:)), name: NSNotification.Name(rawValue: "BLVideoScreenStream_Notification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

       apiCallForFollowingList()
       apiCallForFollowingVideo()
       apiCallForStreamList()
        
        MainClnView.reloadData()
        MainClnView.selectItem(at: IndexPath(row: tabPosition, section: 0), animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
    }
    
    @objc func videoNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            
            var followingUserVideo : FollowingUserVideoData?
            
            if let id = dict["followingUserVideo"] as? FollowingUserVideoData{
                followingUserVideo = id
            } else {
                followingUserVideo = nil
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "BLVideoScreenVC") as! BLVideoScreenVC
            rootVC.followingUserVideo = followingUserVideo
            rootVC.isFromVC = "Following"
            rootVC.videoId = followingUserVideo?.id ?? 0
            rootVC.userID = followingUserVideo?.userId ?? 0
            rootVC.videoPath = followingUserVideo?.videoPath ?? ""
            rootVC.coverPath = followingUserVideo?.coverPath ?? ""
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
            
            NotificationCenter.default.removeObserver("BLVideoScreenVC_Notification")
        }
    }
    
    
    @objc func streamNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            
            var followingStreamVideo : FollowingStreamListData?
            
            if let id = dict["followingStreamList"] as? FollowingStreamListData{
                followingStreamVideo = id
            } else {
                followingStreamVideo = nil
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "StreamingScreenID") as! StreamingScreen
            rootVC.avatar = followingStreamVideo?.user?.avatar ?? ""
            rootVC.bellailiveID = followingStreamVideo?.user?.bellaliveId ?? ""
            rootVC.userName = followingStreamVideo?.user?.name ?? ""
            rootVC.userID = followingStreamVideo?.userId ?? 0
            rootVC.streamID = followingStreamVideo?.streamId ?? ""
            rootVC.isFromVC = "Following"
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
            
            NotificationCenter.default.removeObserver("BLVideoScreenStream_Notification")
        }
    }
    
    @IBAction func BtnLogin(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "SignInScreenID") as! SignInScreen
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    
    
    private func apiCallForFollowingList(){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .followingUserList, parameter: nil, token: token) {[weak self] (response) -> (Void) in
            guard let weak = self else {return}
            do{
                let followingUserList = try JSONDecoder().decode(FollowingUserListModel.self, from: response)
                if let data = followingUserList.data{
                    weak.followingUserList = data
                    Appcontext.shared.followingUserList = data
                }
                weak.dataColloectionView.reloadData()
                weak.tblView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallForFollowingVideo(){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .videoList, parameter: nil, token: token) {[weak self] (response) -> (Void) in
            guard let weak = self else {return}
            do{
                let userVideo = try JSONDecoder().decode(FollowingUserVideoModel.self, from: response)
                if let data = userVideo.data{
                    weak.followingUserVideo = data
                    Appcontext.shared.followingUserVideo = data
                }
                weak.dataColloectionView.reloadData()
                weak.tblView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallForStreamList(){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .streamList, pass: "?paginate=\(150)&status=\(2)&follow=\(1)", token: token) {[weak self] (response) -> (Void) in
            guard let weak = self else {return}
            do{
                let streamList = try JSONDecoder().decode(FollowingStreamListModel.self, from: response)
                if let data = streamList.data{
                    weak.followingStreamList = data
                    Appcontext.shared.followingStreamList = data
                }
                weak.dataColloectionView.reloadData()
                weak.tblView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
}
extension FollowersScreen: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == MainClnView{
            return titlesArr.count
        }else{
            switch tabPosition{
            case 1: return (self.followingUserList.count)
            case 2: return (self.followingStreamList.count)
            case 3: return (self.followingUserVideo.count)
            default:
                return 0
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == MainClnView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowersClnCell", for: indexPath) as! FollowersClnViewCell
            let color1 :UIColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            let color2 :UIColor = #colorLiteral(red: 0.5333333333, green: 0.2823529412, blue: 0.9725490196, alpha: 1)
            
            cell.selectedBackgroundView = UIView(frame: cell.LblTitle.bounds)
            cell.selectedBackgroundView!.setGradientBackground(colorTop: color2, colorBottom: color1, cornerRadius: cell.layer.cornerRadius)
            cell.layer.cornerRadius = cell.frame.height / 2
            
            cell.ViewBG.backgroundColor = .clear
            cell.LblTitle.text = titlesArr[indexPath.item]
            
            return cell
        }else{
            switch tabPosition{
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowingUserClnCell", for: indexPath) as! FollowingUserClnCell
                let user = followingUserList[indexPath.item]
                if let image = user.avatar{
                    let imgUrl = URL(string: image)
                    cell.imgView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
                }
                cell.layoutIfNeeded()
                cell.bgView.backgroundColor = generateRandomColor()
                cell.bellaliveIdLbl.text = "Bellalive ID : \(user.bellaliveId ?? "")"
                cell.userNameLbl.text = user.name
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowingLiveVideoClnCell", for: indexPath) as! FollowingLiveVideoClnCell
                let live = followingStreamList[indexPath.item]
                if let image = live.coverPath{
                    let imgUrl = URL(string: image)
                    cell.imgView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
                }
                cell.likeCountLbl.text = "\(live.totalLikes ?? 0)"
                cell.viewCountLbl.text = "\(live.totalAudience ?? 0)"
                cell.thumbLbl.text = live.title
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowingLiveVideoClnCell", for: indexPath) as! FollowingLiveVideoClnCell
                let video = followingUserVideo[indexPath.item]
                if let image = video.coverPath{
                    let imgUrl = URL(string: image)
                    cell.imgView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
                }
                cell.likeCountBg.isHidden = true
                cell.viewCountBg.backgroundColor = .clear
                cell.viewCountLbl.text = "\(video.totalAudience ?? 0)"
                cell.thumbLbl.text = video.title
                return cell
                
            default: break
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == MainClnView{
            tabPosition = indexPath.item
            if tabPosition == 0{
                dataColloectionView.isHidden = true
                tblView.isHidden = false
            }else{
                dataColloectionView.isHidden = false
                tblView.isHidden = true
                dataColloectionView.reloadData()
            }
            print(indexPath.item)
        }else{
            switch tabPosition {
            case 1:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileLiveUserScreenID") as! ProfileLiveUserScreen
                rootVC.guestUserId = followingUserList[indexPath.item].id ?? 0
                rootVC.isFromVC = "Following"
                rootVC.modalPresentationStyle = .overFullScreen
                self.present(rootVC, animated: true, completion: nil)
            case 2:
                print(indexPath.item)
            case 3:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "BLVideoScreenVC") as! BLVideoScreenVC
                rootVC.followingUserVideo = followingUserVideo[indexPath.item]
                rootVC.isFromVC = "Following"
                rootVC.videoId = followingUserVideo[indexPath.item].id ?? 0
                rootVC.userID = followingUserVideo[indexPath.row].userId ?? 0
                rootVC.videoPath = followingUserVideo[indexPath.row].videoPath ?? ""
                rootVC.coverPath = followingUserVideo[indexPath.row].coverPath ?? ""
                rootVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(rootVC, animated: true)
            default:
                break
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == MainClnView{
            let width = collectionView.frame.size.width / 4
            return CGSize(width: width, height: 30)
        }else{
            if tabPosition == 1{
                return CGSize(width: collectionView.frame.width, height: 60)
            }else{
                let size = (collectionView.frame.size.width/2.1)
                let width = size
                let height = width
                return CGSize(width: width, height: height)
            }
        }
        
    }
}

extension FollowersScreen : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))

        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = headerArray[section]
        label.font = UIFont(name: "SFUIDisplay-Medium", size: 16)
        label.textColor = UIColor.white

        headerView.addSubview(label)

        return headerView
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = Bundle.main.loadNibNamed("FollowingUserTVC", owner: self, options: nil)?.first as! FollowingUserTVC
            cell.colloectioview.reloadData()
            return cell
        }else if indexPath.section == 1{
            let cell = Bundle.main.loadNibNamed("FollowingLiveTVC", owner: self, options: nil)?.first as! FollowingLiveTVC
            cell.titleLbl.text = "Live"
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectioview.reloadData()
            cell.collectionViewHeight.constant = cell.collectioview.collectionViewLayout.collectionViewContentSize.height
            return cell
        }else if indexPath.section == 2{
            let cell = Bundle.main.loadNibNamed("FollowingVideoTVC", owner: self, options: nil)?.first as! FollowingVideoTVC
            cell.titleLbl.text = "Video"
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectioview.reloadData()
            cell.collectionViewHeight.constant = cell.collectioview.collectionViewLayout.collectionViewContentSize.height
           
            return cell
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
           return followingUserList.count > 0 ? 120 : 0
        }else if indexPath.section == 1{
            return followingStreamList.count > 0 ? UITableView.automaticDimension : 0
        }else if indexPath.section == 2{
            return followingUserVideo.count > 0 ? UITableView.automaticDimension : 0
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
           return followingUserList.count > 0 ? 95 : 0
        }else if indexPath.section == 1{
            return followingStreamList.count > 0 ? 200 : 0
        }else if indexPath.section == 2{
            return followingUserVideo.count > 0 ? 200 : 0
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
           return followingUserList.count > 0 ? 30 : 0
        }else if section == 1{
            return followingStreamList.count > 0 ? 30 : 0
        }else if section == 2{
            return followingUserVideo.count > 0 ? 30 : 0
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
