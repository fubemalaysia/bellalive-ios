//
//  ZegoExpressEngine+Player.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (Player)

/// Starts playing a stream from ZEGO RTC server.
///
/// This function allows users to play audio and video streams from the ZEGO RTC server.
/// Before starting to play the stream, you need to join the room first, you can get the new streamID in the room by listening to the [onRoomStreamUpdate] event callback.
/// In the case of poor network quality, user play may be interrupted, the SDK will try to reconnect, and the current play status and error information can be obtained by listening to the [onPlayerStateUpdate] event.
/// Playing the stream ID that does not exist, the SDK continues to try to play after calling this function. After the stream ID is successfully published, the audio and video stream can be actually played.
/// The developer can update the player canvas by calling this function again (the streamID must be the same).
/// After the first play stream failure due to network reasons or the play stream is interrupted, the default time for SDK reconnection is 20min.
///
/// @param streamID Stream ID, a string of up to 256 characters. You cannot include URL keywords, otherwise publishing stream and playing stream will fails. Only support numbers, English characters and '~', '!', '@', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
/// @param canvas The view used to display the play audio and video stream's image. When the view is set to [nil], no video is displayed, only audio is played.
- (void)startPlayingStream:(NSString *)streamID canvas:(nullable ZegoCanvas *)canvas;

/// Starts playing a stream from ZEGO RTC server or from third-party CDN.
///
/// This function allows users to play audio and video streams both from the ZEGO RTC server or from third-party cdn.
/// Before starting to play the stream, you need to join the room first, you can get the new streamID in the room by listening to the [onRoomStreamUpdate] event callback.
/// In the case of poor network quality, user play may be interrupted, the SDK will try to reconnect, and the current play status and error information can be obtained by listening to the [onPlayerStateUpdate] event.
/// Playing the stream ID that does not exist, the SDK continues to try to play after calling this function. After the stream ID is successfully published, the audio and video stream can be actually played.
/// The developer can update the player canvas by calling this function again (the streamID must be the same).
/// After the first play stream failure due to network reasons or the play stream is interrupted, the default time for SDK reconnection is 20min.
///
/// @param streamID Stream ID, a string of up to 256 characters. You cannot include URL keywords, otherwise publishing stream and playing stream will fails. Only support numbers, English characters and '~', '!', '@', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
/// @param canvas The view used to display the play audio and video stream's image. When the view is set to [nil], no video is displayed, only audio is played.
/// @param config Advanced player configuration
- (void)startPlayingStream:(NSString *)streamID canvas:(nullable ZegoCanvas *)canvas config:(ZegoPlayerConfig *)config;

/// Stops playing a stream.
///
/// This function allows the user to stop playing the stream. When stopped, the attributes set for this stream previously, such as [setPlayVolume], [mutePlayStreamAudio], [mutePlayStreamVideo], etc., will be invalid and need to be reset when playing the the stream next time.
///
/// @param streamID Stream ID
- (void)stopPlayingStream:(NSString *)streamID;

/// Set decryption key for the playing stream.
///
/// Called before and after [startPlayingStream] can both take effect.
/// Calling [stopPlayingStream] or [logoutRoom] will clear the decryption key.
/// Support calling this function to update the decryption key while playing stream. Note that developers need to update the player's decryption key before updating the publisher's encryption key.
/// This function is only valid when playing stream from Zego RTC or L3 server.
///
/// @param key The decryption key, note that the key length only supports 16/24/32 bytes.
/// @param streamID Stream ID
- (void)setPlayStreamDecryptionKey:(NSString *)key streamID:(NSString *)streamID;

/// Take a snapshot of the playing stream.
///
/// Please call this function after calling [startPlayingStream]
///
/// @param streamID Stream ID to be snapshot
/// @param callback Results of take play stream snapshot
- (void)takePlayStreamSnapshot:(NSString *)streamID callback:(ZegoPlayerTakeSnapshotCallback)callback;

/// Sets the stream playback volume.
///
/// This function is used to set the playback volume of the stream. Need to be called after calling startPlayingStream.
/// You need to reset after [stopPlayingStream] and [startPlayingStream].
///
/// @param volume Volume percentage. The value ranges from 0 to 200, and the default value is 100.
/// @param streamID Stream ID.
- (void)setPlayVolume:(int)volume streamID:(NSString *)streamID;

/// Sets the all stream playback volume.
///
/// This function is used to set the sound size of all streaming streams, and the local user can control the playback volume of all audio streams.
///
/// @param volume Volume percentage. The value ranges from 0 to 200, and the default value is 100.
- (void)setAllPlayStreamVolume:(int)volume;

/// Set the selected video layer of playing stream.
///
/// When the publisher has set the codecID to SVC through [setVideoConfig], the player can dynamically set whether to use the standard layer or the base layer (the resolution of the base layer is one-half of the standard layer)
/// Under normal circumstances, when the network is weak or the rendered UI form is small, you can choose to use the video that plays the base layer to save bandwidth.
/// It can be set before and after playing stream.
///
/// @deprecated This function has been deprecated since version 2.3.0. Please use [setPlayStreamVideoType] instead.
/// @param videoLayer Video layer of playing stream. AUTO by default.
/// @param streamID Stream ID.
- (void)setPlayStreamVideoLayer:(ZegoPlayerVideoLayer)videoLayer streamID:(NSString *)streamID DEPRECATED_ATTRIBUTE;

/// Set play video stream type
///
/// When the publish stream sets the codecID to SVC through [setVideoConfig], the puller can dynamically set and select different stream types (small resolution is one-half of the standard layer).
/// In general, when the network is weak or the rendered UI window is small, you can choose to pull videos with small resolutions to save bandwidth.
/// It can be set before and after pulling the stream.
///
/// @param streamType Video stream type
/// @param streamID Stream ID.
- (void)setPlayStreamVideoType:(ZegoVideoStreamType)streamType streamID:(NSString *)streamID;

/// Set the adaptive adjustment interval range of the buffer for playing stream.
///
/// When the upper limit of the cache interval set by the developer exceeds 4000ms, the value will be 4000ms.
/// When the upper limit of the cache interval set by the developer is less than the lower limit of the cache interval, the upper limit will be automatically set as the lower limit.
/// It can be set before and after playing stream.
///
/// @param range The buffer adaptive interval range, in milliseconds. The default value is [0ms, 4000ms]
/// @param streamID Stream ID.
- (void)setPlayStreamBufferIntervalRange:(NSRange)range streamID:(NSString *)streamID;

/// Set the weight of the pull stream priority.
///
/// The stream that is set to focus will give priority to ensuring its quality. By default, all streams have the same weight.
/// When the local network is not good, while ensuring the focus flow, it may cause more jams.
///
/// @param streamID Stream ID.
- (void)setPlayStreamFocusOn:(NSString *)streamID;

/// Stops or resumes playing the audio part of a stream.
///
/// This function can be used to stop playing/retrieving the audio data of the stream. It can be called before and after playing the stream.
///
/// @param mute Mute flag, YES: mute play stream audio, NO: resume play stream audio
/// @param streamID Stream ID
- (void)mutePlayStreamAudio:(BOOL)mute streamID:(NSString *)streamID;

/// Stops or resumes playing the video part of a stream.
///
/// This function can be used to stop playing/retrieving the video data of the stream. It can be called before and after playing the stream.
///
/// @param mute mute flag, YES: mute play stream video, NO: resume play stream video
/// @param streamID Stream ID
- (void)mutePlayStreamVideo:(BOOL)mute streamID:(NSString *)streamID;

/// Stop or resume all pulled audio streams.
///
/// This function can be called when the stream is pulled, so that the audio data of all remote users is not pulled, and it can be called before and after the stream is pulled.
/// This function does not affect the life cycle of the `mutePlayStreamAudio` interface. This means that neither this function nor the `mutePlayStreamAudio` function must prohibit audio data before audio data can be received.
///
/// @param mute Mute flag, YES: mute play stream audio, NO: resume play stream audio
- (void)muteAllPlayStreamAudio:(BOOL)mute;

/// Stop or resume pulling all video streams.
///
/// This function can be called when the stream is pulled, so that the video data of all remote users is not pulled, and it can be called before and after the stream is pulled.
/// This function does not affect the life cycle of the `mutePlayStreamVideo` interface. This means that neither this function nor the `mutePlayStreamVideo` function prohibits video data before receiving video data.
///
/// @param mute mute flag, YES: mute play stream video, NO: resume play stream video
- (void)muteAllPlayStreamVideo:(BOOL)mute;

/// Enables or disables hardware decoding.
///
/// Turn on hardware decoding and use hardware to improve decoding efficiency. Need to be called before calling startPlayingStream.
/// Because hard-decoded support is not particularly good for a few models, SDK uses software decoding by default. If the developer finds that the device is hot when playing a high-resolution audio and video stream during testing of some models, you can consider calling this function to enable hard decoding.
///
/// @param enable Whether to turn on hardware decoding switch, YES: enable hardware decoding, NO: disable hardware decoding. The default is NO
- (void)enableHardwareDecoder:(BOOL)enable;

/// Enables or disables frame order detection.
///
/// @param enable Whether to turn on frame order detection, YES: enable check poc,not support B frames, NO: disable check poc, support B frames but the screen may temporary splash. The default is YES
- (void)enableCheckPoc:(BOOL)enable;

@end

NS_ASSUME_NONNULL_END
