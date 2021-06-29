//
//  SmsSendModel.swift
//  Bellalive
//
//  Created by apple on 17/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
import SwiftyJSON


class SmsSendModel : NSObject, NSCoding{

    var code : String!
    var mobile : String!
    var smsId : String!
    var status : String!
    var username : String!
    var uuid : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["code"].stringValue
        mobile = json["mobile"].stringValue
        smsId = json["sms_id"].stringValue
        status = json["status"].stringValue
        username = json["username"].stringValue
        uuid = json["uuid"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if code != nil{
            dictionary["code"] = code
        }
        if mobile != nil{
            dictionary["mobile"] = mobile
        }
        if smsId != nil{
            dictionary["sms_id"] = smsId
        }
        if status != nil{
            dictionary["status"] = status
        }
        if username != nil{
            dictionary["username"] = username
        }
        if uuid != nil{
            dictionary["uuid"] = uuid
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        code = aDecoder.decodeObject(forKey: "code") as? String
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        smsId = aDecoder.decodeObject(forKey: "sms_id") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        username = aDecoder.decodeObject(forKey: "username") as? String
        uuid = aDecoder.decodeObject(forKey: "uuid") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if mobile != nil{
            aCoder.encode(mobile, forKey: "mobile")
        }
        if smsId != nil{
            aCoder.encode(smsId, forKey: "sms_id")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if username != nil{
            aCoder.encode(username, forKey: "username")
        }
        if uuid != nil{
            aCoder.encode(uuid, forKey: "uuid")
        }

    }

}
