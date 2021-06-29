//
//  HomeScreen.swift
//  Bellalive
//
//  Created by APPLE on 20/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation

class HomeScreen: UIViewController,CLLocationManagerDelegate{
    var locationManager = CLLocationManager()
    let Title = ["For you","Feature","Near By","Newest"]
    var selectTitle = 0
    var bannerCategoryData : bannerCategoryApi? 
    var locUpdateData : locDataApi?
    var liveImgHeight: CGFloat!
    var liveImgWidth: CGFloat!
    var newestDataVal : [newestDataApi]?
    var featuredDataVal : [newestDataApi]?
    var foryouDataVal : [newestDataApi]?
    var nearByUserVal : [nearByUserData]?
    
    @IBOutlet weak var LiveClnView: UICollectionView!
    @IBOutlet weak var MainClnView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialLoads()
        streamListApiCall()
        bannerApi()
        newestApiCall()
        featureApiCall()
        nearByUserApiCall()
    }
    
    private func initialLoads(){
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways{
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let params = ["latitude":locations.last?.coordinate.latitude ?? 0.0,
                      "longitude":locations.last?.coordinate.longitude ?? 0.0] as [String : Any]
        self.locUpdate(params: params)
        locationManager.stopUpdatingLocation()
    }
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status != .authorizedWhenInUse {return}
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.startUpdatingLocation()
//        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//        let params = ["latitude":locValue.latitude,
//                      "longitude":locValue.longitude]
//        self.locUpdate(params: params)
//    }
    func locUpdate(params: [String:Any]){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.postMethodHeader(Api: .locationUpdate, parameter: params, token: token) { (response) -> (Void) in
            do{
                let loc = try JSONDecoder().decode(locDataApi.self, from: response)
                self.locUpdateData = loc
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    @IBAction func BtnSearch(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "SearchScreenID") as! SearchScreen
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @IBAction func BtnContribution(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "PopularScreenID") as! PopularScreen
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    func bannerApi(){
        WebService.shared.getMethodUrl(Api: .categoryList, urlString: "?api_token=\(api_Token)", parameter: nil) { (response) -> (Void) in
            do{
                let json = try JSONDecoder().decode(bannerCategoryApi.self, from: response)
                self.bannerCategoryData = json
                self.LiveClnView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    func newestApiCall(){
        newestDataVal?.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .newestList, pass: "?type=2", token: token) { (response) -> (Void) in
            do{
                let newest = try JSONDecoder().decode(newestApi.self, from: response)
                if let newData = newest.data{
                    self.newestDataVal = newData
                }
                self.LiveClnView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    func featureApiCall(){
        featuredDataVal?.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .featuredList,parameter: nil, token: token) { (response) -> (Void) in
            do{
                let newest = try JSONDecoder().decode(newestApi.self, from: response)
                if let newData = newest.data{
                    self.featuredDataVal = newData
                }
                self.LiveClnView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    func streamListApiCall(){
        foryouDataVal?.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .streamList,pass:"?paginate=50&status=2", token: token) { (response) -> (Void) in
            do{
                let newest = try JSONDecoder().decode(streamListApi.self, from: response)
                if let newData = newest.data{
                    self.foryouDataVal = newData
                }
                self.LiveClnView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    func nearByUserApiCall(){
        nearByUserVal?.removeAll()
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .nearestUser, parameter: nil, token: token) { (response) -> (Void) in
            do{
                let nearuser = try JSONDecoder().decode(nearByUserApi.self, from: response)
                if let newData = nearuser.data{
                    self.nearByUserVal = newData
                }
                self.LiveClnView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    @objc func addAction(sender : UIButton){
        let param = ["user_id" : nearByUserVal?[sender.tag].id ?? 0,
        "stream_video_id" : ""] as [String:Any]
        apicallforUserFollowing(param: param)
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
    
}
extension HomeScreen:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == MainClnView{
            return Title.count
        }else{
            if collectionView.tag == 040{
                return self.bannerCategoryData?.data?.count ?? 0
            }else{
                switch selectTitle{
                case 0: return (self.foryouDataVal?.count ?? 0) + 1
                case 1: return (self.featuredDataVal?.count ?? 0) + 1
                case 2: return (self.nearByUserVal?.count ?? 0) + 1
                case 3: return (self.newestDataVal?.count ?? 0) + 1
                default:
                    return 0
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == MainClnView{
            let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainClnCell", for: indexPath) as! MainClnViewCell
            maincell.LblTitle.text = Title[indexPath.item]
            maincell.LblTitle.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)
            return maincell
        }else{
            if collectionView.tag == 040{
                let scroll = collectionView.dequeueReusableCell(withReuseIdentifier: "ScrollClnCell", for: indexPath) as! ScrollClnViewCell
                if let imgStr = self.bannerCategoryData?.data?[indexPath.item].banner?[0].file, let imgUrl = URL(string: imgStr){
                    scroll.ImgScroll.sd_setImage(with: imgUrl, placeholderImage:  nil)
                }
                scroll.ImgScrollWidth.constant = UIScreen.main.bounds.size.width - 20
                scroll.ImgScroll.layer.cornerRadius = 10
                scroll.ImgScroll.layer.masksToBounds = true
                scroll.layer.cornerRadius = 10
                return scroll
            }else{
                if indexPath.item == 0{
                    let livescroll = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveScrollCell", for: indexPath) as! LiveScrollViewCell
                    livescroll.layer.cornerRadius = 10
                    livescroll.PageControl.numberOfPages = self.bannerCategoryData?.data?.count ?? 0
                    livescroll.ScrollClnView.reloadData()
                    livescroll.ScrollClnView.layer.cornerRadius = 10
                    return livescroll
                }else{
                    switch selectTitle{
                        case 0:
                            let live = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveClnCell", for: indexPath) as! LiveClnViewCell
                            if self.foryouDataVal?.count != 0{
                                let new = self.foryouDataVal?[indexPath.item - 1]
                                if new?.status == "Live"{
                                    live.layer.cornerRadius = 10
                                    live.ImgLive.layer.cornerRadius = 10
                                    live.ViewRating.layer.cornerRadius = live.ViewRating.frame.height/2
                                    live.ViewFollowers.layer.cornerRadius = live.ViewFollowers.frame.height/2
                                    live.ImgLiveHeight.constant = liveImgHeight
                                    live.ImgLiveWidth.constant = liveImgWidth
                                    if let thumbStr = new?.cover_path,let thumbUrl = URL(string: thumbStr){
                                        live.ImgLive.sd_setImage(with: thumbUrl, placeholderImage: nil)
                                    }
                                    live.LblProfileName.text = new?.title
                                    live.LblFollowers.text = "\(new?.total_likes ?? 0)"
                                    live.LblRating.text = "\(new?.total_audience ?? 0)"
                                }
                            }
                            
                            return live
                        case 1:
                            let live = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveClnCell", for: indexPath) as! LiveClnViewCell
                            live.layer.cornerRadius = 10
                            live.ImgLive.layer.cornerRadius = 10
                            live.ViewRating.layer.cornerRadius = live.ViewRating.frame.height/2
                            live.ViewFollowers.layer.cornerRadius = live.ViewFollowers.frame.height/2
                            live.ImgLiveHeight.constant = liveImgHeight
                            live.ImgLiveWidth.constant = liveImgWidth
                            let new = self.featuredDataVal?[indexPath.item - 1]
                            if let thumbStr = new?.cover_path,let thumbUrl = URL(string: thumbStr){
                                live.ImgLive.sd_setImage(with: thumbUrl, placeholderImage: nil)
                            }
                            live.LblProfileName.text = new?.title
                            live.LblFollowers.text = "\(new?.total_likes ?? 0)"
                            live.LblRating.text = "\(new?.total_audience ?? 0)"
                            return live
                        case 2:
                            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearbyCVCell", for: indexPath) as! NearbyCVCell
                            let nearby = nearByUserVal?[indexPath.item - 1]
                            cell.idLbl.text = "ID : \(nearby?.bellalive_id ?? "")"
                            if let avatar = nearby?.avatar,let thumbUrl = URL(string: avatar){
                                cell.profileImg.sd_setImage(with: thumbUrl, placeholderImage: nil)
                            }
                            cell.profileImg.layer.borderWidth = 2.0
                            cell.profileImg.layer.borderColor = generateRandomColor().cgColor
                            cell.giftPoint.text = "\(nearby?.total_bella_points ?? 0)"
                            if let fName = nearby?.first_name, let lName = nearby?.last_name{
                                cell.nameLbl.text = fName + " " + lName
                            }
                            cell.addBtn.tag = indexPath.item - 1
                            cell.addBtn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
                            return cell
                        case 3:
                            let live = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveClnCell", for: indexPath) as! LiveClnViewCell
                            live.layer.cornerRadius = 10
                            live.ImgLive.layer.cornerRadius = 10
                            live.ViewRating.layer.cornerRadius = live.ViewRating.frame.height/2
                            live.ViewFollowers.layer.cornerRadius = live.ViewFollowers.frame.height/2
                            live.ImgLiveHeight.constant = liveImgHeight
                            live.ImgLiveWidth.constant = liveImgWidth
                            let new = self.newestDataVal?[indexPath.item - 1]
                            if let thumbStr = new?.cover_path,let thumbUrl = URL(string: thumbStr){
                                live.ImgLive.sd_setImage(with: thumbUrl, placeholderImage: nil)
                            }
                            live.LblProfileName.text = new?.title
                            live.LblFollowers.text = "\(new?.total_likes ?? 0)"
                            live.LblRating.text = "\(new?.total_audience ?? 0)"
                            return live
                        default: break
                    }
                    
                }
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == MainClnView{
            print("Main Cln View")
            selectTitle = indexPath.item
            self.LiveClnView.reloadData()
        }else{
            if collectionView.tag == 040{
                print("ScrollCell")
            }else{
                if indexPath.item == 0{
                    print("0th item")
                }else{
                    switch selectTitle {
                    case 0:
                        if foryouDataVal?.count != 0{
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = storyboard.instantiateViewController(withIdentifier: "StreamingScreenID") as! StreamingScreen
                            rootVC.selectCell = indexPath.item - 1
                            rootVC.selectTitle = 0
                            rootVC.avatar = foryouDataVal?[indexPath.item - 1].user?.avatar ?? ""
                            rootVC.bellailiveID = foryouDataVal?[indexPath.item - 1].user?.bellalive_id ?? ""
                            rootVC.userName = foryouDataVal?[indexPath.item - 1].user?.name ?? ""
                            rootVC.userID = foryouDataVal?[indexPath.item - 1].user_id ?? 0
                            rootVC.streamID = foryouDataVal?[indexPath.item - 1].stream_id ?? ""
                            rootVC.modalPresentationStyle = .fullScreen
                            self.navigationController?.pushViewController(rootVC, animated: true)
                        }
                    case 1:
                        if featuredDataVal?.count != 0{
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = storyboard.instantiateViewController(withIdentifier: "StreamingScreenID") as! StreamingScreen
                            rootVC.selectCell = indexPath.item - 1
                            rootVC.selectTitle = 1
                            rootVC.avatar = featuredDataVal?[indexPath.item - 1].user?.avatar ?? ""
                            rootVC.bellailiveID = featuredDataVal?[indexPath.item - 1].user?.bellalive_id ?? ""
                            rootVC.userName = featuredDataVal?[indexPath.item - 1].user?.name ?? ""
                            rootVC.userID = featuredDataVal?[indexPath.item - 1].user_id ?? 0
                            rootVC.streamID = featuredDataVal?[indexPath.item - 1].stream_id ?? ""
                            rootVC.modalPresentationStyle = .fullScreen
                            self.navigationController?.pushViewController(rootVC, animated: true)
                        }
                    case 3:
                        if newestDataVal?.count != 0{
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let rootVC = storyboard.instantiateViewController(withIdentifier: "StreamingScreenID") as! StreamingScreen
                            rootVC.selectCell = indexPath.item - 1
                            rootVC.selectTitle = 2
                            rootVC.avatar = newestDataVal?[indexPath.item - 1].user?.avatar ?? ""
                            rootVC.bellailiveID = newestDataVal?[indexPath.item - 1].user?.bellalive_id ?? ""
                            rootVC.userName = newestDataVal?[indexPath.item - 1].user?.name ?? ""
                            rootVC.userID = newestDataVal?[indexPath.item - 1].user_id ?? 0
                            rootVC.streamID = newestDataVal?[indexPath.item - 1].stream_id ?? ""
                            rootVC.modalPresentationStyle = .fullScreen
                            self.navigationController?.pushViewController(rootVC, animated: true)
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == MainClnView{
            let maincell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainClnCell", for: indexPath) as! MainClnViewCell
            let width = maincell.LblTitle.intrinsicContentSize.width
            return CGSize(width: width, height: 35)
        }else{
            if collectionView.tag == 040{
                return  CGSize(width: collectionView.frame.width, height: 160)
            }else{
                if indexPath.item == 0{
                    return CGSize(width: collectionView.frame.width, height: 160)
                }else{
                    if selectTitle == 2{
                        return CGSize(width: collectionView.frame.width, height: 70)
                    }else{
                        let size = (collectionView.frame.size.width/2) - 10
                        liveImgWidth = size
                        liveImgHeight = 160
                        return CGSize(width: size, height: liveImgHeight)
                    }
                    
                }
            }
        }
    }
}


import Foundation

// MARK: - Message
struct FollowingModel: Codable {
    let status, success, error : String?
    let code : Int?
}

