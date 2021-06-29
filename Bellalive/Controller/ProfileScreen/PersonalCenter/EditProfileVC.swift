//
//  EditProfileVC.swift
//  Bellalive
//
//  Created by apple on 13/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import UIKit
import iOSDropDown
import Popover

class EditProfileVC: UIViewController {
   
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nickNameTxt: UITextField!
    @IBOutlet weak var genderTxt: DropDown!
    @IBOutlet weak var countryTxt: DropDown!
    
    
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var dobTxt: UITextField!
    @IBOutlet weak var occupationTxt: UITextField!
    @IBOutlet weak var bioTxt: UITextView!{
        didSet{
            bioTxt.delegate = self
        }
    }
    @IBOutlet weak var backgroundImg: UIImageView!
    
    fileprivate var popover: Popover!
    fileprivate var popoverOptions: [PopoverOption] = [.type(.auto),.cornerRadius(5),.animationIn(0.3),.blackOverlayColor(UIColor(white: 0.0, alpha: 0.6)),.arrowSize(CGSize(width: 16.0, height: 10.0))]
    fileprivate var genderArray = ["Boy","Girl"]
    
    var selectTable = String()
    var countryArray = [countryDataApi]()
    var datepicker = UIDatePicker()
    var toolBar = UIToolbar()
    var dateString = String() , countryID = Int()
    var userProfileData : UserProfileData?
    override func viewDidLoad() {
        super.viewDidLoad()
        bioTxt.backgroundColor = .clear
        genderSetUp()
        countryCodeApi()
        initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImg.layer.cornerRadius = profileImg.frame.height/2
        profileImg.layer.borderWidth = 1.0
        profileImg.layer.borderColor = UIColor.white.cgColor
    }
    
    
    
    private func genderSetUp(){
        genderTxt.optionArray = genderArray
        genderTxt.didSelect{(selectedText , index ,id) in
            self.genderTxt.text = selectedText
        }
    }
    
    private func initialSetup(){
        nickNameTxt.text = Appcontext.shared.user?.nickname
        genderTxt.text = Appcontext.shared.user?.gender
        countryTxt.text = Appcontext.shared.user?.country?.name
        cityTxt.text = Appcontext.shared.user?.city
        dobTxt.text = Utility.formatDate(dateString: Appcontext.shared.user?.dob ?? "")
        occupationTxt.text = Appcontext.shared.user?.occupation
        bioTxt.text = Appcontext.shared.user?.bio
        if let image = Appcontext.shared.user?.avatar{
            let imgUrl = URL(string: image)
            profileImg.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
        }
        countryID = Appcontext.shared.user?.country?.id ?? 0
    }
    
    private func countryCodeApi(){
        countryArray.removeAll()
        WebService.shared.getMethodUrl(Api: .countryList,urlString: "?api_token=\(api_Token)", parameter: nil) {[weak self] (response) -> (Void) in
            guard let weakself = self else{return}
            do{
                let json = try JSONDecoder().decode(countryApi.self, from: response)
                if let data = json.data{
                   weakself.countryArray = data
                }
                for option in weakself.countryArray{
                    weakself.countryTxt.optionArray.append(option.name ?? "")
                }
                
                weakself.countryTxt.didSelect{(selectedText , index ,id) in
                    weakself.countryID = weakself.countryArray[index].id ?? 0
                }
                
                
                
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    private func loadDate() {
       datepicker = UIDatePicker(frame: CGRect(x:0,y: self.view.frame.height - 200,width: UIScreen.main.bounds.size.width,height: 220))
       datepicker.backgroundColor = UIColor(red:236/255, green:236/255, blue:236/255, alpha:1)
       datepicker.locale = Locale(identifier: "en_US")
        datepicker.datePickerMode = .date
        
        var components = DateComponents()
        components.year = -10
        let maxDate = Calendar.current.date(byAdding: components, to: Date())
        datepicker.maximumDate = maxDate
       datepicker.setValue(UIColor.darkText, forKey: "textColor")
       self.view.addSubview(datepicker)

       toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 200, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action:  #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action:  #selector(cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
            self.view.addSubview(toolBar)
            
        }
    
    private func setTime(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        //dateFormatter.timeStyle = .none
        dateFormatter.dateFormat  = "yyyy/MM/dd"
       
        let dateString = dateFormatter.string(from: datepicker.date).uppercased()

        dobTxt.text = dateString
        
    }

    @objc func donePicker() {
        setTime()
        toolBar.removeFromSuperview()
        datepicker.removeFromSuperview()
    }
    @objc func cancelPicker() {
        toolBar.removeFromSuperview()
        datepicker.removeFromSuperview()
    }

    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        let validation = validateFields()
        if validation.isEmpty{
            let connectivity = isNetworkReachable()
            if connectivity == nil{
                apicallforProfileUpdate()
            }
        }else{
            createAlertBox(title: validation, message: "", buttonName: "OK")
        }
    }
    
    @IBAction func genderAction(_ sender: UIButton) {
        selectTable = "gender"
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: sender.frame.size.width, height: 70))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        popover = Popover(options: popoverOptions, showHandler: nil, dismissHandler: nil)
        self.popover.show(tableView, fromView: sender)
    }
    
    @IBAction func countryAction(_ sender: UIButton) {
        selectTable = "country"
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: sender.frame.size.width, height: 140))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .none
        popover = Popover(options: popoverOptions, showHandler: nil, dismissHandler: nil)
        self.popover.show(tableView, fromView: sender)

    }
    
    
    @IBAction func dobAction(_ sender: UIButton) {
        loadDate()
    }
    
    private func apicallforProfileUpdate(){
        guard let token = tokenID, tokenID != nil else{
            return
        }
        let param = ["first_name" : Appcontext.shared.user?.firstName ?? "",
                     "last_name" : Appcontext.shared.user?.firstName ?? "",
                     "nickname" : nickNameTxt.text!,
                     "gender" : genderTxt.text!,
                     "dob" : dobTxt.text!,
                     "occupation" : occupationTxt.text!,
                     "bio" : bioTxt.text!,
                     "country_id" : countryID,
                     "city" : cityTxt.text!] as [String : Any]
        print(param)
        WebService.shared.postMethodHeader(Api: .profile, parameter: param, token: token){[weak self] (response) -> (Void) in
            guard let weakself = self else {return}
            do{
                let userData = try JSONDecoder().decode(UserProfileModel.self, from: response)
                if let data = userData.data{
                    weakself.userProfileData = data
                    Appcontext.shared.user = data
                }
                UserDefaults.standard.set(userData.data?.id, forKey: "UserID")
                weakself.nickNameTxt.text = weakself.userProfileData?.nickname
                weakself.genderTxt.text = weakself.userProfileData?.gender
                weakself.countryTxt.text = weakself.userProfileData?.country?.name
                weakself.cityTxt.text = weakself.userProfileData?.city
                weakself.dobTxt.text = weakself.userProfileData?.dob
                weakself.occupationTxt.text = weakself.userProfileData?.occupation
                weakself.bioTxt.text = weakself.userProfileData?.bio
                if let image = weakself.userProfileData?.avatar{
                    let imgUrl = URL(string: image)
                    weakself.profileImg.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "Logo Bella"))
                }
                weakself.navigationController?.popViewController(animated: true)
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    private func validateFields() -> String{
        if nickNameTxt.text == ""{
            return "Enter the nickname"
        }else if genderTxt.text == ""{
            return "Select the gender"
        }else if countryTxt.text == ""{
            return "Select the country"
        }else if cityTxt.text == ""{
            return "Enter the city"
        }else if dobTxt.text == ""{
            return "Select the DOB"
        }else if occupationTxt.text == ""{
            return "Enter the occupation"
        }else if bioTxt.text == "Write your bio"{
            return "Enter the bio"
        }
        return "";
    }
    
    
}
extension EditProfileVC : UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write your bio" {
            textView.text = ""
            textView.textColor = UIColor.white
            textView.font = UIFont(name: "SFUIDisplay-Regular", size: 14.0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       /* if text == "\n" {
            textView.resignFirstResponder()
        }*/
        if(textView == bioTxt){
            return textView.text.count +  (text.count - range.length) <= 200
        }

        return false
       // return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Write your bio"
            textView.textColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
            textView.font = UIFont(name: "SFUIDisplay-Regular", size: 14.0)
        }
    }
 
}
extension EditProfileVC :UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectTable == "gender" {
            return genderArray.count
        }else{
            return countryArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectTable == "gender" {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = self.genderArray[(indexPath as NSIndexPath).row]
            cell.textLabel?.textAlignment = .natural
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Semibold", size: 14)
            cell.textLabel?.textColor = UIColor(hex: "531B93")
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = self.countryArray[(indexPath as NSIndexPath).row].name
            cell.textLabel?.textAlignment = .natural
            cell.textLabel?.font = UIFont(name: "SFUIDisplay-Semibold", size: 14)
            cell.textLabel?.textColor = UIColor(hex: "531B93")
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectTable == "gender" {
            genderTxt.text = genderArray[indexPath.row]
        }else{
            countryTxt.text = countryArray[indexPath.row].name
        }
        self.popover.dismiss()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
}
