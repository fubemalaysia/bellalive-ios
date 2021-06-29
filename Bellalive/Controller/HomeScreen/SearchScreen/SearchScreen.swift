//
//  SearchScreen.swift
//  Bellalive
//
//  Created by APPLE on 23/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

enum search : String{
    case User
    case Video
}

class SearchScreen: UIViewController {
    var ViewHeightcountry: CGFloat!
    var ViewWidthcountry: CGFloat!
    var ViewHeightlive: CGFloat!
    var ViewWidthlive: CGFloat!
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var BtnSearchOutlet: UIButton!
    @IBOutlet weak var SearchClnView: UICollectionView!{
        didSet{
            SearchClnView.delegate = self
            SearchClnView.dataSource = self
        }
    }
    @IBOutlet weak var tblView: UITableView!{
        didSet{
            tblView.delegate = self
            tblView.dataSource = self
        }
    }
    @IBOutlet weak var SearchBar: UISearchBar!
    
    
    let reusableViewID = "SearchReuseCell"
    let countryCellID = "SearchCountryClnCell"
    let liveCellID = "SearchLiveClnCell"
    var searchType = ["All","Users","Live","Videos"]
    var headerArray = ["Users","Live","Video"]
    var searchData = [SearchData](), searchVideoData = [SearchVideoDataDatum]()
    var searching = String(), tabPosition = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollectionView.reloadData()
        mainCollectionView.selectItem(at: IndexPath(row: tabPosition, section: 0), animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
        searchBarSetUp()
        
        mainCollectionView.isHidden = true
        tblView.isHidden = true
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.videoNotification(_:)), name: NSNotification.Name(rawValue: "SearchVideo_Notification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.streamNotification(_:)), name: NSNotification.Name(rawValue: "SearchLive_Notification"), object: nil)
    }
    @objc func videoNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            
            var searchUserVideo : SearchVideoDataDatum?
            
            if let id = dict["searchUserVideo"] as? SearchVideoDataDatum{
                searchUserVideo = id
            } else {
                searchUserVideo = nil
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "StreamingScreenID") as! StreamingScreen
            rootVC.avatar = searchUserVideo?.user?.avatar ?? ""
            rootVC.bellailiveID = searchUserVideo?.user?.bellaliveId ?? ""
            rootVC.userName = searchUserVideo?.user?.name ?? ""
            rootVC.userID = searchUserVideo?.userId ?? 0
            rootVC.streamID = searchUserVideo?.streamId ?? ""
            rootVC.isFromVC = "search"
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
            
            NotificationCenter.default.removeObserver("SearchVideo_Notification")
        }
    }
    
    
    @objc func streamNotification(_ notification: NSNotification) {
        if let dict = notification.userInfo as NSDictionary? {
            
            var searchUserVideo : SearchVideoDataDatum?
            
            if let id = dict["searchUserVideo"] as? SearchVideoDataDatum{
                searchUserVideo = id
            } else {
                searchUserVideo = nil
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "StreamingScreenID") as! StreamingScreen
            rootVC.avatar = searchUserVideo?.user?.avatar ?? ""
            rootVC.bellailiveID = searchUserVideo?.user?.bellaliveId ?? ""
            rootVC.userName = searchUserVideo?.user?.name ?? ""
            rootVC.userID = searchUserVideo?.userId ?? 0
            rootVC.streamID = searchUserVideo?.streamId ?? ""
            rootVC.isFromVC = "search"
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
            
            NotificationCenter.default.removeObserver("SearchLive_Notification")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainCollectionView.reloadData()
        mainCollectionView.selectItem(at: IndexPath(row: tabPosition, section: 0), animated: true, scrollPosition: UICollectionView.ScrollPosition.left)
    }
    
    @IBAction func BtnClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func BtnSearch(_ sender: UIButton) {
        if SearchBar.text == ""{
            createAlertBox(title: App.Name, message: "Enter Users/Live/Video name", buttonName: "OK")
        }else{
            tblView.isHidden = false
            mainCollectionView.isHidden = false
            apiCallforSearchUser(type: "1")
            apiCallforSearchVideo(type: "2")
        }
        
        searching = search.Video.rawValue
    }
    
    private func searchBarSetUp(){
        SearchBar.changeSearchBarColor(color: .clear, size: CGSize(width: SearchBar.frame.size.width, height: 30))
        if #available(iOS 13.0, *) {
            SearchBar.searchTextField.leftView?.tintColor = .white
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            SearchBar.searchTextField.font = UIFont.systemFont(ofSize: 13)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            SearchBar.searchTextField.textColor = .white
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            SearchBar.searchTextField.attributedPlaceholder = NSAttributedString(string:"Find Users/Live/Video", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        } else {
            // Fallback on earlier versions
        }
        SearchBar.layer.borderWidth = 1
        SearchBar.layer.borderColor = UIColor.white.cgColor
        SearchBar.layer.cornerRadius = 15
    }
    
    
    private func apiCallforSearchUser(type : String){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .search, pass: "?term=\(SearchBar.text ?? "")&type=\(type)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let search = try JSONDecoder().decode(SearchModel.self, from: response)
                weakself.searchData = search.data
                Appcontext.shared.searchUserData = search.data
                if weakself.searchData.count == 0{
                    weakself.SearchClnView.setEmptyMessage("No Data Found")
                }else{
                    weakself.SearchClnView.restore()
                }
                
                weakself.SearchClnView.reloadData()
                weakself.tblView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
        
    }
    private func apiCallforSearchVideo(type : String){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeaderUrl(Api: .search, pass: "?term=\(SearchBar.text ?? " ")&type=\(type)", token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let searchVideo = try JSONDecoder().decode(SearchVideoDataModel.self, from: response)
                if let data = searchVideo.data{
                    weakself.searchVideoData = data
                }
                
                Appcontext.shared.searchVideoData = weakself.searchVideoData.filter({(value) -> Bool in
                    return value.status?.lowercased() != "live"
                })
                print(Appcontext.shared.searchVideoData)
                Appcontext.shared.searchLiveData = weakself.searchVideoData.filter({(value) -> Bool in
                    return value.status?.lowercased() == "live"
                })
                print(Appcontext.shared.searchLiveData)
                if weakself.searchVideoData.count == 0{
                    weakself.SearchClnView.setEmptyMessage("No Data Found")
                }else{
                    weakself.SearchClnView.restore()
                }
                
                weakself.SearchClnView.reloadData()
                weakself.tblView.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
        
    }
}
extension SearchScreen: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainCollectionView{
            return searchType.count
        }else{
            switch tabPosition{
            case 1: return (self.searchData.count)
            case 2: return (Appcontext.shared.searchLiveData.count)
            case 3: return (Appcontext.shared.searchVideoData.count)
            default:
                return 0
            }
           
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchMainCollectionCVC", for: indexPath) as! SearchMainCollectionCVC
            cell.searchLbl.text = searchType[indexPath.item]
            cell.selectedBackgroundView = UIView(frame: cell.searchLbl.bounds)
            cell.selectedBackgroundView?.backgroundColor = .white
            cell.layer.cornerRadius = cell.frame.height / 2
            cell.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            cell.layer.borderWidth = 1.0
            
            return cell
        }else{
            switch tabPosition {
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchUserCVC", for: indexPath) as! SearchUserCVC
                let search = searchData[indexPath.item]
                let imgUrl = URL(string: search.avatar)
                cell.imgView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
                cell.layoutIfNeeded()
                cell.bgView.backgroundColor = generateRandomColor()
                cell.bellaliveIdLbl.text = "Bellalive ID : \(search.bellaliveID)"
                cell.userNameLbl.text = search.firstName + " " + search.lastName
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchLiveVideoCVC", for: indexPath) as! SearchLiveVideoCVC
                let searchLive = Appcontext.shared.searchLiveData[indexPath.item]
                
                let imgUrl = URL(string: searchLive.coverPath ?? "")
                cell.imgView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
                cell.likeCountLbl.text = "\(searchLive.totalLikes ?? 0)"
                cell.viewCountLbl.text = "\(searchLive.totalAudience ?? 0 )"
                cell.thumbLbl.text = searchLive.title
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchLiveVideoCVC", for: indexPath) as! SearchLiveVideoCVC
                let searchVideo = Appcontext.shared.searchVideoData[indexPath.item]
                let imgUrl = URL(string: searchVideo.coverPath ?? "")
                cell.imgView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
                cell.likeCountLbl.text = "\(searchVideo.totalLikes ?? 0)"
                cell.viewCountLbl.text = "\(searchVideo.totalAudience ?? 0 )"
                cell.thumbLbl.text = searchVideo.title
                return cell
            default:
                break
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainCollectionView{
            tabPosition = indexPath.item
            if tabPosition == 0{
                SearchClnView.isHidden = true
                tblView.isHidden = false
            }else{
                SearchClnView.isHidden = false
                tblView.isHidden = true
                SearchClnView.reloadData()
            }
            print(indexPath.item)
        }else{
            switch tabPosition {
            case 1:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileLiveUserScreenID") as! ProfileLiveUserScreen
                rootVC.isFromVC = "search"
                rootVC.searchUser = searchData[indexPath.item]
                rootVC.modalPresentationStyle = .overFullScreen
                self.present(rootVC, animated: true, completion: nil)
            case 2:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "StreamingScreenID") as! StreamingScreen
                rootVC.selectCell = indexPath.item
                rootVC.isFromVC = "guestUserVideo"
                rootVC.avatar = Appcontext.shared.searchLiveData[indexPath.item].user?.avatar ?? ""
                rootVC.bellailiveID = Appcontext.shared.searchLiveData[indexPath.item].user?.bellaliveId ?? ""
                rootVC.userName = Appcontext.shared.searchLiveData[indexPath.item].user?.name ?? ""
                rootVC.userID = Appcontext.shared.searchLiveData[indexPath.item].userId ?? 0
                rootVC.streamID = Appcontext.shared.searchLiveData[indexPath.item].streamId ?? ""
                rootVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(rootVC, animated: true)
            case 3:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let rootVC = storyboard.instantiateViewController(withIdentifier: "StreamingScreenID") as! StreamingScreen
                rootVC.selectCell = indexPath.item
                rootVC.isFromVC = "guestUserVideo"
                rootVC.avatar = Appcontext.shared.searchVideoData[indexPath.item].user?.avatar ?? ""
                rootVC.bellailiveID = Appcontext.shared.searchVideoData[indexPath.item].user?.bellaliveId ?? ""
                rootVC.userName = Appcontext.shared.searchVideoData[indexPath.item].user?.name ?? ""
                rootVC.userID = Appcontext.shared.searchVideoData[indexPath.item].userId ?? 0
                rootVC.streamID = Appcontext.shared.searchVideoData[indexPath.item].streamId ?? ""
                rootVC.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(rootVC, animated: true)
            default:
                break
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainCollectionView{
            let width = collectionView.frame.size.width / 4
            return CGSize(width: width, height: 30)
        }else{
            if tabPosition == 1{
                return CGSize(width: collectionView.frame.width, height: 60)
            }else{
                let size = (collectionView.frame.size.width/2.3)
                let width = size
                let height = width
                return CGSize(width: width, height: height)
            }
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension UISearchBar {
    func changeSearchBarColor(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(self.frame.size)
        color.setFill()
        UIBezierPath(rect: self.frame).fill()
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.setSearchFieldBackgroundImage(bgImage, for: .normal)
    }
}



extension SearchScreen : UITableViewDelegate,UITableViewDataSource{
    
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
            let cell = Bundle.main.loadNibNamed("SearchUserTVC", owner: self, options: nil)?.first as! SearchUserTVC
            cell.collectionView.reloadData()
            return cell
        }else if indexPath.section == 1{
            let cell = Bundle.main.loadNibNamed("SearchLiveTVC", owner: self, options: nil)?.first as! SearchLiveTVC
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectionview.reloadData()
            cell.collectionviewHeight.constant = cell.collectionview.collectionViewLayout.collectionViewContentSize.height
            return cell
        }else if indexPath.section == 2{
            let cell = Bundle.main.loadNibNamed("SearchVideoTVC", owner: self, options: nil)?.first as! SearchVideoTVC
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.collectionview.reloadData()
            cell.collectionViewHeight.constant = cell.collectionview.collectionViewLayout.collectionViewContentSize.height
           
            return cell
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
           return searchData.count > 0 ? 120 : 0
        }else if indexPath.section == 1{
            return searchVideoData.count > 0 ? UITableView.automaticDimension : 0
        }else if indexPath.section == 2{
            return searchVideoData.count > 0 ? UITableView.automaticDimension : 0
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
           return searchData.count > 0 ? 95 : 0
        }else if indexPath.section == 1{
            return searchVideoData.count > 0 ? 200 : 0
        }else if indexPath.section == 2{
            return searchVideoData.count > 0 ? 200 : 0
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
           return searchData.count > 0 ? 30 : 0
        }else if section == 1{
            return searchVideoData.count > 0 ? 30 : 0
        }else if section == 2{
            return searchVideoData.count > 0 ? 30 : 0
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}
