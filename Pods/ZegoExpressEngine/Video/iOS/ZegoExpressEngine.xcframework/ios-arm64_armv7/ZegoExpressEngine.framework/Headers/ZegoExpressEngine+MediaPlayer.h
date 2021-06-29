//
//  ZegoExpressEngine+MediaPlayer.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"
#import "ZegoExpressDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (MediaPlayer)

/// Creates a media player instance.
///
/// Currently, a maximum of 4 instances can be created, after which it will return nil. The more instances of a media player, the greater the performance overhead on the device.
///
/// @return Media player instance, nil will be returned when the maximum number is exceeded.
- (nullable ZegoMediaPlayer *)createMediaPlayer;

/// Destroys a media player instance.
///
/// @param mediaPlayer The media player instance object to be destroyed
- (void)destroyMediaPlayer:(ZegoMediaPlayer *)mediaPlayer;

@end

NS_ASSUME_NONNULL_END
