//
//  ZegoExpressEngine+Record.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (Record)

/// Starts to record locally captured audio or video and directly save the data to a file.
///
/// Currently only one task can be recorded simultaneously.
/// This function needs to be called after the success of [startPreview] or [startPublishingStream] to be effective.
/// Developers should not [stopPreview] or [stopPublishingStream] during recording, otherwise the SDK will end the current recording task.
/// Developers will receive the [onCapturedDataRecordStateUpdate] and the [onCapturedDataRecordProgressUpdate] callback after start recording.
///
/// @param config Record config
/// @param channel Publishing stream channel
- (void)startRecordingCapturedData:(ZegoDataRecordConfig *)config channel:(ZegoPublishChannel)channel;

/// Stops recording locally captured audio or video.
///
/// @param channel Publishing stream channel
- (void)stopRecordingCapturedData:(ZegoPublishChannel)channel;

/// Sets up the event callback handler for data recording.
///
/// Implemente the functions of ZegoDataRecordEventHandler to get notified when recode state and process changed
///
/// @param eventHandler Data record event handler
- (void)setDataRecordEventHandler:(nullable id<ZegoDataRecordEventHandler>)eventHandler;

@end

NS_ASSUME_NONNULL_END
