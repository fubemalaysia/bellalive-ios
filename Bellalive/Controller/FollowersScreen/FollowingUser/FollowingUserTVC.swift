//
//  FollowingUserTVC.swift
//  Bellalive
//
//  Created by apple on 16/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit
import Foundation
class FollowingUserTVC: UITableViewCell {
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var colloectioview: UICollectionView!{
        didSet{
            colloectioview.delegate = self
            colloectioview.dataSource = self
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colloectioview.register(UINib(nibName:"FollowingUserCVC", bundle: nil), forCellWithReuseIdentifier: "FollowingUserCVC")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension FollowingUserTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Appcontext.shared.followingUserList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowingUserCVC", for: indexPath) as! FollowingUserCVC
        cell.bgView.backgroundColor = generateRandomColor()
        if let image = Appcontext.shared.followingUserList[indexPath.item].avatar{
            let imgUrl = URL(string: image)
            cell.imgView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
        }
        cell.userNameLbl.text = Appcontext.shared.followingUserList[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let topViewController = UIViewController()
//        topViewController = BLTopviewController.topViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileLiveUserScreenID") as! ProfileLiveUserScreen
        rootVC.guestUserId = Appcontext.shared.followingUserList[indexPath.item].id ?? 0
        rootVC.isFromVC = "Following"
        rootVC.modalPresentationStyle = .overFullScreen
        self.window?.rootViewController?.present(rootVC, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
