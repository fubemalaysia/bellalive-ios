//
//  ZegoExpressEngine+ReplayKit.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"
#if TARGET_OS_IPHONE
#import <ReplayKit/ReplayKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (ReplayKit)

#if TARGET_OS_IPHONE
/// Initialize the Express ReplayKit module.
///
/// Must be called before [createEngine] to take effect
/// Only use in the ReplayKit sub-process, don't use it in the main App process
- (void)prepareForReplayKit;
#endif

#if TARGET_OS_IPHONE
/// Handles ReplayKit's SampleBuffer, supports receiving video and audio buffer.
///
/// @param sampleBuffer Video or audio buffer returned by ReplayKit
/// @param bufferType Buffer type returned by ReplayKit
- (void)handleReplayKitSampleBuffer:(CMSampleBufferRef)sampleBuffer bufferType:(RPSampleBufferType)bufferType API_AVAILABLE(ios(10.0));
#endif

@end

NS_ASSUME_NONNULL_END
