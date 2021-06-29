//
//  ApiService.swift
//  Bellalive
//
//  Created by APPLE on 04/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation

//country code
struct countryApi : Codable{
    let status: String?
    let data: [countryDataApi]?
}
struct countryDataApi : Codable{
    let id: Int?
    let iso: String?
    let name: String?
    let std_code: String?
}
//register
struct signUpApi : Codable{
    let status: String?
    let data: signUpDataApi?
    let error: signUpErrorData?
    let code: Int?
}
struct signUpDataApi : Codable{
    let id: Int?
    let bellalive_id: Int?
    let phone_no: String?
}
struct signUpErrorData : Codable{
    let phone_no: [String]?
}
// login
struct loginApi : Codable{
    let status: String?
    let data: loginDataApi?
    let error: String?
    let code: Int?
}
struct loginDataApi : Codable{
    let id: Int?
    let bellalive_id: String?
    let phone_no: String?
    let token : String?
}
//sms verification after login
struct smsVerifyApi: Codable{
    let status: String?
    let data: smsVerifyData?
    let code: Int?
    let error : smsError?
}
struct smsVerifyData: Codable{
    let token: String?
    let id: Int?
    let bellalive_id: String?
    let first_name: String?
    let last_name: String?
    let phone_no: String?
    let fans: Int?
    let following: Int?
    let total_bella_points: Int?
    let total_send_points: Int?
    let total_receive_points: Int?
    let customer_level: String?
    let country: countryDataApi?
    let avatar: String?
    let token_type: String?
    let expires_at: String?
}
struct smsError : Codable{
    let sms_code : [String]?
}
// home screen banner category
struct bannerCategoryApi : Codable{
    let status: String?
    let data: [bannerCatData]?
    let code: Int?
}
struct bannerCatData: Codable{
    let id: Int?
    let name: String?
    let priority: String?
    let banner: [bannerData]?
}
struct bannerData: Codable{
    let id: Int?
    let file: String?
    let link: String?
}
// newest
struct newestApi : Codable{
    let data: [newestDataApi]?
    let links: newestLinkApi?
    let meta: newestMetaApi?
    let code: Int?
    let status: String?
}
struct newestDataApi: Codable{
    let id: Int?
    let date: String?
    let user_id: Int?
    let user: userDataApi?
    let stream_id: String?
    let title: String?
    let stream_path: String?
    let cover_path: String?
    let live_duration: String?
    let star_points: Int?
    let total_audience: Int?
    let max_audience: Int?
    let new_follows: Int?
    let share_no: Int?
    let total_likes: Int?
    let received_points: Int?
    let stream_status: String?
    let status: String?
}
struct userDataApi: Codable{
    let id: Int?
    let bellalive_id: String?
    let name: String?
    let avatar: String?
}
struct newestLinkApi: Codable{
    let first: String?
    let last: String?
    let prev: String?
    let next: String?
}
struct newestMetaApi: Codable{
    let current_page: Int?
    let from: Int?
    let last_page: Int?
    let path: String?
    let per_page: Int?
    let to: Int?
    let total: Int?
}
//stream list
struct streamListApi: Codable{
  let status : String?
  let data : [newestDataApi]?
  let links : newestLinkApi?
  let code : Int?
  let meta : streamMetaApi?
}
struct streamMetaApi: Codable{
    let current_page: Int?
    let from: Int?
    let last_page: Int?
    let path: String?
    let per_page: String?
    let to: Int?
    let total: Int?
}
// location update
struct locDataApi: Codable{
    let status: String?
    let data: locData?
    let code: Int?
}
struct locData: Codable{
    let id: Int?
    let bellalive_id: String?
    let latitude: Double?
    let longitude: Double?
}
//nearby user
struct nearByUserApi : Codable{
    let data: [nearByUserData]?
    let links: newestLinkApi?
    let meta: newestMetaApi?
    let code: Int?
    let status: String?
}
struct nearByUserData: Codable{
    let id: Int?
    let bellalive_id: String?
    let first_name: String?
    let last_name: String?
    let phone_no: String?
    let fans: Int?
    let following: Int?
    let total_bella_points: Int?
    let total_send_points: Int?
    let total_receive_points: Int?
    let customer_level_id: Int?
    let customer_level_name: String?
    let country_id: Int?
    let country_name: String?
    let avatar: String?
    let status: String?
}
