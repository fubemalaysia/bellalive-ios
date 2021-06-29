//
//  AVPlayerClass.swift
//  Bellalive
//
//  Created by APPLE on 26/06/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class AVPlayerClass: UIView{
    override static  var layerClass: AnyClass{
        return AVPlayerLayer.self
    }
    var playerLayer: AVPlayerLayer{
        return layer as! AVPlayerLayer
    }
    var player: AVPlayer?{
        get{
            return playerLayer.player
        }
        set{
            playerLayer.player = newValue
        }
    }
}
