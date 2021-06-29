//
//  LiveStreamingScreen.swift
//  Bellalive
//
//  Created by APPLE on 25/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import ZegoExpressEngine

class LiveStreamingScreen: UIViewController,UITextFieldDelegate {
    let arrayData : [liveStreamData] = [liveStreamData(rating: 23, name: "Andrew", message: "followed this host", ratingColor: .green),liveStreamData(rating: 16, name: "Stell", message: "Do you have Facebook?", ratingColor: .purple),liveStreamData(rating: 45, name: "James Christensen", message: "liked this", ratingColor: .systemPink),liveStreamData(rating: 30, name: "Stella", message: "shared this live stream", ratingColor: .red)]
    var isKeyboardShowing : Bool = false
    var topSafeArea: CGFloat = 0
    var bottomSafeArea: CGFloat = 0
    
    @IBOutlet weak var vwLocalPreviewView: UIView!
    @IBOutlet weak var vwRemotePreviewView: UIView!
    @IBOutlet weak var imgGirl: UIImageView!
    
    @IBOutlet weak var ViewFloatingBottom: NSLayoutConstraint!
    @IBOutlet weak var TblBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var TxtFieldChat: UITextField!
    @IBOutlet weak var ViewTextField: UIView!
    @IBOutlet weak var ViewInsideMessage: UIView!
    @IBOutlet var ViewMessage: UIView!
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnCloseOutlet.layer.cornerRadius = BtnCloseOutlet.frame.height/2
        TxtFieldChat.delegate = self
        handleTap()
        ViewProfileDetails.layer.cornerRadius = ViewProfileDetails.frame.height/2
        ViewArrow.layer.cornerRadius = ViewArrow.frame.height/2
        ViewPoints.layer.cornerRadius = ViewPoints.frame.height/2
        ImgProfilePic.layer.cornerRadius = ImgProfilePic.frame.height/2
        shapeView()
        ViewMessage.layer.cornerRadius = 10
        ViewInsideMessage.layer.cornerRadius = 10
        ViewMessage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        ViewInsideMessage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
         ViewMessage.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            topSafeArea = view.safeAreaInsets.top
            bottomSafeArea = view.safeAreaInsets.bottom
        } else {
            topSafeArea = topLayoutGuide.length
            bottomSafeArea = bottomLayoutGuide.length
        }
        viewDisplayMessage(y:UIScreen.main.bounds.size.height - (ViewMessage.frame.height + bottomSafeArea))
        print("bottomSafeArea:",bottomSafeArea)
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
    @IBAction func BtnProfileDetails(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "ProfileDetailsScreenID") as! ProfileDetailsScreen
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    @IBAction func BtnClose(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "LiveEndScreenID") as! LiveEndScreen
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    @IBAction func BtnChat(_ sender: UIButton) {
        ViewMessage.isHidden = false
        TxtFieldChat.becomeFirstResponder()
    }
    @IBAction func BtnShare(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "ShareScreenID") as! ShareScreen
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    @IBAction func BtnSetting(_ sender: UIButton) {
    }
    @IBAction func BtnPK(_ sender: UIButton) {
    }
    @IBAction func BtnSendGift(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "GiftScreenID") as! GiftScreen
        rootVC.modalPresentationStyle = .overFullScreen
        self.present(rootVC, animated: true, completion: nil)
    }
    @IBAction func BtnSendMessage(_ sender: UIButton) {
        TxtFieldChat.resignFirstResponder()
        ViewMessage.isHidden = true
    }
    func viewDisplayMessage(y:CGFloat){
        ViewMessage.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.size.width, height: ViewMessage.frame.height)
        view.addSubview(ViewMessage)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            viewDisplayMessage(y: keyboardSize.height - (ViewMessage.frame.height + bottomSafeArea))
            print(self.ViewMessage.frame.origin.y)
//            self.ViewMessage.frame = CGRect(x: 0, y: (keyboardSize.height - (ViewMessage.frame.height + bottomSafeArea)), width: UIScreen.main.bounds.size.width, height: self.ViewMessage.frame.height)
            print(self.ViewMessage.frame.origin.y)
            TblBottomConstraint.constant =  (keyboardSize.height - bottomSafeArea)
            ViewFloatingBottom.constant = (keyboardSize.height - bottomSafeArea)
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completion) in
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if ViewMessage.frame.origin.y != 0 {
            viewDisplayMessage(y: (UIScreen.main.bounds.size.height - (self.ViewMessage.frame.height + bottomSafeArea)))
//            self.ViewMessage.frame = CGRect(x: 0, y: (UIScreen.main.bounds.size.height - (self.ViewMessage.frame.height + bottomSafeArea)), width: UIScreen.main.bounds.size.width, height: self.ViewMessage.frame.height)
            TblBottomConstraint.constant =  15
            ViewFloatingBottom.constant = 15
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completion) in
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func handleTap() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { (_) in
            self.generateAnimatedViews(view: self.ViewFloating)
        }
    }
}
extension LiveStreamingScreen: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveTblCell", for: indexPath) as! LiveStreamingTblViewCell
        let data = arrayData[indexPath.row]
        cell.LblMessage.text = data.message
        cell.LblUser.text = "\(data.name) : "
        cell.LblRating.text = "\(data.rating)"
        cell.ViewRating.backgroundColor = data.ratingColor
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
    

}
func customPath(view:Floater) -> UIBezierPath {
    let path = UIBezierPath()
    let randomYShift = 30 + drand48() * 40
    path.addLine(to: CGPoint(x: 80 + randomYShift, y: Double(view.frame.size.height)))
    path.move(to: CGPoint(x: 80 - randomYShift , y: Double(view.frame.size.height)))
    path.addLine(to: CGPoint(x: 80 - randomYShift, y: 0))
    return path
}
class Floater: UIView {
    static let shared = Floater()
    var imageView = UIImageView()
    override func draw(_ rect: CGRect) {
        let path = customPath(view: self)
        path.lineWidth = 3
    }
}

class LayerRemover: NSObject, CAAnimationDelegate {
   func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let imageView = anim.value(forKey: "imageTag") as? UIImageView{
            imageView.removeFromSuperview()
        }
    }
}

extension UIColor {
  static func random () -> UIColor {
    return UIColor(
      red: CGFloat.random(in: 0...1),
      green: CGFloat.random(in: 0...1),
      blue: CGFloat.random(in: 0...1),
      alpha: 1.0)
  }
}


extension LiveStreamingScreen:ZegoEventHandler{
    
    func createZegoExpressEngine(){
        let appID = 1773932842
        let appSign = "be97d346d5f683f68e41db399563a8a4b64561d7d52de5d735499f50ea8520c6"
        ZegoExpressEngine.createEngine(withAppID: UInt32(appID), appSign: appSign, isTestEnv: true, scenario: .general, eventHandler: self)
        
        let user : ZegoUser = ZegoUser(userID: "user1")
        ZegoExpressEngine.shared().loginRoom("room1", user: user)
        
        // Start publishing a stream
        ZegoExpressEngine.shared().startPublishingStream("stream1")
        
        // Set up the view for local preview and enable the preview with SDK's default view mode (AspectFill).
        ZegoExpressEngine.shared().startPreview(ZegoCanvas(view: self.vwLocalPreviewView))
        
        // Play a real-time stream
        ZegoExpressEngine.shared().startPlayingStream("stream1", canvas: ZegoCanvas(view: self.vwRemotePreviewView))
        
        // Stop publishing a stream
        ZegoExpressEngine.shared().stopPublishingStream()
        
        // Disable view for local preview
        ZegoExpressEngine.shared().stopPreview()
        
        // Stop playing a stream
        ZegoExpressEngine.shared().stopPlayingStream("stream1")
        
        // Log out from a room
        ZegoExpressEngine.shared().logoutRoom("room1")
        
        //Destroy a ZegoExpressEngine
        ZegoExpressEngine.destroy(nil)
        
        self.imgGirl.isHidden = true
    }
    func onRoomStateUpdate(_ state: ZegoRoomState, errorCode: Int32, extendedData: [AnyHashable : Any]?, roomID: String) {
        // Implement event callbacks as needed
    }
    // Callback for user status updates
    // Users can only receive callbacks when the value passed in isUserStatusNotify of ZegoRoomConfig when logging in to the room (loginRoom) is true.
    func onRoomUserUpdate(_ updateType: ZegoUpdateType, userList: [ZegoUser], roomID: String) {
        
    }
    
    // Implement event callbacks as needed
    //If users want to display videos published by other users, call the API startPublishingStream to pass streamID in streamList
    func onRoomStreamUpdate(_ updateType: ZegoUpdateType, streamList: [ZegoStream], extendedData: [AnyHashable : Any]?, roomID: String) {
        
    }
    
    // Callback for updates on published stream status
    func onPublisherStateUpdate(_ state: ZegoPublisherState, errorCode: Int32, extendedData: [AnyHashable : Any]?, streamID: String) {
        // Implement event callbacks as needed
    }
    
    // Callback for updates on played stream status
    func onPlayerStateUpdate(_ state: ZegoPlayerState, errorCode: Int32, extendedData: [AnyHashable : Any]?, streamID: String) {
        // Implement event callbacks as needed
    }
}
