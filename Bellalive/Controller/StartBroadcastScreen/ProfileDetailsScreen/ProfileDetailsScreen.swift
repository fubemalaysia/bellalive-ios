//
//  ProfileDetailsScreen.swift
//  Bellalive
//
//  Created by APPLE on 27/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class ProfileDetailsScreen: UIViewController {

    @IBOutlet weak var LblReceived: UILabel!
    @IBOutlet weak var LblSend: UILabel!
    @IBOutlet weak var LblFollowing: UILabel!
    @IBOutlet weak var LblFans: UILabel!
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
    @IBOutlet weak var ViewDetails: UIView!
    @IBOutlet weak var ImgProfilePic: UIImageView!
    @IBOutlet weak var levelImage: UIImageView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var genderImg: UIImageView!
    
    var userDetail : GuestUserDataClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handlePress))
        tap.numberOfTapsRequired = 1
        ImgProfilePic.addGestureRecognizer(tap)
        let tapview = UITapGestureRecognizer(target: self, action: #selector(handlePressView))
        tapview.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapview)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        ImgProfilePic.layer.cornerRadius = ImgProfilePic.frame.height/2
        ImgProfilePic.layer.borderWidth = 2
        
        ViewDetails.layer.cornerRadius = 10
        ViewDetails.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        ViewRisingStar.layer.cornerRadius = ViewRisingStar.frame.height/2
        genderImg.layer.cornerRadius = genderImg.frame.height/2
        genderView.layer.cornerRadius = genderView.frame.height/2
        ViewRating.layer.cornerRadius = ViewRating.frame.height/2
        ViewZodiacSign.layer.cornerRadius = ViewZodiacSign.frame.height/2
        ViewCountry.layer.cornerRadius = ViewCountry.frame.height/2
    }
    
    private func initialLoads(){
        let  imgUrl = URL(string: userDetail?.avatar ?? "")
        ImgProfilePic.sd_setImage(with: imgUrl, placeholderImage: nil)
        LblFans.text = "\(userDetail?.fans ?? 0)"
        if let fname = userDetail?.firstName,let lName = userDetail?.lastName{
            LblProfileName.text = fname + " " + lName
        }
        LblSend.text = "\(userDetail?.totalSendPoints ?? 0)"
        LblCountry.text = userDetail?.country?.name
        LblZodiacSign.text = userDetail?.gender
        LblFollowing.text = "\(userDetail?.following ?? 0)"
        LblReceived.text = "\(userDetail?.totalReceivePoints ?? 0)"
        LblRating.text = userDetail?.level?.code
        LblRisingStar.text = userDetail?.level?.name
        
        if userDetail?.gender == "Girl"{
            genderImg.image = UIImage(named: "female")
        }else{
            genderImg.image = UIImage(named: "men")
        }
        
        if userDetail?.level?.name.lowercased() == "gold"{
            levelImage.image = #imageLiteral(resourceName: "Gold Ranking")
            ImgProfilePic.layer.borderColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)
        }else if userDetail?.level?.name.lowercased() == "silver"{
            levelImage.image = #imageLiteral(resourceName: "Silver Ranking")
            ImgProfilePic.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        }else if userDetail?.level?.name.lowercased() == "orange"{
            levelImage.image = #imageLiteral(resourceName: "Bronze Ranking")
            ImgProfilePic.layer.borderColor = #colorLiteral(red: 0.8039215686, green: 0.4980392157, blue: 0.1960784314, alpha: 1)
        }else{
            levelImage.isHidden = true
            ImgProfilePic.layer.borderColor = generateRandomColor().cgColor
        }
        
        LblProfileID.text = "ID : \(userDetail?.bellaliveId ?? "")"
        
    }
    
    
    @IBAction func BtnHome(_ sender: UIButton) {
        let userId = UserDefaults.standard.integer(forKey: "UserID")
        
        if userId == userDetail?.id{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileScreen") as! ProfileScreen
            rootVC.isFrom = "profile"
            rootVC.modalPresentationStyle = .overFullScreen
            self.present(rootVC, animated: true, completion: nil)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileLiveUserScreenID") as! ProfileLiveUserScreen
            rootVC.userDetails = userDetail
            rootVC.modalPresentationStyle = .overFullScreen
            self.present(rootVC, animated: true, completion: nil)
        }
    }
    @IBAction func BtnMessage(_ sender: UIButton) {
        print("txt")
    }
    @IBAction func BtnAdd(_ sender: UIButton) {
        let param = ["user_id" : userDetail?.id ?? 0,
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
    
    @objc func handlePress(){
        let userId = UserDefaults.standard.integer(forKey: "UserID")
        
        if userId == userDetail?.id{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileScreen") as! ProfileScreen
            rootVC.isFrom = "profile"
            rootVC.modalPresentationStyle = .overFullScreen
            self.present(rootVC, animated: true, completion: nil)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileLiveUserScreenID") as! ProfileLiveUserScreen
            rootVC.userDetails = userDetail
            rootVC.modalPresentationStyle = .overFullScreen
            self.present(rootVC, animated: true, completion: nil)
        }
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileLiveUserScreenID") as! ProfileLiveUserScreen
//        rootVC.userDetails = userDetail
//        rootVC.modalPresentationStyle = .overFullScreen
//        self.present(rootVC, animated: true, completion: nil)
    }
    @objc func handlePressView(){
        self.dismiss(animated: true, completion: nil)
    }
}
