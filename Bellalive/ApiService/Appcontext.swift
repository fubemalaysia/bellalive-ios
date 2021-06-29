//
//  Appcontext.swift
//  Bellalive
//
//  Created by apple on 15/02/21.
//  Copyright © 2021 APPLE. All rights reserved.
//

import Foundation
import UIKit

class Appcontext {
    static let shared = Appcontext()
    var user : UserProfileData?
    var followingUserList = [FollowingUserListData]()
    var followingUserVideo = [FollowingUserVideoData]()
    var followingStreamList = [FollowingStreamListData]()
    
    var searchUserData = [SearchData]()
    var searchLiveData = [SearchVideoDataDatum]()
    var searchVideoData = [SearchVideoDataDatum]()
}

