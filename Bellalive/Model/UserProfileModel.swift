//
//  UserProfileModel.swift
//  Bellalive
//
//  Created by apple on 12/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation

struct UserProfileModel : Codable {

        let code : Int?
        let data : UserProfileData?
        let status : String?

        enum CodingKeys: String, CodingKey {
                case code = "code"
                case data = "data"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                code = try values.decodeIfPresent(Int.self, forKey: .code)
                data = try values.decodeIfPresent(UserProfileData.self, forKey: .data)
                status = try values.decodeIfPresent(String.self, forKey: .status)
        }

}


struct UserProfileData : Codable {

        let autoplayUnderNoWifi : Int?
        let avatar : String?
        let bellaliveId : String?
        let bio : String?
        let city : String?
        let country : UserProfileCountry?
        let customerLevel : String?
        let dob : String?
        let dobTimeStamp : Int?
        let fans : Int?
        let firstName : String?
        let following : Int?
        let gender : String?
        let id : Int?
        let lastName : String?
        let nickname : String?
        let occupation : String?
        let phoneNo : String?
        let postVideoLiveUnderNoWifi : Int?
        let pushNotification : Int?
        let totalBellaPoints : Int?
        let totalReceivePoints : Int?
        let totalSendPoints : Int?

        enum CodingKeys: String, CodingKey {
                case autoplayUnderNoWifi = "autoplay_under_no_wifi"
                case avatar = "avatar"
                case bellaliveId = "bellalive_id"
                case bio = "bio"
                case city = "city"
                case country = "country"
                case customerLevel = "customer_level"
                case dob = "dob"
                case dobTimeStamp = "dob_time_stamp"
                case fans = "fans"
                case firstName = "first_name"
                case following = "following"
                case gender = "gender"
                case id = "id"
                case lastName = "last_name"
                case nickname = "nickname"
                case occupation = "occupation"
                case phoneNo = "phone_no"
                case postVideoLiveUnderNoWifi = "post_video_live_under_no_wifi"
                case pushNotification = "push_notification"
                case totalBellaPoints = "total_bella_points"
                case totalReceivePoints = "total_receive_points"
                case totalSendPoints = "total_send_points"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                autoplayUnderNoWifi = try values.decodeIfPresent(Int.self, forKey: .autoplayUnderNoWifi)
                avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
                bellaliveId = try values.decodeIfPresent(String.self, forKey: .bellaliveId)
                bio = try values.decodeIfPresent(String.self, forKey: .bio)
                city = try values.decodeIfPresent(String.self, forKey: .city)
                country = try values.decodeIfPresent(UserProfileCountry.self, forKey: .country)
                customerLevel = try values.decodeIfPresent(String.self, forKey: .customerLevel)
                dob = try values.decodeIfPresent(String.self, forKey: .dob)
                dobTimeStamp = try values.decodeIfPresent(Int.self, forKey: .dobTimeStamp)
                fans = try values.decodeIfPresent(Int.self, forKey: .fans)
                firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
                following = try values.decodeIfPresent(Int.self, forKey: .following)
                gender = try values.decodeIfPresent(String.self, forKey: .gender)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
                nickname = try values.decodeIfPresent(String.self, forKey: .nickname)
                occupation = try values.decodeIfPresent(String.self, forKey: .occupation)
                phoneNo = try values.decodeIfPresent(String.self, forKey: .phoneNo)
                postVideoLiveUnderNoWifi = try values.decodeIfPresent(Int.self, forKey: .postVideoLiveUnderNoWifi)
                pushNotification = try values.decodeIfPresent(Int.self, forKey: .pushNotification)
                totalBellaPoints = try values.decodeIfPresent(Int.self, forKey: .totalBellaPoints)
                totalReceivePoints = try values.decodeIfPresent(Int.self, forKey: .totalReceivePoints)
                totalSendPoints = try values.decodeIfPresent(Int.self, forKey: .totalSendPoints)
        }

}

struct UserProfileCountry : Codable {

        let id : Int?
        let iso : String?
        let name : String?
        let stdCode : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case iso = "iso"
                case name = "name"
                case stdCode = "std_code"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                iso = try values.decodeIfPresent(String.self, forKey: .iso)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                stdCode = try values.decodeIfPresent(String.self, forKey: .stdCode)
        }

}
