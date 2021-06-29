//
//  FollowingLiveTVC.swift
//  Bellalive
//
//  Created by apple on 16/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class FollowingLiveTVC: UITableViewCell {

    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var collectioview: UICollectionView!{
        didSet{
            collectioview.delegate = self
            collectioview.dataSource = self
        }
    }
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectioview.register(UINib(nibName:"FollowingLiveCVC", bundle: nil), forCellWithReuseIdentifier: "FollowingLiveCVC")
        //collectioview.register(FollowingLiveCVC.self, forCellWithReuseIdentifier: "FollowingLiveCVC")
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.superview?.layoutIfNeeded()
        return collectioview.contentSize
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension FollowingLiveTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Appcontext.shared.followingStreamList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowingLiveCVC", for: indexPath) as! FollowingLiveCVC
        let live = Appcontext.shared.followingStreamList[indexPath.item]
        if let image = live.coverPath{
            let imgUrl = URL(string: image)
            cell.imgView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
        }
        cell.likeCountLbl.text = "\(live.totalLikes ?? 0)"
        cell.viewCountLbl.text = "\(live.totalAudience ?? 0)"
        cell.thumbLbl.text = live.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let streamDict:[String: Any] = ["followingStreamList": Appcontext.shared.followingStreamList[indexPath.item]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "BLVideoScreenStream_Notification"), object: nil, userInfo: streamDict)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width/2)
        let width = size
        let height = width
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
