//
//  ApiList.swift
//  Bellalive
//
//  Created by APPLE on 04/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation

let baseURL = "https://bellalive.asia/"
let api_Token = "OYUuXGCYowmePzWO6BMDhnG3if4Z9qqC"
var tokenID = UserDefaults.standard.string(forKey: "token")
var isLogin = UserDefaults.standard.string(forKey: "Login") ?? "0"
enum Base : String{
    // Complete
    case register                            = "api/v1/sign-up" //1
    case login                               = "api/v1/login" //2
    case categoryList                        = "api/v1/category-list" //3
    case countryList                         = "api/v1/country-list" //4
    case smsVerification                     = "api/v1/sms-verification" //5
    case profile                             = "api/v1/profile" //6
    case settings                            = "api/v1/settings" //7
    case gemsList                            = "api/v1/gems-list" //8
    case streamList                          = "api/v1/stream-list"  //9
    case locationUpdate                      = "api/v1/location-update" //10
    case search                              = "api/v1/search" //11
    case featuredList                        = "api/v1/featured-list" //12
    case nearestUser                         = "api/v1/nearest-user" //13
    case newestList                          = "api/v1/newest" //14
    case blockedUpdate                       = "api/v1/blocked" //15
    case followingUserList                   = "api/v1/following-list" //16
    case followUserUpdate                    = "api/v1/follow-update" //17
    case videoList                           = "api/v1/video-list" //18
    case purchaseBellaCoin                   = "api/v1/profile/account/purchase-bellacoin" //19
    case onlinePayment                       = "api/v1/profile/account/online-payment" //20
    case incomeList                          = "api/v1/profile/account/income-list" //21
    case expandList                          = "api/v1/profile/account/expand-list" //22
    case streamGiftSend                      = "api/v1/stream-gift-send" //23
    case guestUserProfile                    = "api/v1/other/user-profile" //24
    case guestUserVideoList                  = "api/v1/other/user-video-list"  //25
    case giftCategoryList                    = "api/v1/gift-category-list" //26
    case videoCommentList                    = "api/v1/video-comment-list" //27
    case videoCommentCreate                  = "api/v1/video-comment-create" //28
    case streamCommentList                   = "api/v1/stream-comment-list" //29
    case streamCommentCreate                 = "api/v1/stream-comment-create" //30
    case popularList                         = "api/v1/popular-list" //31
    case contributionList                    = "api/v1/contribution-list" //32
    case updateToken                         = "api/v1/update-device-token" //33
    case logout                              = "api/v1/logout" //34

    //31-03-21
    case videoViewUpdate                     = "api/v1/video-view-update" //35
    case videoLikeUpdate                     = "api/v1/video-like-update" //36
    case streamViewUpdate                    = "api/v1/stream-view-update" //37
    case streamLikeUpdate                    = "api/v1/stream-like-update" //38
    case profileAvatarUpdate                 = "api/v1/avatar-update" //39
    
    //01-04-21
    case blockedList                         = "api/v1/blocked-list" //40
    case messageUserList                     = "api/v1/messages-user-list" //41
    case profileCustomerLevel                = "api/v1/profile/customer-level" //42
    case withdrawalList                      = "api/v1/profile/account/withdraw-list" //43
    case vjCenterMyProfit                    = "api/v1/profile/vj-centre/my-profit" //44

    //02-04-21
    case videoGiftSend                       = "api/v1/video-gift-send" //45
    case streamTopFans                       = "api/v1/stream-top-fans" //46
    case videoTopFans                        = "api/v1/video-top-fans" //47
    case streamContributorList               = "api/v1/stream-contributor-list" //48
    case videoContributorList                = "api/v1/video-contributor-list" //49
    case vjCenterLegionFan                   = "api/v1/profile/vj-centre/legion-of-fan" //50
    
    //03-04-21
    case vjCenterContribution                = "api/v1/profile/vj-centre/contribution" //51
    case userVideoList                       = "api/v1/profile/user-video-list" //9

    //Not Used
    case smsResend                           = "api/v1/sms-resend" //1
    case streamCreate                        = "api/v1/stream-create" //2
    case streamCoverEdit                     = "api/v1/stream-cover-edit" //3
    case streamStart                         = "api/v1/stream-start" //4
    case streamStop                          = "api/v1/stream-stop" //5
    case blockedByList                       = "api/v1/blocked-by-list" //6
    case purchaseList                        = "api/v1/profile/account/purchase-list" //7
    case withdrawalRequest                   = "api/v1/profile/account/withdraw-request" //8
    case videoTopFansSingle                  = "api/v1/video-top-fan-single" //9
    case streamTopFansSingle                 = "api/v1/stream-top-fan-single" //10
    case guestUserFans                       = "api/v1/other/user-fans" //11
    case guestUserFollowing                  = "api/v1/other/user-following" //12
    case userStreamList                      = "api/v1/profile/user-stream-list" //13
    case vjCenterFollowing                   = "api/v1/profile/vj-centre/following" //14
    case fansList                            = "api/v1/fans-list" //15
    case giftList                            = "api/v1/gift-list" //11

    //Incomplete
    case messageList                         = "api/v1/messages-list" //1
    case videoCreate                         = "api/v1/video-create" //2
    case videoEdit                           = "api/v1/video-edit" //3
    case guestUserStreamList                 = "api/v1/other/user-stream-list" //10
    

    init(fromRawValue: String){
        self = Base(rawValue: fromRawValue) ?? Base.register
    }
    
    static func valueFor(Key : String?)->Base{
        guard let key = Key else {
            return Base.register
        }
        if let base = Base(rawValue: key) {
            return base
        }
        return Base.register
    }
}

