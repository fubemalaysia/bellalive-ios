//
//  ProfileImageUpdateModel.swift
//  Bellalive
//
//  Created by apple on 18/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation

struct ProfileImageUpdateModel : Codable {

        let code : Int?
        let data : ProfileImageUpdateData?
        let status : String?

        enum CodingKeys: String, CodingKey {
                case code = "code"
                case data = "data"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                code = try values.decodeIfPresent(Int.self, forKey: .code)
                data = try values.decodeIfPresent(ProfileImageUpdateData.self, forKey: .data)
                status = try values.decodeIfPresent(String.self, forKey: .status)
        }

}

struct ProfileImageUpdateData : Codable {

        let avatar : String?

        enum CodingKeys: String, CodingKey {
                case avatar = "avatar"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        }

}
