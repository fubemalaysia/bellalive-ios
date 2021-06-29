//
//  SearchModel.swift
//  Bellalive
//
//  Created by apple on 12/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation


// MARK: - SearchModel
struct SearchModel: Codable {
    let data: [SearchData]
    let links: SearchLinks
    let meta: SearchMeta
    let code: Int
    let status: String
}

// MARK: - Datum
struct SearchData: Codable {
    let id: Int
    let bellaliveID, firstName, lastName, phoneNo: String
    let fans, following, totalBellaPoints, totalSendPoints: Int
    let totalReceivePoints: Int
    let customerLevelID, customerLevelName: JSONNull?
    let countryID: Int?
    let countryName: String?
    let avatar: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case id
        case bellaliveID = "bellalive_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNo = "phone_no"
        case fans, following
        case totalBellaPoints = "total_bella_points"
        case totalSendPoints = "total_send_points"
        case totalReceivePoints = "total_receive_points"
        case customerLevelID = "customer_level_id"
        case customerLevelName = "customer_level_name"
        case countryID = "country_id"
        case countryName = "country_name"
        case avatar, status
    }
}

// MARK: - Links
struct SearchLinks: Codable {
    let first, last: String
    let prev, next: JSONNull?
}

// MARK: - Meta
struct SearchMeta: Codable {
    let currentPage, from, lastPage: Int
    let path: String
    let perPage, to, total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case path
        case perPage = "per_page"
        case to, total
    }
}

// MARK: - SearchVideoModel
struct SearchVideoModel: Codable {
    let data: [SearchVideoData]
    let links: SearchVideoLinks
    let meta: SearchVideoMeta
    let code: Int
    let status: String
}

// MARK: - Datum
struct SearchVideoData: Codable {
    let id: Int
    let date: String
    let userID: Int
    let user: SearchVideoUser
    let streamID, title, streamPath: String
    let coverPath: String
    let liveDuration: String?
    let starPoints: Int?
    let totalAudience: Int
    let maxAudience, newFollows, shareNo: JSONNull?
    let totalLikes, receivedPoints: Int?
    let streamStatus: SearchVideoStreamStatus
    let status: SearchVideoStatus

    enum CodingKeys: String, CodingKey {
        case id, date
        case userID = "user_id"
        case user
        case streamID = "stream_id"
        case title
        case streamPath = "stream_path"
        case coverPath = "cover_path"
        case liveDuration = "live_duration"
        case starPoints = "star_points"
        case totalAudience = "total_audience"
        case maxAudience = "max_audience"
        case newFollows = "new_follows"
        case shareNo = "share_no"
        case totalLikes = "total_likes"
        case receivedPoints = "received_points"
        case streamStatus = "stream_status"
        case status
    }
}

enum SearchVideoStatus: String, Codable {
    case active = "Active"
    case live = "Live"
}

enum SearchVideoStreamStatus: String, Codable {
    case broadcasting = "broadcasting"
    case created = "created"
    case started = "started"
}

// MARK: - User
struct SearchVideoUser: Codable {
    let id: Int
    let bellaliveID: String
    let name: SearchVideoName
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case bellaliveID = "bellalive_id"
        case name, avatar
    }
}

enum SearchVideoName: String, Codable {
    case balaMurugan = "Bala Murugan"
    case muruganTest = "Murugan Test"
}

// MARK: - Links
struct SearchVideoLinks: Codable {
    let first, last: String
    let prev: JSONNull?
    let next: String
}

// MARK: - Meta
struct SearchVideoMeta: Codable {
    let currentPage, from, lastPage: Int
    let path: String
    let perPage, to, total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case path
        case perPage = "per_page"
        case to, total
    }
}
