//
//  StreamGiftSendModel.swift
//  Bellalive
//
//  Created by apple on 19/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation

struct StreamGiftSendModel : Codable {

        let code : Int?
        let data : StreamGiftSendData?
        let status : String?

        enum CodingKeys: String, CodingKey {
                case code = "code"
                case data = "data"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                code = try values.decodeIfPresent(Int.self, forKey: .code)
                data = try values.decodeIfPresent(StreamGiftSendData.self, forKey: .data)
                status = try values.decodeIfPresent(String.self, forKey: .status)
        }

}

struct StreamGiftSendData : Codable {

        let coverPath : String?
        let date : String?
        let id : Int?
        let liveDuration : String?
        let maxAudience : Int?
        let newFollows : Int?
        let receivedPoints : String?
        let shareNo : Int?
        let starPoints : String?
        let status : String?
        let streamId : String?
        let streamPath : String?
        let streamStatus : String?
        let title : String?
        let totalAudience : Int?
        let totalLikes : Int?
        let user : StreamGiftSendUser?
        let userId : Int?

        enum CodingKeys: String, CodingKey {
                case coverPath = "cover_path"
                case date = "date"
                case id = "id"
                case liveDuration = "live_duration"
                case maxAudience = "max_audience"
                case newFollows = "new_follows"
                case receivedPoints = "received_points"
                case shareNo = "share_no"
                case starPoints = "star_points"
                case status = "status"
                case streamId = "stream_id"
                case streamPath = "stream_path"
                case streamStatus = "stream_status"
                case title = "title"
                case totalAudience = "total_audience"
                case totalLikes = "total_likes"
                case user = "user"
                case userId = "user_id"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                coverPath = try values.decodeIfPresent(String.self, forKey: .coverPath)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                liveDuration = try values.decodeIfPresent(String.self, forKey: .liveDuration)
                maxAudience = try values.decodeIfPresent(Int.self, forKey: .maxAudience)
                newFollows = try values.decodeIfPresent(Int.self, forKey: .newFollows)
                receivedPoints = try values.decodeIfPresent(String.self, forKey: .receivedPoints)
                shareNo = try values.decodeIfPresent(Int.self, forKey: .shareNo)
                starPoints = try values.decodeIfPresent(String.self, forKey: .starPoints)
                status = try values.decodeIfPresent(String.self, forKey: .status)
                streamId = try values.decodeIfPresent(String.self, forKey: .streamId)
                streamPath = try values.decodeIfPresent(String.self, forKey: .streamPath)
                streamStatus = try values.decodeIfPresent(String.self, forKey: .streamStatus)
                title = try values.decodeIfPresent(String.self, forKey: .title)
                totalAudience = try values.decodeIfPresent(Int.self, forKey: .totalAudience)
                totalLikes = try values.decodeIfPresent(Int.self, forKey: .totalLikes)
                user = try values.decodeIfPresent(StreamGiftSendUser.self, forKey: .user)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}

struct StreamGiftSendUser : Codable {

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
