//
//  ShareScreen.swift
//  Bellalive
//
//  Created by APPLE on 26/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

struct shareData{
    let image : UIImage
    let title : String
    init(image : UIImage,title : String) {
        self.image = image
        self.title = title
    }
}
class ShareScreen: UIViewController {
    let shareArray : [shareData] = [shareData(image: #imageLiteral(resourceName: "Frinds(Share)"), title: "Friends"),shareData(image: #imageLiteral(resourceName: "Facebook(Share)"), title: "Facebook"),shareData(image: #imageLiteral(resourceName: "Messenger(Share)"), title: "Messenger"),shareData(image: #imageLiteral(resourceName: "Message(Share)"), title: "Message"),shareData(image: #imageLiteral(resourceName: "Email(Share)"), title: "Email")]
    var lblWidth : CGFloat!
    @IBOutlet weak var ViewShare: UIView!
    @IBOutlet weak var ShareClnView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewShare.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension ShareScreen: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shareArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareClnCell", for: indexPath) as! ShareClnViewCell
        cell.ImgShare.image = shareArray[indexPath.item].image
        cell.LblShare.text = shareArray[indexPath.item].title
        cell.LblWidth.constant = lblWidth
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        lblWidth = 80
        return CGSize(width: lblWidth, height: 100)
    }
}
