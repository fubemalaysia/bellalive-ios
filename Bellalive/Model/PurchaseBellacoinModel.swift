//
//  PurchaseBellacoinModel.swift
//  Bellalive
//
//  Created by apple on 24/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
struct PurchaseBellacoinModel : Codable {

        let code : Int?
        let data : PurchaseBellacoinData?
        let status : String?

        enum CodingKeys: String, CodingKey {
                case code = "code"
                case data = "data"
                case status = "status"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                code = try values.decodeIfPresent(Int.self, forKey: .code)
                data = try values.decodeIfPresent(PurchaseBellacoinData.self, forKey: .data)
                status = try values.decodeIfPresent(String.self, forKey: .status)
        }

}

struct PurchaseBellacoinData : Codable {

        let amount : String?
        let currencyCode : String?
        let customerId : Int?
        let date : String?
        let gems : PurchaseBellacoinGem?
        let gemsId : String?
        let id : Int?
        let points : Int?
        let status : String?
        let timeStamp : CLong?
        let uuid : String?

        enum CodingKeys: String, CodingKey {
                case amount = "amount"
                case currencyCode = "currency_code"
                case customerId = "customer_id"
                case date = "date"
                case gems = "gems"
                case gemsId = "gems_id"
                case id = "id"
                case points = "points"
                case status = "status"
                case timeStamp = "time_stamp"
                case uuid = "uuid"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                amount = try values.decodeIfPresent(String.self, forKey: .amount)
                currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
                customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                gems = try values.decodeIfPresent(PurchaseBellacoinGem.self, forKey: .gems)
                gemsId = try values.decodeIfPresent(String.self, forKey: .gemsId)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                points = try values.decodeIfPresent(Int.self, forKey: .points)
                status = try values.decodeIfPresent(String.self, forKey: .status)
            timeStamp = try values.decodeIfPresent(CLong.self, forKey: .timeStamp)
                uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        }

}

struct PurchaseBellacoinGem : Codable {

        let id : Int?
        let name : String?
        let point : Int?
        let price : String?

        enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
                case point = "point"
                case price = "price"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                id = try values.decodeIfPresent(Int.self, forKey: .id)
                name = try values.decodeIfPresent(String.self, forKey: .name)
                point = try values.decodeIfPresent(Int.self, forKey: .point)
                price = try values.decodeIfPresent(String.self, forKey: .price)
        }

}
