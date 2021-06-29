//
//  StreamingScreen.swift
//  Bellalive
//
//  Created by APPLE on 27/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import SDWebImage
class StreamingScreen: UIViewController, UITextFieldDelegate,dismissGift  {
    var selectCell : Int!, selectTitle : Int!
    
    var TblLiveConstraint : CGFloat!
    var ViewFloatConstraint: CGFloat!
    var isKeyboardShowing : Bool = false
    var topSafeArea: CGFloat = 0
    var bottomSafeArea: CGFloat = 0
    @IBOutlet weak var TxtFieldChat: UITextField!
    @IBOutlet weak var ViewTextField: UIView!
    @IBOutlet weak var ViewInsideMessage: UIView!
    @IBOutlet var ViewMessage: UIView!
    @IBOutlet weak var commentTblView: UITableView!
    
    @IBOutlet weak var coverPathImg: UIImageView!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var bellaIdLbl: UILabel!
    @IBOutlet weak var userDataView: UIView!
    @IBOutlet weak var floaterView: Floater!
    @IBOutlet weak var bellapointView: UIView!
    @IBOutlet weak var bellaPOintLbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var collectionview : UICollectionView!
    @IBOutlet weak var giftShowView: UIView!
    @IBOutlet weak var giftImageView: UIView!
    @IBOutlet weak var giftUserNameLbl: UILabel!
    @IBOutlet weak var giftNameLbl: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var giftImage: UIImageView!
    @IBOutlet weak var giftButtonView: UIView!
    @IBOutlet weak var contributionBtn: UIButton!
    
    @IBOutlet weak var giftButtonViewHeight: NSLayoutConstraint!
    @IBOutlet weak var gifImageView: UIView!
    
    @IBOutlet weak var commentView: UIStackView!
    
    
    var isFromVC = String(), imageString = String(), gifImage = UIImageView()
    var timeCount = 5, gifTimeLeft = 5
    var timer:Timer?
    
    var streamID = String(), avatar = String(), userName = String(), bellailiveID = String(), userID = Int()
    
    
    let streamTblID = "streamingTblCell"
    let commentsTblID = "StreamingCommentsCell"
    var guestUserProfile : GuestUserProfile?
    var streamCommentList = [StreamCommentListData]()
    var postStreamComment : CreateStreamCommentData?
    var followingStreamList : FollowingStreamListData?
    var streamTopFans = [StreamTopFansDatum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TxtFieldChat.delegate = self
        ViewMessage.layer.cornerRadius = 10
        ViewInsideMessage.layer.cornerRadius = 10
        ViewMessage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        ViewInsideMessage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        setInitialLoads()
        ViewMessage.isHidden = true
        handleTap()
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        coverPathImg.isUserInteractionEnabled = true
        coverPathImg.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func doubleTapped() {
        apiCallForStreamLikeUnlike(streamId: streamID)
    }
    
    
    
    private func setInitialLoads(){
        let imgUrl = URL(string: avatar)
        userPic.sd_setImage(with: imgUrl, placeholderImage: nil)
        userNameLbl.text = userName
        bellaIdLbl.text = bellailiveID
        apiCallforUserProfile(userID: userID)
        apiCallForGetStreamComments(streamId: streamID)
        apiCallForStreamView(streamId: streamID)
        apiCallStreamTopFans(streamId: streamID)
        let userId = UserDefaults.standard.integer(forKey: "UserID")
        
        if userId == userID{
            giftButtonView.isHidden = true
            giftButtonViewHeight.constant = 0
        }else{
            giftButtonView.isHidden = false
            giftButtonViewHeight.constant = 40
        }
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
    
    private func apiCallforUserProfile(userID : Int){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .guestUserProfile, pass: "?user_id=\(userID)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let guestUser = try JSONDecoder().decode(GuestUserProfile.self, from: response)
                weakself.guestUserProfile = guestUser
                weakself.bellaPOintLbl.text = "\(guestUser.data.totalBellaPoints ?? 0)"
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallForStreamView(streamId : String){
       guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["stream_id" : streamId] as [String : Any]
        WebService.shared.postMethodHeader(Api: .streamViewUpdate, parameter: param, token: token){ (response) -> (Void) in
            do{
                let videoView = try JSONDecoder().decode(StreamViewUpdateModel.self, from: response)
                print(videoView.status)
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallForStreamLikeUnlike(streamId : String){
       guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["stream_id" : streamId] as [String : Any]
        WebService.shared.postMethodHeader(Api: .streamLikeUpdate, parameter: param, token: token){ (response) -> (Void) in
            do{
                let videoView = try JSONDecoder().decode(StreamViewUpdateModel.self, from: response)
                print(videoView.status)
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
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
    @IBAction func BtnSendMessage(_ sender: UIButton) {
        apiCallForPostSreamComments(streamId: streamID)
    }
    func viewDisplayMessage(){
        ViewMessage.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - (ViewMessage.frame.height + bottomSafeArea), width: UIScreen.main.bounds.size.width, height: ViewMessage.frame.height)
        view.addSubview(ViewMessage)
    }
    
    @IBAction func giftAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "GiftScreenID") as! GiftScreen
        rootVC.isFromVC = "stream"
        rootVC.streamId = streamID
        rootVC.delegate = self
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "ShareScreenID") as! ShareScreen
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    
    
    @IBAction func commentAction(_ sender: UIButton) {
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
    
    @IBAction func contributionAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "BLContributionListVC") as! BLContributionListVC
        rootVC.isFromVC = "stream"
        rootVC.streamId = streamID
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func userProfileAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileDetailsScreenID") as! ProfileDetailsScreen
        rootVC.userDetail = guestUserProfile?.data
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func apiCallForGetStreamComments(streamId : String){
        streamCommentList.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .streamCommentList,pass:"?stream_id=\(streamId)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let streamComment = try JSONDecoder().decode(StreamCommentListModel.self, from: response)
                if let data = streamComment.data{
                    weakself.streamCommentList = data
                }
                let userId = UserDefaults.standard.integer(forKey: "UserID")
                
                if userId == weakself.userID{
                    if weakself.streamCommentList.count != 0{
                        weakself.commentView.isHidden = false
                    }else{
                        weakself.commentView.isHidden = true
                    }
                }else{
                    weakself.commentView.isHidden = false
                }
                
                weakself.collectionview.reloadData()
                weakself.commentTblView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ViewMessage.isHidden == false{
            ViewMessage.isHidden = true
            TxtFieldChat.resignFirstResponder()
        }
    }
    
    private func apiCallStreamTopFans(streamId : String){
        streamTopFans.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .streamTopFans,pass:"?stream_id=\(streamId)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let stream = try JSONDecoder().decode(StreamTopFansModel.self, from: response)
                weakself.streamTopFans = stream.data
                
                weakself.collectionview.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallForPostSreamComments(streamId : String){
       guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["stream_id" : streamId,
                     "comment" : TxtFieldChat.text ?? ""]
        WebService.shared.postMethodHeader(Api: .streamCommentCreate, parameter: param, token: token){[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let createComment = try JSONDecoder().decode(CreateStreamCommentModel.self, from: response)
                if let comment = createComment.data{
                    weakself.postStreamComment = comment
                }
                weakself.apiCallForGetStreamComments(streamId: weakself.streamID)
                weakself.TxtFieldChat.resignFirstResponder()
                weakself.ViewMessage.isHidden = true
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func apiCallforStreamCommentersProfile(userID : Int){
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
extension StreamingScreen: UITableViewDataSource,UITableViewDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streamCommentList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentsTblID, for: indexPath) as! StreamMessageTblViewCell
        let data = streamCommentList[indexPath.row]
        cell.LblMessage.text = data.comment
        cell.LblUser.text = "\(data.user?.name ?? "") : "
        let randomNumber = randomInt(min: 1, max: 5)
        cell.LblRating.text = "\(randomNumber)"
        cell.ViewRating.backgroundColor = generateRandomColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension StreamingScreen : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamTopFans.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StreamCommentCVC", for: indexPath) as! StreamCommentCVC
        let stream = streamTopFans[indexPath.item]
        //cell.borderView.backgroundColor = generateRandomColor()
        let image = stream.user.avatar
        let imgUrl = URL(string: image)
        cell.userPic.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        apiCallforStreamCommentersProfile(userID: streamTopFans[indexPath.item].user.id)
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


import Foundation

// MARK: - GuestUserProfile
struct GuestUserProfile: Codable {
    let status: String
    let data: GuestUserDataClass
    let code: Int
}


struct GuestUserDataClass : Codable {

        let autoplayUnderNoWifi : Int?
        let avatar : String?
        let bellaliveId : String?
        let bio : String?
        let city : String?
        let country : GuestUserCountry?
        let customerLevel : String?
        let dob : String?
        let dobTimeStamp : Int?
        let fans : Int?
        let firstName : String?
        let following : Int?
        let gender : String?
        let id : Int?
        let lastName : String?
        let level : GuestUserLevel?
        let nickname : String?
        let occupation : String?
        let phoneNo : String?
        let postVideoLiveUnderNoWifi : Int?
        let pushNotification : Int?
        let totalBellaPoints : Int?
        let totalReceivePoints : Int?
        let totalSendPoints : Int?

        enum CodingKeys: String, CodingKey {
                case autoplayUnderNoWifi = "autoplay_under_no_wifi"
                case avatar = "avatar"
                case bellaliveId = "bellalive_id"
                case bio = "bio"
                case city = "city"
                case country = "country"
                case customerLevel = "customer_level"
                case dob = "dob"
                case dobTimeStamp = "dob_time_stamp"
                case fans = "fans"
                case firstName = "first_name"
                case following = "following"
                case gender = "gender"
                case id = "id"
                case lastName = "last_name"
                case level = "level"
                case nickname = "nickname"
                case occupation = "occupation"
                case phoneNo = "phone_no"
                case postVideoLiveUnderNoWifi = "post_video_live_under_no_wifi"
                case pushNotification = "push_notification"
                case totalBellaPoints = "total_bella_points"
                case totalReceivePoints = "total_receive_points"
                case totalSendPoints = "total_send_points"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                autoplayUnderNoWifi = try values.decodeIfPresent(Int.self, forKey: .autoplayUnderNoWifi)
                avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
                bellaliveId = try values.decodeIfPresent(String.self, forKey: .bellaliveId)
                bio = try values.decodeIfPresent(String.self, forKey: .bio)
                city = try values.decodeIfPresent(String.self, forKey: .city)
                country = try values.decodeIfPresent(GuestUserCountry.self, forKey: .country)
                customerLevel = try values.decodeIfPresent(String.self, forKey: .customerLevel)
                dob = try values.decodeIfPresent(String.self, forKey: .dob)
                dobTimeStamp = try values.decodeIfPresent(Int.self, forKey: .dobTimeStamp)
                fans = try values.decodeIfPresent(Int.self, forKey: .fans)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                following = try values.decodeIfPresent(Int.self, forKey: .following)
                gender = try values.decodeIfPresent(String.self, forKey: .gender)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                level = try values.decodeIfPresent(GuestUserLevel.self, forKey: .level)
                nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
                occupation = try values.decodeIfPresent(String.self, forKey: .occupation)
                phoneNo = try values.decodeIfPresent(String.self, forKey: .phoneNo)
                postVideoLiveUnderNoWifi = try values.decodeIfPresent(Int.self, forKey: .postVideoLiveUnderNoWifi)
                pushNotification = try values.decodeIfPresent(Int.self, forKey: .pushNotification)
                totalBellaPoints = try values.decodeIfPresent(Int.self, forKey: .totalBellaPoints)
                totalReceivePoints = try values.decodeIfPresent(Int.self, forKey: .totalReceivePoints)
                totalSendPoints = try values.decodeIfPresent(Int.self, forKey: .totalSendPoints)
        }

}


// MARK: - Country
struct GuestUserCountry: Codable {
    let id: Int
    let iso, name, stdCode: String

    enum CodingKeys: String, CodingKey {
        case id, iso, name
        case stdCode = "std_code"
    }
}

// MARK: - Level
struct GuestUserLevel: Codable {
    let id: Int
    let code, name: String
    let icon: String
    let min, max: Int
    let status: String
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let strteamViewUpdateModel = try? newJSONDecoder().decode(StrteamViewUpdateModel.self, from: jsonData)

import Foundation

// MARK: - StrteamViewUpdateModel
struct StreamViewUpdateModel: Codable {
    let status: String
    let data: StreamViewDataClass
    let code: Int
}

// MARK: - DataClass
struct StreamViewDataClass: Codable {
    let id: Int
    let date: String
    let userID: Int
    let user: StreamViewUser
    let streamID, title, streamPath: String
    let coverPath: String
    let totalAudience, totalLikes: Int
    let streamStatus, status: String

    enum CodingKeys: String, CodingKey {
        case id, date
        case userID = "user_id"
        case user
        case streamID = "stream_id"
        case title
        case streamPath = "stream_path"
        case coverPath = "cover_path"
        case totalAudience = "total_audience"
        case totalLikes = "total_likes"
        case streamStatus = "stream_status"
        case status
    }
}

// MARK: - User
struct StreamViewUser: Codable {
    let id: Int
    let bellaliveID, name: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case bellaliveID = "bellalive_id"
        case name, avatar
    }
}


// MARK: - StreamTopFansModel
struct StreamTopFansModel: Codable {
    let data: [StreamTopFansDatum]
    let links: StreamTopFansLinks
    let meta: StreamTopFansMeta
    let code: Int
    let status: String
}

// MARK: - Datum
struct StreamTopFansDatum: Codable {
    let totalPoints: String
    let user: StreamTopFansUser

    enum CodingKeys: String, CodingKey {
        case totalPoints = "total_points"
        case user
    }
}

// MARK: - User
struct StreamTopFansUser: Codable {
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
struct StreamTopFansLinks: Codable {
    let first, last: String
}

// MARK: - Meta
struct StreamTopFansMeta: Codable {
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
