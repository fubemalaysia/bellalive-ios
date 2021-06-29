//
//  CreateStreamCommentModel.swift
//  Bellalive
//
//  Created by apple on 15/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation

struct CreateStreamCommentModel : Codable {

        let code : Int?
        let data : CreateStreamCommentData?
        let status : String?

        enum CodingKeys: String, CodingKey {
                case code = "code"
                case data = "data"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                code = try values.decodeIfPresent(Int.self, forKey: .code)
                data = try values.decodeIfPresent(CreateStreamCommentData.self, forKey: .data)
                status = try values.decodeIfPresent(String.self, forKey: .status)
        }

}


struct CreateStreamCommentData : Codable {

        let comment : String?
        let date : String?
        let id : Int?
        let streamVideoId : Int?
        let time : String?
        let timeStamp : Int?
        let user : CreateStreamCommentUser?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case comment = "comment"
                case date = "date"
                case id = "id"
                case streamVideoId = "stream_video_id"
                case time = "time"
                case timeStamp = "time_stamp"
                case user = "user"
                case userId = "user_id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                comment = try values.decodeIfPresent(String.self, forKey: .comment)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                streamVideoId = try values.decodeIfPresent(Int.self, forKey: .streamVideoId)
                time = try values.decodeIfPresent(String.self, forKey: .time)
                timeStamp = try values.decodeIfPresent(Int.self, forKey: .timeStamp)
                user = try values.decodeIfPresent(CreateStreamCommentUser.self, forKey: .user)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}

struct CreateStreamCommentUser : Codable {

        let avatar : String?
        let bellaliveId : String?
        let id : Int?
        let name : String?

        enum CodingKeys: String, CodingKey {
                case avatar = "avatar"
                case bellaliveId = "bellalive_id"
                case id = "id"
                case name = "name"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
                bellaliveId = try values.decodeIfPresent(String.self, forKey: .bellaliveId)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                name = try values.decodeIfPresent(String.self, forKey: .name)
        }

}
