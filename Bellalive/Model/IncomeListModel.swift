//
//  IncomeListModel.swift
//  Bellalive
//
//  Created by apple on 05/03/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
struct IncomeListModel : Codable {

        let code : Int?
        let data : [IncomeListData]?
        let links : IncomeListLink?
        let meta : IncomeListMeta?
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
                data = try values.decodeIfPresent([IncomeListData].self, forKey: .data)
                links = try values.decodeIfPresent(IncomeListLink.self, forKey: .links)
                meta = try values.decodeIfPresent(IncomeListMeta.self, forKey: .meta)
                status = try values.decodeIfPresent(String.self, forKey: .status)
        }

}
struct IncomeListMeta : Codable {

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
struct IncomeListLink : Codable {

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
struct IncomeListData : Codable {

        let contributor : IncomeListContributor?
        let contributorId : Int?
        let date : String?
        let giftId : Int?
        let id : Int?
        let points : Int?
        let receiver : IncomeListReceiver?
        let receiverId : Int?
        let streamVideoId : Int?
        let timeStamp : Int?

        enum CodingKeys: String, CodingKey {
                case contributor = "contributor"
                case contributorId = "contributor_id"
                case date = "date"
                case giftId = "gift_id"
                case id = "id"
                case points = "points"
                case receiver = "receiver"
                case receiverId = "receiver_id"
                case streamVideoId = "stream_video_id"
                case timeStamp = "time_stamp"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                contributor = try values.decodeIfPresent(IncomeListContributor.self, forKey: .contributor)
                contributorId = try values.decodeIfPresent(Int.self, forKey: .contributorId)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                giftId = try values.decodeIfPresent(Int.self, forKey: .giftId)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                points = try values.decodeIfPresent(Int.self, forKey: .points)
                receiver = try values.decodeIfPresent(IncomeListReceiver.self, forKey: .receiver)
                receiverId = try values.decodeIfPresent(Int.self, forKey: .receiverId)
                streamVideoId = try values.decodeIfPresent(Int.self, forKey: .streamVideoId)
                timeStamp = try values.decodeIfPresent(Int.self, forKey: .timeStamp)
        }

}
struct IncomeListReceiver : Codable {

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
struct IncomeListContributor : Codable {

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
