//
//  StartBroadcastScreen.swift
//  Bellalive
//
//  Created by APPLE on 24/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class StartBroadcastScreen: UIViewController {
    let array = ["Beauty","Whitening","Ruddy"]
    var selection = [String]()
    
    @IBOutlet weak var LblSlideConstraint: NSLayoutConstraint!
    @IBOutlet weak var TxtView: UITextView!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var BeautySlider: UISlider!
    @IBOutlet weak var LblBeautyValue: paddingLabel!
    @IBOutlet weak var BeautyClnView: UICollectionView!
    @IBOutlet var ViewBeauty: UIView!
    @IBOutlet weak var BtnStartBoardcastOutlet: UIButton!
    @IBOutlet weak var ViewSelectCountry: UIView!
    @IBOutlet weak var ViewEditCover: UIView!
    @IBOutlet weak var ViewInsideBuredView: UIView!
    @IBOutlet weak var BluredView: UIVisualEffectView!
    @IBOutlet weak var BtnCloseOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeView()
        for i in 0...array.count - 1{
            if i == 0{
                selection.append("true")
            }else{
                selection.append("false")
            }
        }
        beautyViewDisplay()
        ViewBeauty.isHidden = true
        BeautySlider.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
//        BeautySlider.value = 50
//        let trackRect = BeautySlider.trackRect(forBounds: BeautySlider.frame)
//        let thumbRect = BeautySlider.thumbRect(forBounds: BeautySlider.bounds, trackRect: trackRect, value: 50)
//        self.LblBeautyValue.center = CGPoint(x: thumbRect.midX, y: self.LblBeautyValue.center.y)
        // Do any additional setup after loading the view.
    }
    func shapeView(){
        BluredView.layer.cornerRadius = 10
        ViewInsideBuredView.layer.cornerRadius = 10
        let c1 = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        let c2 = #colorLiteral(red: 0.8078431373, green: 0.8509803922, blue: 0.8784313725, alpha: 1)
        let c3 = #colorLiteral(red: 0.4980392157, green: 0.1490196078, blue: 0.4588235294, alpha: 1)
        let c4 = #colorLiteral(red: 0.6980392157, green: 0.2117647059, blue: 0.6235294118, alpha: 1)
        let c5 = #colorLiteral(red: 1, green: 0.1764705882, blue: 0.3333333333, alpha: 1)
        ViewSelectCountry.applyTopBottomGradient(colors: [c2.cgColor,c1.cgColor])
        BtnStartBoardcastOutlet.applyGradient(colors: [c5.cgColor,c4.cgColor,c3.cgColor])
        ViewEditCover.layer.cornerRadius = 10
        BtnCloseOutlet.layer.cornerRadius = BtnCloseOutlet.frame.height/2
        BtnCloseOutlet.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        
    }
    func beautyViewDisplay(){
        ViewBeauty.layer.cornerRadius = 10
        print(view.safeAreaLayoutGuide.layoutFrame)
        print(view.safeAreaInsets)
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            let bottomPadding = window?.safeAreaInsets.bottom
            
            ViewBeauty.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - (ViewBeauty.frame.height + (bottomPadding ?? 0)), width: UIScreen.main.bounds.width, height: ViewBeauty.frame.height)
            self.view.addSubview(ViewBeauty)
        }else{
            ViewBeauty.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - ViewBeauty.frame.height, width: UIScreen.main.bounds.width, height: ViewBeauty.frame.height)
            self.view.addSubview(ViewBeauty)
        }
    }
    func filterView(hide:Bool){
        if hide{
            ViewBeauty.isHidden = false
            ViewSelectCountry.isHidden = true
            BluredView.isHidden = true
            StackView.isHidden = true
            BtnStartBoardcastOutlet.isHidden = true
            TxtView.isHidden = true
        }else{
            ViewBeauty.isHidden = true
            ViewSelectCountry.isHidden = false
            BluredView.isHidden = false
            StackView.isHidden = false
            BtnStartBoardcastOutlet.isHidden = false
            TxtView.isHidden = false
        }
    }
    @IBAction func BtnClose(_ sender: UIButton) {
        if ViewBeauty.isHidden == false{
            filterView(hide: false)
        }else{
            let index = UserDefaults.standard.integer(forKey: "selectedTabIndex")
            print("index ---> \(index)")
            self.dismiss(animated: true, completion:{
                self.tabBarController?.selectedIndex = index
                
                UserDefaults.standard.removeObject(forKey: "selectedTabIndex")
            })
        }
    }
    @IBAction func BtnFacebook(_ sender: UIButton) {
    }
    @IBAction func BtnTwitter(_ sender: UIButton) {
    }
    @IBAction func BtnSelectCountry(_ sender: UIButton) {
    }
    @IBAction func BtnFlip(_ sender: UIButton) {
    }
    @IBAction func BtnBeauty(_ sender: UIButton) {
        filterView(hide: true)
    }
    @IBAction func BtnStartBroadcast(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: "LiveStreamingScreenID") as! LiveStreamingScreen
        rootVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(rootVC, animated: true)
    }
    @IBAction func BtnEditCover(_ sender: UIButton) {
    }
    @IBAction func BeautySliderAction(_ sender: UISlider) {
        let val = Int(sender.value)
        LblBeautyValue.text = String(val)
        let trackRect = sender.trackRect(forBounds: sender.frame)
        let thumbRect = sender.thumbRect(forBounds: sender.bounds, trackRect: trackRect, value: sender.value)
//        self.LblBeautyValue.center = CGPoint(x: thumbRect.midX, y: self.LblBeautyValue.center.y)
        self.LblBeautyValue.drawText(in: thumbRect)
    }
    @IBAction func BtnBeautyFilter(_ sender: UIButton) {
    }
    @IBAction func BtnSkinFilter(_ sender: UIButton) {
    }
    @IBAction func BtnColorsFilter(_ sender: UIButton) {
    }
    @IBAction func BtnStickers(_ sender: UIButton) {
    }
}
extension StartBroadcastScreen: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeautyClnCell", for: indexPath) as! BeautyClnViewCell
        cell.LblTitle.text = array[indexPath.row]
        if selection[indexPath.row] == "true"{
            cell.LblTitle.textColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        }else{
            cell.LblTitle.textColor = .white
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selection.removeAll()
        for _ in 0...array.count - 1{
            selection.append("false")
        }
        if selection[indexPath.item] == "false"{
            selection[indexPath.item] = "true"
            BeautyClnView.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3 - 10
        return CGSize(width: width, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
class paddingLabel: UILabel{
    var topInset: CGFloat = 5.0
    var bottomInset: CGFloat = 5.0
    var leftInset: CGFloat = 5.0
    var rightInset: CGFloat = 5.0

    override func drawText(in rect: CGRect) {
       let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
}
