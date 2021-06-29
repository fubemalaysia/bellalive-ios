//
//  StreamCommentListModel.swift
//  Bellalive
//
//  Created by apple on 15/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
struct StreamCommentListModel : Codable {

        let code : Int?
        let data : [StreamCommentListData]?
        let links : StreamCommentListLink?
        let meta : StreamCommentListMeta?
        let status : String?

        enum CodingKeys: String, CodingKey {
                case code = "code"
                case data = "data"
                case links = "links"
                case meta = "meta"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                code = try values.decodeIfPresent(Int.self, forKey: .code)
                data = try values.decodeIfPresent([StreamCommentListData].self, forKey: .data)
                links = try values.decodeIfPresent(StreamCommentListLink.self, forKey: .links)
                meta = try values.decodeIfPresent(StreamCommentListMeta.self, forKey: .meta)
                status = try values.decodeIfPresent(String.self, forKey: .status)
        }

}

struct StreamCommentListMeta : Codable {

        let currentPage : Int?
        let from : Int?
        let lastPage : Int?
        let path : String?
        let perPage : Int?
        let to : Int?
        let total : Int?

        enum CodingKeys: String, CodingKey {
                case currentPage = "current_page"
                case from = "from"
                case lastPage = "last_page"
                case path = "path"
                case perPage = "per_page"
                case to = "to"
                case total = "total"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
                from = try values.decodeIfPresent(Int.self, forKey: .from)
                lastPage = try values.decodeIfPresent(Int.self, forKey: .lastPage)
                path = try values.decodeIfPresent(String.self, forKey: .path)
                perPage = try values.decodeIfPresent(Int.self, forKey: .perPage)
                to = try values.decodeIfPresent(Int.self, forKey: .to)
                total = try values.decodeIfPresent(Int.self, forKey: .total)
        }

}

struct StreamCommentListLink : Codable {

        let first : String?
        let last : String?
        let next : String?
        let prev : String?

        enum CodingKeys: String, CodingKey {
                case first = "first"
                case last = "last"
                case next = "next"
                case prev = "prev"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                first = try values.decodeIfPresent(String.self, forKey: .first)
                last = try values.decodeIfPresent(String.self, forKey: .last)
                next = try values.decodeIfPresent(String.self, forKey: .next)
                prev = try values.decodeIfPresent(String.self, forKey: .prev)
        }

}

struct StreamCommentListData : Codable {

        let comment : String?
        let date : String?
        let id : Int?
        let streamVideoId : Int?
        let time : String?
        let timeStamp : Int?
        let user : StreamCommentListUser?
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
                user = try values.decodeIfPresent(StreamCommentListUser.self, forKey: .user)
                userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        }

}

struct StreamCommentListUser : Codable {

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
