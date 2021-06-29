//
//  BLVideoScreenVC.swift
//  Bellalive
//
//  Created by apple on 19/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit
import AVKit

class BLVideoScreenVC: UIViewController,UITextFieldDelegate, dismissGift {

    @IBOutlet weak var TxtFieldChat: UITextField!
    @IBOutlet weak var ViewTextField: UIView!
    @IBOutlet weak var ViewInsideMessage: UIView!
    @IBOutlet var ViewMessage: UIView!
    @IBOutlet weak var commentTblView: UITableView!{
        didSet{
            commentTblView.dataSource = self
            commentTblView.delegate = self
        }
    }
    @IBOutlet weak var coverPathImg: UIImageView!
    
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var bellaIdLbl: UILabel!
    @IBOutlet weak var userDataView: UIView!
    @IBOutlet weak var floaterView: Floater!
    @IBOutlet weak var bellapointView: UIView!
    @IBOutlet weak var bellaPOintLbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var collectionview : UICollectionView!{
        didSet{
            collectionview.delegate = self
            collectionview.dataSource = self
        }
    }
    @IBOutlet weak var giftShowView: UIView!
    @IBOutlet weak var giftImageView: UIView!
    @IBOutlet weak var giftUserNameLbl: UILabel!
    @IBOutlet weak var giftNameLbl: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var giftImage: UIImageView!
    @IBOutlet weak var avVideoView: UIView!
    @IBOutlet weak var giftViewHeight: NSLayoutConstraint!
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var contributionBtn: UIButton!
    
    @IBOutlet weak var commentView: UIStackView!
    @IBOutlet weak var gifImageView: UIView!
    
    var guestUserProfile : GuestUserProfile?
    var playerLayer: AVPlayerLayer?
    var player : AVPlayer?
    var followingUserVideo : FollowingUserVideoData?
    var searchUserVideo : SearchVideoDataDatum?
    var isFromVC = String()
    var postVideoComment : CreateVideoCommentData?
    var videoCommentList = [VideoCommentListData]()
    var videoTopFans = [StreamTopFansDatum]()
    var userVideo : UserVideoListDatum?
    var TblLiveConstraint : CGFloat!
    var ViewFloatConstraint: CGFloat!
    var isKeyboardShowing : Bool = false
    var topSafeArea: CGFloat = 0
    var bottomSafeArea: CGFloat = 0
    var timer : Timer?
    
    var imageString = String(), gifImage = UIImageView(), videoId = Int()
    var timeCount = 5, gifTimeLeft = 5
    
    var userID = Int(), coverPath = String(), videoPath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerSetup()
        initialLoads()
        handleTap()
        TxtFieldChat.delegate = self
        ViewMessage.layer.cornerRadius = 10
        ViewInsideMessage.layer.cornerRadius = 10
        ViewMessage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        ViewInsideMessage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        ViewMessage.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        avVideoView.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapped() {
        apiCallForVideoLikeUnlike(videoId: videoId)
    }
    
    private func initialLoads(){
        if let imgUrl = URL(string: coverPath){
            coverPathImg.sd_setImage(with: imgUrl, placeholderImage: nil)
        }
        configure(with: videoPath)
        apiCallforUserProfile(userID: userID)
        apiCallForGetVideoComments(videoID: videoId)
        apiCallForVideoView(videoId: videoId)
        apiCallVideoTopFans(videoID: videoId)
        let userId = UserDefaults.standard.integer(forKey: "UserID")
        
        if userId == userID{
            giftView.isHidden = true
            giftViewHeight.constant = 0
        }else{
            giftView.isHidden = false
            giftViewHeight.constant = 40
        }

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ViewMessage.isHidden == false{
            ViewMessage.isHidden = true
            TxtFieldChat.resignFirstResponder()
        }
    }
    
    
    private func playerSetup(){
       let playerLayer = AVPlayerLayer()
        playerLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:
            self.view.frame.height)
        playerLayer.videoGravity = .resizeAspectFill
        self.avVideoView.layer.insertSublayer(playerLayer, at: 0)
        self.playerLayer = playerLayer
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        giftImageView.layer.cornerRadius = giftImageView.frame.height/2
        giftImage.layer.cornerRadius = giftImage.frame.height/2
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userDataView.layer.cornerRadius = userDataView.frame.height/2
        bellapointView.layer.cornerRadius = bellapointView.frame.height/2
        userPic.layer.cornerRadius = userPic.frame.height/2
        closeBtn.layer.cornerRadius = closeBtn.frame.height/2
        
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        viewDisplayMessage()
    }
    func viewDisplayMessage(){
        ViewMessage.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - (ViewMessage.frame.height + bottomSafeArea), width: UIScreen.main.bounds.size.width, height: ViewMessage.frame.height)
        view.addSubview(ViewMessage)
    }
    @IBAction func giftAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "GiftScreenID") as! GiftScreen
        rootVC.isFromVC = "video"
        rootVC.videoId = videoId
        rootVC.delegate = self
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    
    func dismissView(categoryGift: CategoryGiftList){
        timeCount = 5
        giftShowView.isHidden = false
        let originToReturn = CGPoint(x: self.view.frame.origin.x, y: self.giftShowView.frame.origin.y)

        UIView.animate(withDuration: 0.5, animations: {
            self.giftShowView.alpha = 0.0
            if self.giftShowView.isHidden == false {
                // Go left
                self.giftShowView.frame.origin.x =  0 - (self.giftShowView.frame.width * 1.5)

            } else {
                // Go right (you can change them)
                self.giftShowView.frame.origin.x =  self.view.frame.width + (self.giftShowView.frame.width * 1.5)
            }
            self.giftShowView.transform = CGAffineTransform(rotationAngle:-45)
            self.giftShowView.layoutIfNeeded()
            self.giftShowView.superview?.layoutIfNeeded()
        }) { (finished) in
            // Here you can update the cardViewData
            UIView.animate(withDuration: 0.5, animations: {
                self.giftShowView.transform = CGAffineTransform(rotationAngle:0)
                self.giftShowView.frame.origin =  originToReturn
                self.giftShowView.alpha = 1.0
                self.giftShowView.layoutIfNeeded()
                self.giftShowView.superview?.layoutIfNeeded()
            }, completion: { (finishedSecondAnimation) in

            })
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: false)
        imageString = categoryGift.animationGIF ?? ""
        let imgUrl = URL(string: categoryGift.icon)
        giftImage.sd_setImage(with: imgUrl, placeholderImage: nil)
        giftNameLbl.text = categoryGift.name
        if let image = Appcontext.shared.user?.avatar{
            let imageUrl = URL(string: image)
            userImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
        }
        giftUserNameLbl.text = Appcontext.shared.user?.firstName
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func onTimerFires(){
        timeCount -= 1
        if timeCount <= 0 {
            timer?.invalidate()
            timer = nil
            giftShowView.isHidden = true
            gifImageView.isHidden = false
            gifTimeLeft = 5
            let imageUrl = UIImage.gifImageWithURL(imageString)
            gifImage = UIImageView(image: imageUrl)
            gifImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            gifImageView.willRemoveSubview(gifImage)
            gifImageView.addSubview(gifImage)
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(gifShow), userInfo: nil, repeats: false)
        }
    }
    
    @objc func gifShow(){
        imageString = ""
        giftImage.image = nil
        gifTimeLeft -= 1
        if gifTimeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            gifImageView.isHidden = true
        }
    }

    @IBAction func contibutionAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "BLContributionListVC") as! BLContributionListVC
        rootVC.isFromVC = "video"
        rootVC.videoId = videoId
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.player?.pause()
        self.player = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func commentAction(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "Login") == "1"{
        ViewMessage.isHidden = false
        TxtFieldChat.text = ""
        TxtFieldChat.becomeFirstResponder()
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "SignInScreenID") as! SignInScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        }
    }
    
    @IBAction func shareAction(_ sender: Any) {
        self.player?.pause()
        self.player = nil
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "ShareScreenID") as! ShareScreen
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    
    
    @IBAction func userProfileAction(_ sender: Any) {
        self.player?.pause()
        self.player = nil
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileDetailsScreenID") as! ProfileDetailsScreen
        rootVC.userDetail = guestUserProfile?.data
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    
    
    @IBAction func commentSendAction(_ sender: Any) {
        apiCallForPostVideoComments(videoId: videoId)
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
        }
    }
    func configure(with urlString: String) {
        let url : URL = URL(string: urlString)!
        player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:
            self.view.frame.height)
        playerLayer.videoGravity = .resizeAspectFill
        self.avVideoView.layer.insertSublayer(playerLayer, at: 0)
        self.avVideoView.layer.addSublayer(playerLayer)
        player?.play()
        player?.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)
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
                if let image = guestUser.data.avatar{
                    let imgUrl = URL(string: image)
                    weakself.userPic.sd_setImage(with: imgUrl, placeholderImage: nil)
                }
                if let fName = guestUser.data.firstName, let lName = guestUser.data.lastName{
                    weakself.userNameLbl.text = fName + " " + lName
                }
                
                weakself.bellaIdLbl.text = guestUser.data.bellaliveId
                weakself.bellaPOintLbl.text = "\(guestUser.data.totalBellaPoints ?? 0)"
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallForGetVideoComments(videoID : Int){
        videoCommentList.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .videoCommentList,pass:"?video_id=\(videoID)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let videoComment = try JSONDecoder().decode(VideoCommentListModel.self, from: response)
                if let data = videoComment.data{
                    weakself.videoCommentList = data
                }
                if weakself.videoCommentList.count != 0{
                    weakself.commentView.isHidden = false
                }else{
                    weakself.commentView.isHidden = true
                }
                weakself.collectionview.reloadData()
                weakself.commentTblView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallVideoTopFans(videoID : Int){
        videoCommentList.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .videoTopFans,pass:"?video_id=\(videoID)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let video = try JSONDecoder().decode(StreamTopFansModel.self, from: response)
                weakself.videoTopFans = video.data
                
                weakself.collectionview.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallForPostVideoComments(videoId : Int){
       guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["video_id" : videoId,
                     "comment" : TxtFieldChat.text ?? ""] as [String : Any]
        WebService.shared.postMethodHeader(Api: .videoCommentCreate, parameter: param, token: token){[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let createComment = try JSONDecoder().decode(CreateVideoCommentModel.self, from: response)
                if let comment = createComment.data{
                    weakself.postVideoComment = comment
                }
                if weakself.isFromVC == "Following"{
                    weakself.apiCallForGetVideoComments(videoID: weakself.videoId)
                }
                weakself.TxtFieldChat.resignFirstResponder()
                weakself.ViewMessage.isHidden = true
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallForVideoView(videoId : Int){
       guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["video_id" : videoId] as [String : Any]
        WebService.shared.postMethodHeader(Api: .videoViewUpdate, parameter: param, token: token){ (response) -> (Void) in
            do{
                let videoView = try JSONDecoder().decode(VideoViewUpdateModel.self, from: response)
                print(videoView.status)
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallForVideoLikeUnlike(videoId : Int){
       guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["video_id" : videoId] as [String : Any]
        WebService.shared.postMethodHeader(Api: .videoLikeUpdate, parameter: param, token: token){ (response) -> (Void) in
            do{
                let videoView = try JSONDecoder().decode(VideoViewUpdateModel.self, from: response)
                print(videoView.status)
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    
    private func apiCallforVideoCommentersProfile(userID : Int){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .guestUserProfile, pass: "?user_id=\(userID)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let guestUser = try JSONDecoder().decode(GuestUserProfile.self, from: response)
                weakself.guestUserProfile = guestUser
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileDetailsScreenID") as! ProfileDetailsScreen
                rootVC.userDetail = weakself.guestUserProfile?.data
                rootVC.modalPresentationStyle = .overFullScreen
                weakself.present(rootVC, animated: true, completion: nil)
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    func handleTap() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (_) in
            UIViewController().generateAnimatedViews(view: self.floaterView)
        }
        
    }
}

extension BLVideoScreenVC: UITableViewDataSource,UITableViewDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoCommentList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCommentTVC", for: indexPath) as! VideoCommentTVC
        let data = videoCommentList[indexPath.row]
        cell.LblVideoMessage.text = data.comment
        cell.LblVideoUser.text = "\(data.user?.name ?? "") : "
        let randomNumber = randomInt(min: 1, max: 5)
        cell.LblVideoRating.text = "\(randomNumber)"
        cell.ViewVideoRating.backgroundColor = generateRandomColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension BLVideoScreenVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoTopFans.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCommentCVC", for: indexPath) as! VideoCommentCVC
        let video = videoTopFans[indexPath.item]
        //cell.videoUserPic.backgroundColor = generateRandomColor()
        let image = video.user.avatar
        let imgUrl = URL(string: image)
        cell.videoUserPic.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        apiCallforVideoCommentersProfile(userID: videoTopFans[indexPath.item].user.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class VideoCache {
//MARK: Initializer private init() {}
//Shared Object
static let shared = VideoCache()
//MARK: Private Properties
private let cache = NSCache<NSString, AVPlayer>()
//MARK: Internal Methods
func save(player: AVPlayer, with key: String) {
self.cache.setObject(player, forKey: key as NSString) }
func getPlayer(for key: String) -> AVPlayer? { return self.cache.object(forKey: key as NSString)
}
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let videoViewUpdateModel = try? newJSONDecoder().decode(VideoViewUpdateModel.self, from: jsonData)

import Foundation

// MARK: - VideoViewUpdateModel
struct VideoViewUpdateModel: Codable {
    let status: String
    let data: VideoViewDataClass
    let code: Int
}

// MARK: - DataClass
struct VideoViewDataClass: Codable {
    let id: Int
    let date: String
    let userID: Int
    let user: VideoViewUser
    let title, videoPath: String
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
struct VideoViewUser: Codable {
    let id: Int
    let bellaliveID, name: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case bellaliveID = "bellalive_id"
        case name, avatar
    }
}
