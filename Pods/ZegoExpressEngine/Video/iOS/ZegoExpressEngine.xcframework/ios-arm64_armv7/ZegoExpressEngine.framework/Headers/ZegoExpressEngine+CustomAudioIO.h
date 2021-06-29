//
//  ZegoExpressEngine+CustomAudioIO.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (CustomAudioIO)

/// Enable local capture custom audio processing.
///
/// When enabled, developers can receive local captured audio frame through [onProcessCapturedAudioData], and can modify the audio data.
/// It needs to be invoked before [startPublishingStream], [startPlayingStream], [startPreview], [createMediaPlayer] and [createAudioEffectPlayer] to take effect.
///
/// @param enable Whether to enable local capture custom audio processing.
/// @param config Custom audio processing configuration.
- (void)enableCustomAudioCaptureProcessing:(BOOL)enable config:(ZegoCustomAudioProcessConfig *)config;

/// Enable custom audio processing for remote playing stream.
///
/// When enabled, developers can receive audio frame from remote playing stream through [onProcessRemoteAudioData], and can modify the audio data.
/// It needs to be invoked before [startPublishingStream], [startPlayingStream], [startPreview], [createMediaPlayer] and [createAudioEffectPlayer] to take effect.
///
/// @param enable Whether to enable custom audio processing for remote playing stream.
/// @param config Custom audio processing configuration.
- (void)enableCustomAudioRemoteProcessing:(BOOL)enable config:(ZegoCustomAudioProcessConfig *)config;

/// Set up callback handler for custom audio processing.
///
/// Developers can modify the processing of audio frame data in the callback.
///
/// @param handler Callback handler for custom audio processing.
- (void)setCustomAudioProcessHandler:(nullable id<ZegoCustomAudioProcessHandler>)handler;

/// Enables the callback for receiving audio data.
///
/// The callback to the corresponding setting of [setAudioDataHandler] is triggered when this function is called and at publishing stream state or playing stream state. If you want to enable the [onPlayerAudioData] callback, the sample rate passed in by calling the [enableAudioDataCallback] function does not support 8000Hz, 22050Hz and 24000Hz.
///
/// @deprecated This function has been deprecated since version 2.7.0, please use [startAudioDataObserver] instead.
/// @param enable Whether to enable audio data callback
/// @param callbackBitMask The callback function bitmask marker for receive audio data, refer to enum [ZegoAudioDataCallbackBitMask], when this param converted to binary, 0b01 that means 1 << 0 for triggering [onCapturedAudioData], 0x10 that means 1 << 1 for triggering [onPlaybackAudioData], 0x100 that means 1 << 2 for triggering [onMixedAudioData], 0x1000 that means 1 << 3 for triggering [onPlayerAudioData]. The masks can be combined to allow different callbacks to be triggered simultaneously.
/// @param param param of audio frame
- (void)enableAudioDataCallback:(BOOL)enable callbackBitMask:(ZegoAudioDataCallbackBitMask)callbackBitMask param:(ZegoAudioFrameParam *)param DEPRECATED_ATTRIBUTE;

/// Enable audio data observering
///
/// It will only be triggered after this function is called and the callback has been set by calling [setAudioDataHandler]. If you want to enable the [onPlayerAudioData] callback, you must also be playing stream, and the sampling rate passed in by calling the [startAudioDataObserver] function does not support 8000Hz, 22050Hz, and 24000Hz.
///
/// @param observerBitMask The callback function bitmask marker for receive audio data, refer to enum [ZegoAudioDataCallbackBitMask], when this param converted to binary, 0b01 that means 1 << 0 for triggering [onCapturedAudioData], 0x10 that means 1 << 1 for triggering [onPlaybackAudioData], 0x100 that means 1 << 2 for triggering [onMixedAudioData], 0x1000 that means 1 << 3 for triggering [onPlayerAudioData]. The masks can be combined to allow different callbacks to be triggered simultaneously.
/// @param param param of audio frame
- (void)startAudioDataObserver:(ZegoAudioDataCallbackBitMask)observerBitMask param:(ZegoAudioFrameParam *)param;

/// Disable audio data observering
- (void)stopAudioDataObserver;

/// Sets up the event callback handler for receiving audio data.
///
/// You can call this function to receive audio data from the SDK when you need to get the audio data of the remote user or get the data collected by the local microphone for other purposes (such as audio-only recording, audio-only third-party monitoring, and audio-only real-time analysis).
/// The set callback needs to be after the call to [enableAudioDataCallback] and in a publishing or playing stream state for the callback to work.
/// The format of the audio data callback by SDK is pcm. The SDK still controls the collection and playback of the sound device. This function is to copy a piece of data collected or played inside the SDK to the developer for use.
///
/// @param handler Audio data handler for receive audio data
- (void)setAudioDataHandler:(nullable id<ZegoAudioDataHandler>)handler;

/// Enables the custom audio I/O function.
///
/// It needs to be invoked before [startPublishingStream], [startPlayingStream], [startPreview], [createMediaPlayer] and [createAudioEffectPlayer] to take effect.
///
/// @param enable Whether to enable custom audio IO, default is NO
/// @param config Custom audio IO config
- (void)enableCustomAudioIO:(BOOL)enable config:(nullable ZegoCustomAudioConfig *)config;

/// Enables the custom audio I/O function (for the specified channel).
///
/// It needs to be invoked before [startPublishingStream], [startPlayingStream], [startPreview], [createMediaPlayer] and [createAudioEffectPlayer] to take effect.
///
/// @param enable Whether to enable custom audio IO, default is NO
/// @param config Custom audio IO config
/// @param channel Specify the publish channel to enable custom audio IO
- (void)enableCustomAudioIO:(BOOL)enable config:(nullable ZegoCustomAudioConfig *)config channel:(ZegoPublishChannel)channel;

/// Sends AAC audio data produced by custom audio capture to the SDK.
///
/// @param data AAC buffer data
/// @param dataLength The total length of the buffer data
/// @param configLength The length of AAC specific config (Note: The AAC encoded data length is 'encodedLength = dataLength - configLength')
/// @param timestamp The UNIX timestamp of this AAC audio frame
/// @param param The param of this AAC audio frame
- (void)sendCustomAudioCaptureAACData:(unsigned char *)data dataLength:(unsigned int)dataLength configLength:(unsigned int)configLength timestamp:(CMTime)timestamp param:(ZegoAudioFrameParam *)param;

/// Sends AAC audio data produced by custom audio capture to the SDK (for the specified channel).
///
/// @param data AAC buffer data
/// @param dataLength The total length of the buffer data
/// @param configLength The length of AAC specific config (Note: The AAC encoded data length is 'encodedLength = dataLength - configLength')
/// @param timestamp The UNIX timestamp of this AAC audio frame
/// @param param The param of this AAC audio frame
/// @param channel Publish channel for capturing audio frames
- (void)sendCustomAudioCaptureAACData:(unsigned char *)data dataLength:(unsigned int)dataLength configLength:(unsigned int)configLength timestamp:(CMTime)timestamp param:(ZegoAudioFrameParam *)param channel:(ZegoPublishChannel)channel;

/// Sends PCM audio data produced by custom audio capture to the SDK.
///
/// @param data PCM buffer data
/// @param dataLength The total length of the buffer data
/// @param param The param of this PCM audio frame
- (void)sendCustomAudioCapturePCMData:(unsigned char *)data dataLength:(unsigned int)dataLength param:(ZegoAudioFrameParam *)param;

/// Sends PCM audio data produced by custom audio capture to the SDK (for the specified channel).
///
/// @param data PCM buffer data
/// @param dataLength The total length of the buffer data
/// @param param The param of this PCM audio frame
/// @param channel Publish channel for capturing audio frames
- (void)sendCustomAudioCapturePCMData:(unsigned char *)data dataLength:(unsigned int)dataLength param:(ZegoAudioFrameParam *)param channel:(ZegoPublishChannel)channel;

/// Fetches PCM audio data of the remote stream for custom audio rendering.
///
/// It is recommended to use the system framework to periodically invoke this function to drive audio data rendering
///
/// @param data A block of memory for storing audio PCM data that requires user to manage the memory block's lifecycle, the SDK will copy the audio frame rendering data to this memory block
/// @param dataLength The length of the audio data to be fetch this time (dataLength = duration * sampleRate * channels * 2(16 bit depth i.e. 2 Btye))
/// @param param Specify the parameters of the fetched audio frame
- (void)fetchCustomAudioRenderPCMData:(unsigned char *)data dataLength:(unsigned int)dataLength param:(ZegoAudioFrameParam *)param;

@end

NS_ASSUME_NONNULL_END
