//
//  StreamingTblViewCell.swift
//  Bellalive
//
//  Created by APPLE on 27/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

protocol handleStreamingCell: class{
    func profile(_ cell: StreamingTblViewCell,index:Int)
    func sendMessage(_ cell: StreamingTblViewCell,index:Int)
    func gift(_ cell: StreamingTblViewCell,index:Int)
    func share(_ cell: StreamingTblViewCell,index:Int)
    func close(_ cell: StreamingTblViewCell,index:Int)
}
class StreamingTblViewCell: UITableViewCell{
    var selectedIndex: Int!
    weak var delegateStreaming : handleStreamingCell?
    @IBOutlet weak var ImgTobeHidden: UIImageView!
    @IBOutlet weak var VideoPlayerView: AVPlayerClass!
    
    @IBOutlet weak var ViewFloatingBottom: NSLayoutConstraint!
    @IBOutlet weak var TblBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var ViewFloating: Floater!
    @IBOutlet weak var TblViewLiveStreaming: UITableView!
    @IBOutlet weak var BtnCloseOutlet: UIButton!
    @IBOutlet weak var ImgBronzeCrown: UIImageView!
    @IBOutlet weak var ImgBronzeProfilePic: UIImageView!
    @IBOutlet weak var ImgSilverCrown: UIImageView!
    @IBOutlet weak var ImgSilverProfilePic: UIImageView!
    @IBOutlet weak var ImgGoldCrown: UIImageView!
    @IBOutlet weak var ImgGoldProfilePic: UIImageView!
    @IBOutlet weak var ViewPoints: UIView!
    @IBOutlet weak var ViewArrow: UIView!
    @IBOutlet weak var LblPoints: UILabel!
    @IBOutlet weak var LblFollowingRating: UILabel!
    @IBOutlet weak var LblProfileName: UILabel!
    @IBOutlet weak var ViewProfileDetails: UIView!
    @IBOutlet weak var ImgProfilePic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        BtnCloseOutlet.layer.cornerRadius = BtnCloseOutlet.frame.height/2
        ViewProfileDetails.layer.cornerRadius = ViewProfileDetails.frame.height/2
        ViewArrow.layer.cornerRadius = ViewArrow.frame.height/2
        ViewPoints.layer.cornerRadius = ViewPoints.frame.height/2
        ImgProfilePic.layer.cornerRadius = ImgProfilePic.frame.height/2
        shapeView()
        handleTap()
        // Initialization code
    }
    @IBAction func BtnProfileDetails(_ sender: UIButton) {
        if let ind = selectedIndex{
            delegateStreaming?.profile(self, index: ind)
        }
    }
    @IBAction func BtnClose(_ sender: UIButton) {
        if let ind = selectedIndex{
            delegateStreaming?.close(self, index: ind)
        }
    }
    @IBAction func BtnChat(_ sender: UIButton) {
        if let ind = selectedIndex{
            delegateStreaming?.sendMessage(self, index: ind)
        }
    }
    @IBAction func BtnShare(_ sender: UIButton) {
        if let ind = selectedIndex{
            delegateStreaming?.share(self, index: ind)
        }
    }
    @IBAction func BtnSendGift(_ sender: UIButton) {
        if let ind = selectedIndex{
            delegateStreaming?.gift(self, index: ind)
        }
    }
    
    func shapeView(){
        ImgGoldProfilePic.layer.cornerRadius = ImgGoldProfilePic.frame.height/2
        ImgSilverProfilePic.layer.cornerRadius = ImgSilverProfilePic.frame.height/2
        ImgBronzeProfilePic.layer.cornerRadius = ImgBronzeProfilePic.frame.height/2
        ImgGoldProfilePic.layer.borderWidth = 3
        ImgGoldProfilePic.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.6823529412, blue: 0.05098039216, alpha: 1)
        ImgSilverProfilePic.layer.borderWidth = 2
        ImgSilverProfilePic.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.9568627451, blue: 0.9960784314, alpha: 1)
        ImgBronzeProfilePic.layer.borderWidth = 2
        ImgBronzeProfilePic.layer.borderColor = #colorLiteral(red: 0.9725490196, green: 0.4196078431, blue: 0, alpha: 1)
        ImgGoldCrown.image = ImgGoldCrown.image?.rotate(radians: -26)
        ImgSilverCrown.image = ImgSilverCrown.image?.rotate(radians: -26)
        ImgBronzeCrown.image = ImgBronzeCrown.image?.rotate(radians: -26)
    }
    
    func handleTap() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (_) in
            UIViewController().generateAnimatedViews(view: self.ViewFloating)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
extension UIViewController{
    func generateAnimatedViews(view:Floater) {
        let img = #imageLiteral(resourceName: "heart1")
        let image = drand48() > 0.5 ? img : img
        view.imageView = UIImageView(image: image)
        view.imageView.tintColor = .random()
        let dimension = 30 + drand48() * 10
        view.imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath(view: view).cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.delegate = LayerRemover()
        animation.setValue(view.imageView, forKey: "imageTag")
        view.imageView.layer.add(animation, forKey: nil)
        view.addSubview(view.imageView)
    }
}
