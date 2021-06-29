//
//  FollowingUserListModel.swift
//  Bellalive
//
//  Created by apple on 16/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation

struct FollowingUserListModel : Codable {

        let code : Int?
        let data : [FollowingUserListData]?
        let links : FollowingUserListLink?
        let meta : FollowingUserListMeta?
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
                data = try values.decodeIfPresent([FollowingUserListData].self, forKey: .data)
                links = try values.decodeIfPresent(FollowingUserListLink.self, forKey: .links)
                meta = try values.decodeIfPresent(FollowingUserListMeta.self, forKey: .meta)
                status = try values.decodeIfPresent(String.self, forKey: .status)
        }

}

struct FollowingUserListMeta : Codable {

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

struct FollowingUserListLink : Codable {

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

struct FollowingUserListData : Codable {

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
