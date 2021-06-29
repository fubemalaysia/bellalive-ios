//
//  ZegoExpressEngine+AudioEffectPlayer.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"
#import "ZegoExpressDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (AudioEffectPlayer)

/// Creates a audio effect player instance.
///
/// Currently, a maximum of 1 instances can be created, after which it will return nil.
///
/// @return audio effect player instance, nil will be returned when the maximum number is exceeded.
- (nullable ZegoAudioEffectPlayer *)createAudioEffectPlayer;

/// Destroys a audio effect player instance.
///
/// @param audioEffectPlayer The audio effect player instance object to be destroyed
- (void)destroyAudioEffectPlayer:(ZegoAudioEffectPlayer *)audioEffectPlayer;

@end

NS_ASSUME_NONNULL_END
