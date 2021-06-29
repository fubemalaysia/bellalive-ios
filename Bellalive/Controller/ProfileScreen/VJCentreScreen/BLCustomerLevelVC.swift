//
//  BLCustomerLevelVC.swift
//  Bellalive
//
//  Created by apple on 01/04/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit

class BLCustomerLevelVC: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var crownImg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var bellapointLbl: UILabel!
    @IBOutlet weak var levelPointLbl: UILabel!
    @IBOutlet weak var minPointLbl: UILabel!
    @IBOutlet weak var maxPointLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var image = String(), points = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = Appcontext.shared.user?.avatar{
            let imgUrl = URL(string: image)
            profileImg.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
        }
        bellapointLbl.text = Appcontext.shared.user?.bellaliveId
        apicallforCustomerLevel()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.progressView.transform = CGAffineTransform(scaleX: 1, y: 4)
            self.profileImg.layer.cornerRadius = self.profileImg.frame.height/2
            self.bgView.layer.cornerRadius = self.bgView.frame.height/2
            self.progressView.layer.cornerRadius = self.progressView.frame.height/2
        }
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func apicallforCustomerLevel(){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        WebService.shared.getMethodHeader(Api: .profileCustomerLevel,parameter: nil, token: token){[weak self] (response) -> (Void) in
            guard let weak = self else{return}
            do{
                let level = try JSONDecoder().decode(CustomerLevelModel.self, from: response)
                
                if level.data.level.name.lowercased() == "gold"{
                    weak.crownImg.image = #imageLiteral(resourceName: "Gold Ranking")
                    weak.profileImg.layer.borderColor = #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1)
                }else if level.data.level.name.lowercased() == "silver"{
                    weak.crownImg.image = #imageLiteral(resourceName: "Silver Ranking")
                    weak.profileImg.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
                }else if level.data.level.name.lowercased() == "orange"{
                    weak.crownImg.image = #imageLiteral(resourceName: "Bronze Ranking")
                    weak.profileImg.layer.borderColor = #colorLiteral(red: 0.8039215686, green: 0.4980392157, blue: 0.1960784314, alpha: 1)
                }else{
                    weak.crownImg.isHidden = true
                    weak.profileImg.layer.borderColor = weak.generateRandomColor().cgColor
                }
                
                let attrs1 = [NSAttributedString.Key.font : UIFont(name: "SFUIDisplay-Semibold", size: 16) ??
                    "", NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.8039215686, green: 0.4980392157, blue: 0.1960784314, alpha: 1)] as [NSAttributedString.Key : Any]

                let attrs2 = [NSAttributedString.Key.font : UIFont(name: "SFUIDisplay-Semibold", size: 16), NSAttributedString.Key.foregroundColor : UIColor.white]

                let attributedString1 = NSMutableAttributedString(string:"\(level.data.customerGiftedPoints)", attributes:attrs1 as [NSAttributedString.Key : Any])

                let attributedString2 = NSMutableAttributedString(string:"  Achivement Ponts", attributes:attrs2 as [NSAttributedString.Key : Any])

                attributedString1.append(attributedString2)
                weak.levelPointLbl.attributedText = attributedString1
                
                weak.minPointLbl.text = "LV.\(level.data.level.min)"
                weak.maxPointLbl.text = "LV.\(level.data.level.max)"
                weak.progressView.progress = Float(level.data.level.max / level.data.level.min)
               // weak.levelPointLbl.text = "\(level.data.customerGiftedPoints)"
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    

}

import Foundation

// MARK: - CustomerLevelModel
struct CustomerLevelModel: Codable {
    let status: String
    let data: CustomerLevelDataClass
    let code: Int
}

// MARK: - DataClass
struct CustomerLevelDataClass: Codable {
    let customerGiftedPoints: Int
    let level: CustomerLevel

    enum CodingKeys: String, CodingKey {
        case customerGiftedPoints = "customer_gifted_points"
        case level
    }
}

// MARK: - Level
struct CustomerLevel: Codable {
    let id: Int
    let code, name: String
    let icon: String
    let min, max: Int
    let status: String
}
