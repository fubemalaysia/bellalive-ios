//
//  SearchUserTVC.swift
//  Bellalive
//
//  Created by apple on 29/03/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class SearchUserTVC: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.superview?.layoutIfNeeded()
        return collectionView.contentSize
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName:"SearchUserClnCell", bundle: nil), forCellWithReuseIdentifier: "SearchUserClnCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension SearchUserTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Appcontext.shared.searchUserData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchUserClnCell", for: indexPath) as! SearchUserClnCell
        cell.bgView.backgroundColor = generateRandomColor()
        let image = Appcontext.shared.searchUserData[indexPath.item].avatar
        let imgUrl = URL(string: image)
        cell.imgView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
        
        cell.userNameLbl.text = Appcontext.shared.searchUserData[indexPath.item].firstName + " " + Appcontext.shared.searchUserData[indexPath.item].lastName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileLiveUserScreenID") as! ProfileLiveUserScreen
        rootVC.isFromVC = "search"
        rootVC.searchUser = Appcontext.shared.searchUserData[indexPath.item]
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
