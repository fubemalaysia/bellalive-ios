//
//  TopFansScreen.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

struct topFansData{
    let profileName: String
    let profileID: Int
    let profilePic: UIImage?
    let rating: Int
    init(profileName: String,profileID: Int,profilePic: UIImage?,rating: Int) {
        self.profileName = profileName
        self.profileID = profileID
        self.profilePic = profilePic
        self.rating = rating
    }
}
class TopFansScreen: UIViewController {
    let array : [topFansData] = [topFansData(profileName: "Johnny Rios", profileID: 34983294, profilePic: nil, rating: 16),topFansData(profileName: "Alfred Hodges", profileID: 42983213, profilePic: nil, rating: 25),topFansData(profileName: "Samuel Hammond", profileID: 34983532, profilePic: nil, rating: 43),topFansData(profileName: "Dora Hines", profileID: 64983274, profilePic: nil, rating: 32),topFansData(profileName: "Carolyn Francis", profileID: 73748319, profilePic: nil, rating: 20),topFansData(profileName: "Isaiah McGee", profileID: 34983943, profilePic: nil, rating: 60),topFansData(profileName: "Mark Holmes", profileID: 13498384, profilePic: nil, rating: 27),topFansData(profileName: "Russell McGuire", profileID: 63283294, profilePic: nil, rating: 10),topFansData(profileName: "Jonathan Peters", profileID: 63283232, profilePic: nil, rating: 36),topFansData(profileName: "Jason Wright", profileID: 34983294, profilePic: nil, rating: 48)]
    @IBOutlet weak var TblViewTopFans: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension TopFansScreen: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopFansCell", for: indexPath) as! TopFansTblViewCell
        if indexPath.row > 2{
            cell.ImgCrown.isHidden = true
        }else{
            cell.ImgCrown.isHidden = false
        }
        cell.LblCount.text = "\(indexPath.row + 1)"
        cell.LblProfileName.text = array[indexPath.row].profileName
        cell.LblProfileID.text = "ID: \(array[indexPath.row].profileID)"
        cell.LblRating.text = "\(array[indexPath.row].rating)"
        cell.ImgViewProfilePic.backgroundColor = .lightGray
        cell.ImgViewProfilePic.layer.cornerRadius = cell.ImgViewProfilePic.frame.height / 2
        cell.ViewRating.layer.cornerRadius = cell.ViewRating.frame.height / 2
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
