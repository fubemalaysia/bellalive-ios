//
//  LiveRecordScreen.swift
//  Bellalive
//
//  Created by APPLE on 22/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

struct liveRecord{
    let header: String
    let details: [liveDetail]
    init(header: String,details: [liveDetail]) {
        self.header = header
        self.details = details
    }
}
class LiveRecordScreen: UIViewController {
    let arrayLive : [liveRecord] = [liveRecord(header: "06-18", details: [liveDetail(time: "20:20:47", points: "0")])]
    @IBOutlet weak var TblViewLiveRecord: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func BtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension LiveRecordScreen: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLive.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLive[section].details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveCell", for: indexPath) as! LiveRecordTblViewCell
        cell.LblTimeDuration.text = arrayLive[indexPath.section].details[indexPath.row].time
        let points = arrayLive[indexPath.section].details[indexPath.row].points
        cell.LblStarPoints.text = "Total Starpoints \(points)"
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "HeaderLiveCell") as! HeaderLiveTblViewCell
        header.LblTitle.text = arrayLive[section].header
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
