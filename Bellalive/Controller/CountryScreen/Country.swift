//
//  Country.swift
//  Bellalive
//
//  Created by APPLE on 30/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

var CountryList : [Country] = []
struct Country{
    let code : String
    let dial_code : String
    let name : String
    let image : UIImage
    init(codestr: String,dial_codestr : String,namestr: String,imageimg: UIImage) {
        self.code = codestr
        self.dial_code = dial_codestr
        self.name = namestr
        self.image = imageimg
    }
    
}
class Countries : NSObject{
    static let shared = Countries()
    func fetchCountry(){
        guard let path = Bundle.main.path(forResource: "countryCodes", ofType: "json") else{return}
        let url = URL(fileURLWithPath: path)
        do{
            let data = try Data(contentsOf: url)
            let json = try JSON(data: data)
            guard let arr = json.array else{return}
            for country in arr{
                guard let code = country["code"].string else{return}
                guard let dialcode = country["dial_code"].string else{return}
                guard let name = country["name"].string else{return}
                guard let imgcode : UIImage = UIImage(named: code)else{return}
                CountryList.append(.init(codestr: code, dial_codestr: dialcode, namestr: name, imageimg: imgcode))
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}
