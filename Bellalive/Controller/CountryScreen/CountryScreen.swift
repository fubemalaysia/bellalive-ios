//
//  CountryScreen.swift
//  Bellalive
//
//  Created by APPLE on 30/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

protocol dismissCountry : class{
    func dismissCountryCode(dataCode: String,data: String,dataID: Int?, stdCode : String)
}
class CountryScreen: UIViewController,UISearchBarDelegate {
    @IBOutlet weak var TblCountry: UITableView!
    @IBOutlet weak var ViewCountry: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
//    @IBOutlet weak var ViewCountryHeight: NSLayoutConstraint!
    var searching = false
    var countryData: countryApi?
    var countryDataFilter: [countryDataApi]?
    weak var delegateDismiss : dismissCountry?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        countryCodeApi()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func countryCodeApi(){
        WebService.shared.getMethodUrl(Api: .countryList,urlString: "?api_token=\(api_Token)", parameter: nil) { (response) -> (Void) in
            do{
                let json = try JSONDecoder().decode(countryApi.self, from: response)
                self.countryData = json
                print(self.countryData ?? "")
//                self.ViewCountryHeight.constant = CGFloat(50 + ((self.countryData?.data?.count ?? 0) * 50))
//                print(self.ViewCountryHeight.constant)
                self.TblCountry.reloadData()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    @IBAction func BtnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
        searching = false
        self.TblCountry.reloadData()
        ViewCountry.endEditing(true)
        //self.dismiss(animated: true, completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        countryDataFilter = countryData?.data?.filter({($0.name!.lowercased().contains(searchText.lowercased()))})
        searching = true
        self.TblCountry.reloadData()
        if searchText.count == 0{
            searchBar.resignFirstResponder()
            searchBar.text = ""
            searching = false
            self.TblCountry.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searching = false
        self.TblCountry.reloadData()
    }
    
}
extension CountryScreen: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
             return countryDataFilter?.count ?? 0
        }else{
            return countryData?.data?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TblCell", for: indexPath) as! CountryTblViewCell
        if searching {
            let data = countryDataFilter?[indexPath.row]
            cell.LblCountryCode.text = "+\(data?.std_code ?? "")"
//            self.ViewCountryHeight.constant = CGFloat(50 + ((self.countryDataFilter?.data?.count ?? 0) * 50))
//            print(self.ViewCountryHeight.constant)
            cell.LblCountryName.text = data?.name
        }else{
            let data = countryData?.data?[indexPath.row]
            cell.LblCountryCode.text = "+\(data?.std_code ?? "")"
//            self.ViewCountryHeight.constant = CGFloat(50 + ((self.countryData?.data?.count ?? 0) * 50))
//            print(self.ViewCountryHeight.constant)
            cell.LblCountryName.text = data?.name
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            let data = countryDataFilter?[indexPath.row]
            let stdCode = "+\(data?.std_code ?? "")"
            let name = data?.name ?? ""
            let id = data?.id
            let code = data?.std_code ?? ""
            delegateDismiss?.dismissCountryCode(dataCode: stdCode, data: name, dataID: id, stdCode: code)
        }else{
            let data = countryData?.data?[indexPath.row]
            let stdCode = "+\(data?.std_code ?? "")"
            let name = data?.name ?? ""
            let id = data?.id
            let code = data?.std_code ?? ""
            delegateDismiss?.dismissCountryCode(dataCode: stdCode, data: name, dataID: id, stdCode: code)
        }
    }
}

/*
 var groups = [Character:[Country]]()
 var sortedData = [Dictionary<Character, [Country]>.Element]()
 groups = Dictionary(grouping: CountryList) { (country) -> Character in
     return country.name.first!
 }
  sortedData = groups.sorted { (aDic, bDic) -> Bool in
     return aDic.key < bDic.key
 }
 
 func numberOfSections(in tableView: UITableView) -> Int {
    return sortedData.count
}
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sortedData[section].value.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TblCell", for: indexPath) as! CountryTblViewCell
    let data = sortedData[indexPath.section].value[indexPath.row]
    cell.LblCountryCode.text = data.dial_code
    cell.LblCountryName.text = data.name
    return cell
}
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TblHeaderCell") as! CountryHeaderTblViewCell
    let data = sortedData[section]
    cell.LblHeader.text = "\(data.key)"
    return cell
}
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
}
func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
}*/
