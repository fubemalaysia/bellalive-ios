//
//  ProfileScreen.swift
//  Bellalive
//
//  Created by APPLE on 21/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Options{
    let Image: UIImage
    let Title: String
    let Level: String?
    init(image:UIImage,title:String,level:String?) {
        self.Image = image
        self.Title = title
        self.Level = level
    }
}
class ProfileScreen: UIViewController {
    let optionsArr : [Options] = [Options(image: #imageLiteral(resourceName: "Account(setting)"), title: "Account", level: nil),Options(image: #imageLiteral(resourceName: "VJ Centre(setting)"), title: "VJ Centre", level: nil),Options(image: #imageLiteral(resourceName: "Level(setting)"), title: "Level", level: "LV 1"),Options(image: #imageLiteral(resourceName: "Legion of Badge(setting)"), title: "Legion of Fan’s Badge", level: nil),Options(image: #imageLiteral(resourceName: "Video(setting)"), title: "Videos", level: nil),Options(image: #imageLiteral(resourceName: "setting(setting)"), title: "Setting", level: nil)]
    @IBOutlet weak var TblViewProfile: UITableView!
    @IBOutlet weak var LblFansCount: UILabel!
    @IBOutlet weak var LblFollowingCount: UILabel!
    @IBOutlet weak var LblRating: UILabel!
    @IBOutlet weak var ImgViewRating: UIImageView!
    @IBOutlet weak var ViewRating: UIView!
    @IBOutlet weak var LblBellaliveID: UILabel!
    @IBOutlet weak var LblProfileName: UILabel!
    @IBOutlet weak var BtnPersonalCenterOutlet: UIButton!
    @IBOutlet weak var ImgViewProfilePic: UIImageView!
    @IBOutlet weak var closeBtn : UIButton!
    @IBOutlet weak var profileImgBtn: UIButton!
    @IBOutlet weak var bgBlurImage: UIImageView!
    
    var userProfileData : UserProfileData?
    var isFrom = String()
    var imagePicker = UIImagePickerController()
    var selectedImage = false
    var imageData = Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFrom == "profile"{
            closeBtn.isHidden = false
        }else{
            closeBtn.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        apicallforGetUserDetails()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.BtnPersonalCenterOutlet.layer.cornerRadius = self.BtnPersonalCenterOutlet.frame.height / 2
            self.ViewRating.layer.cornerRadius = self.ViewRating.frame.height / 2
            self.ImgViewProfilePic.layer.cornerRadius = self.ImgViewProfilePic.frame.height / 2
            self.profileImgBtn.layer.cornerRadius = self.profileImgBtn.frame.height / 2
            self.ImgViewProfilePic.clipsToBounds = true
        }
        
    }
    @IBAction func BtnPersonalCenter(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "PersonalCenterVC") as! PersonalCenterVC
        controller.modalPresentationStyle = .overCurrentContext
        controller.image = userProfileData?.avatar ?? ""
        let navigationController =  UINavigationController(rootViewController: controller)
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.isNavigationBarHidden = true
        navigationController.isToolbarHidden = true
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func closeAction(_ sender: UIButton){
        dismiss(animated: true)
    }
    
    public func apicallforGetUserDetails(){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .profile,parameter: nil, token: token) {[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let userData = try JSONDecoder().decode(UserProfileModel.self, from: response)
                if let data = userData.data{
                    weakself.userProfileData = data
                    Appcontext.shared.user = data
                }
                UserDefaults.standard.set(userData.data?.id, forKey: "UserID")
                if let image = userData.data?.avatar{
                    let imgUrl = URL(string: image)
                    weakself.ImgViewProfilePic.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
                    weakself.bgBlurImage.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
                }
                if let fName = userData.data?.firstName, let lName = userData.data?.lastName{
                   weakself.LblProfileName.text = fName + " " + lName
                }
                weakself.LblBellaliveID.text = "ID : \(userData.data?.bellaliveId ?? "")"
                weakself.LblFansCount.text = "\(userData.data?.fans ?? 0)"
                weakself.LblFollowingCount.text = "\(userData.data?.following ?? 0)"
                NotificationCenter.default.post(name: Notification.Name("newRequest"), object: nil)
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    
    @IBAction func profileImageUpload(_ sender: UIButton) {
        upload()
    }
    
    func upload(){
        let optionMenu = UIAlertController(title: nil, message:nil, preferredStyle: .actionSheet)
        optionMenu.modalPresentationStyle = .popover
        
        // 2
        let takeNewPhoto = UIAlertAction(title: "Camera", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                self.imagePicker.delegate = self
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                let alertWarning = UIAlertView(title: "", message:"You don't have camera", delegate: nil, cancelButtonTitle:"OK")
                alertWarning.show()
            }
        })
        
        let selectPhoto = UIAlertAction(title:"Upload", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum){
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum;
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        // 4
        takeNewPhoto.setValue(UIColor(hex: "531B93"), forKey: "titleTextColor")
        selectPhoto.setValue(UIColor(hex: "531B93"), forKey: "titleTextColor")
        optionMenu.setTint(color: .black)
        optionMenu.addAction(takeNewPhoto)
        optionMenu.addAction(selectPhoto)
        optionMenu.addAction(cancelAction)
        
        if let presenter = optionMenu.popoverPresentationController {
            presenter.sourceView = ImgViewProfilePic;
            presenter.sourceRect = ImgViewProfilePic.bounds;
        }
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    private func apiCallforUploadProfilePic(imagedata : Data){
            let urlString = baseURL + Base.profileAvatarUpdate.rawValue
        
            guard let token = tokenID, tokenID != nil else{
                return
            }

            let headers = ["Authorization" : "Bearer " + token,
                             "Content-Type":"application/json",
                             "accept":"application/json",
                             "X-Requested-With":"XMLHttpRequest"]
        
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                 multipartFormData.append(imagedata, withName: "avatar", fileName: "picture", mimeType:"image/jpeg")
                
            }, usingThreshold: UInt64.init(), to: urlString, method: .post, headers: headers) { [weak self] (result) in
                 guard let weakself = self else { return }
                switch result {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        switch response.result{
                        case .success(let json):
                         if let statusCode = response.response?.statusCode{
                             if statusCode == 200{
                                let value = JSON(json)
                                print(value)
                                let image = value["data"]["avatar"].stringValue
                                print(image)
                                
                             }else{
                                 guard let dict = json as? [String: Any],
                                 let message = dict["message"] as? String else{
                                     return
                                 }
                                Toast.makeToast(message: message, in: weakself.view){}
                             }
                         }
                           
                        case .failure(let err):
                            Toast.makeToast(message: err.localizedDescription, in: weakself.view){}
                            print(err.localizedDescription)
                        }
                        
                    }
                    break
                case .failure(let error):
                    
    //                callback(nil, error as NSError)
                    print(error.localizedDescription )
                    
                }
            }
        }
    
    
    
    
    
    
    
}
extension ProfileScreen: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTblViewCell
        cell.ImgViewOptions.image = optionsArr[indexPath.row].Image
        cell.LblOptions.text = optionsArr[indexPath.row].Title
        cell.LblLevel.text = optionsArr[indexPath.row].Level
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row{
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "AccountScreenID") as! AccountScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 1:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "VJCentreScreenID") as! VJCentreScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "BLCustomerLevelVC") as! BLCustomerLevelVC
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 3:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "LegionScreenID") as! LegionScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 4:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "VideosScreenID") as! VideosScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        case 5:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "SettingsScreenID") as! SettingsScreen
            rootVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(rootVC, animated: true)
        default:
            break
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ProfileScreen:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let resultImage = info[.originalImage] as! UIImage
        ImgViewProfilePic.image = resultImage
        bgBlurImage.image = resultImage
        imageData = resultImage.jpegData(compressionQuality: 0.5)!
        selectedImage = true
        apiCallforUploadProfilePic(imagedata: imageData)
        print(imageData)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
