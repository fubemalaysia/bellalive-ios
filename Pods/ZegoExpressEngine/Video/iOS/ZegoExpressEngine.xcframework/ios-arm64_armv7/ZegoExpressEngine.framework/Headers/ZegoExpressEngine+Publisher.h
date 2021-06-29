//
//  ZegoExpressEngine+Publisher.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (Publisher)

/// Starts publishing a stream.
///
/// This function allows users to publish their local audio and video streams to the ZEGO RTC server. Other users in the same room can use the streamID to play the audio and video streams for intercommunication.
/// Before you start to publish the stream, you need to join the room first by calling [loginRoom]. Other users in the same room can get the streamID by monitoring the [onRoomStreamUpdate] event callback after the local user publishing stream successfully.
/// In the case of poor network quality, user publish may be interrupted, and the SDK will attempt to reconnect. You can learn about the current state and error information of the stream published by monitoring the [onPublisherStateUpdate] event.
/// After the first publish stream failure due to network reasons or the publish stream is interrupted, the default time for SDK reconnection is 20min.
///
/// @param streamID Stream ID, a string of up to 256 characters, needs to be globally unique within the entire AppID. If in the same AppID, different users publish each stream and the stream ID is the same, which will cause the user to publish the stream failure. You cannot include URL keywords, otherwise publishing stream and playing stream will fails. Only support numbers, English characters and '~', '!', '@', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
- (void)startPublishingStream:(NSString *)streamID;

/// Starts publishing a stream (for the specified channel). You can call this function to publish a second stream.
///
/// This function allows users to publish their local audio and video streams to the ZEGO RTC server. Other users in the same room can use the streamID to play the audio and video streams for intercommunication.
/// Before you start to publish the stream, you need to join the room first by calling [loginRoom]. Other users in the same room can get the streamID by monitoring the [onRoomStreamUpdate] event callback after the local user publishing stream successfully.
/// In the case of poor network quality, user publish may be interrupted, and the SDK will attempt to reconnect. You can learn about the current state and error information of the stream published by monitoring the [onPublisherStateUpdate] event.
/// After the first publish stream failure due to network reasons or the publish stream is interrupted, the default time for SDK reconnection is 20min.
///
/// @param streamID Stream ID, a string of up to 256 characters, needs to be globally unique within the entire AppID. If in the same AppID, different users publish each stream and the stream ID is the same, which will cause the user to publish the stream failure. You cannot include URL keywords, otherwise publishing stream and playing stream will fails. Only support numbers, English characters and '~', '!', '@', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
/// @param channel Publish stream channel
- (void)startPublishingStream:(NSString *)streamID channel:(ZegoPublishChannel)channel;

/// Stops publishing a stream.
///
/// This function allows the user to stop sending local audio and video streams and end the call.
/// If the user has initiated publish flow, this function must be called to stop the publish of the current stream before publishing the new stream (new streamID), otherwise the new stream publish will return a failure.
/// After stopping streaming, the developer should stop the local preview based on whether the business situation requires it.
- (void)stopPublishingStream;

/// Stops publishing a stream (for the specified channel).
///
/// This function allows the user to stop sending local audio and video streams and end the call.
/// If the user has initiated publish flow, this function must be called to stop the publish of the current stream before publishing the new stream (new streamID), otherwise the new stream publish will return a failure.
/// After stopping streaming, the developer should stop the local preview based on whether the business situation requires it.
/// Use this function to stop publishing stream of aux channel.
///
/// @param channel Publish stream channel
- (void)stopPublishingStream:(ZegoPublishChannel)channel;

/// Sets the extra information of the stream being published.
///
/// Use this function to set the extra info of the stream, the result will be notified via the [ZegoPublisherSetStreamExtraInfoCallback].
/// The stream extra information is an extra information identifier of the stream ID. Unlike the stream ID, which cannot be modified during the publishing process, the stream extra information can be modified midway through the stream corresponding to the stream ID.
/// Developers can synchronize variable content related to stream IDs based on stream additional information.
///
/// @param extraInfo Stream extra information, a string of up to 1024 characters.
/// @param callback Set stream extra information execution result notification
- (void)setStreamExtraInfo:(NSString *)extraInfo callback:(nullable ZegoPublisherSetStreamExtraInfoCallback)callback;

/// Sets the extra information of the stream being published (for the specified channel).
///
/// Use this function to set the extra info of the stream, the result will be notified via the [ZegoPublisherSetStreamExtraInfoCallback].
/// The stream extra information is an extra information identifier of the stream ID. Unlike the stream ID, which cannot be modified during the publishing process, the stream extra information can be modified midway through the stream corresponding to the stream ID.
/// Developers can synchronize variable content related to stream IDs based on stream additional information.
///
/// @param extraInfo Stream extra information, a string of up to 1024 characters.
/// @param channel Publish stream channel
/// @param callback Set stream extra information execution result notification
- (void)setStreamExtraInfo:(NSString *)extraInfo channel:(ZegoPublishChannel)channel callback:(nullable ZegoPublisherSetStreamExtraInfoCallback)callback;

/// Starts/Updates the local video preview.
///
/// The user can see his own local image by calling this function. The preview function does not require you to log in to the room or publish the stream first. But after exiting the room, SDK internally actively stops previewing by default.
/// Local view and preview modes can be updated by calling this function again.
/// You can set the mirror mode of the preview by calling the [setVideoMirrorMode] function. The default preview setting is image mirrored.
/// When this function is called, the audio and video engine module inside SDK will start really, and it will start to try to collect audio and video. In addition to calling this function normally to preview the local screen, developers can also pass [nil] to the canvas parameter, in conjunction with ZegoExpressEngine's sound wave function, in order to achieve the purpose of detecting whether the audio equipment is working properly before logging in to the room.
///
/// @param canvas The view used to display the preview image. If the view is set to nil, no preview will be made.
- (void)startPreview:(nullable ZegoCanvas *)canvas;

/// Starts/Updates the local video preview (for the specified channel).
///
/// The user can see his own local image by calling this function. The preview function does not require you to log in to the room or publish the stream first. But after exiting the room, SDK internally actively stops previewing by default.
/// Local view and preview modes can be updated by calling this function again.
/// You can set the mirror mode of the preview by calling the [setVideoMirrorMode] function. The default preview setting is image mirrored.
/// When this function is called, the audio and video engine module inside SDK will start really, and it will start to try to collect audio and video. In addition to calling this function normally to preview the local screen, developers can also pass [nil] to the canvas parameter, in conjunction with ZegoExpressEngine's sound wave function, in order to achieve the purpose of detecting whether the audio equipment is working properly before logging in to the room.
///
/// @param canvas The view used to display the preview image. If the view is set to nil, no preview will be made.
/// @param channel Publish stream channel
- (void)startPreview:(nullable ZegoCanvas *)canvas channel:(ZegoPublishChannel)channel;

/// Stops the local video preview.
///
/// This function can be called to stop previewing when there is no need to see the preview locally.
- (void)stopPreview;

/// Stops the local video preview (for the specified channel).
///
/// This function can be called to stop previewing when there is no need to see the preview locally.
///
/// @param channel Publish stream channel
- (void)stopPreview:(ZegoPublishChannel)channel;

/// Sets up the video configurations.
///
/// This function can be used to set the video frame rate, bit rate, video capture resolution, and video encoding output resolution. If you do not call this function, the default resolution is 360p, the bit rate is 600 kbps, and the frame rate is 15 fps.
/// It is necessary to set the relevant video configuration before publishing the stream or startPreview, and only support the modification of the encoding resolution and the bit rate after publishing the stream.
/// Developers should note that the wide and high resolution of the mobile end is opposite to the wide and high resolution of the PC. For example, in the case of 360p, the resolution of the mobile end is 360x640, and the resolution of the PC end is 640x360.
///
/// @param config Video configuration, the SDK provides a common setting combination of resolution, frame rate and bit rate, they also can be customized.
- (void)setVideoConfig:(ZegoVideoConfig *)config;

/// Sets up the video configurations (for the specified channel).
///
/// This function can be used to set the video frame rate, bit rate, video capture resolution, and video encoding output resolution. If you do not call this function, the default resolution is 360p, the bit rate is 600 kbps, and the frame rate is 15 fps.
/// It is necessary to set the relevant video configuration before publishing the stream, and only support the modification of the encoding resolution and the bit rate after publishing the stream.
/// Developers should note that the wide and high resolution of the mobile end is opposite to the wide and high resolution of the PC. For example, in the case of 360p, the resolution of the mobile end is 360x640, and the resolution of the PC end is 640x360.
///
/// @param config Video configuration, the SDK provides a common setting combination of resolution, frame rate and bit rate, they also can be customized.
/// @param channel Publish stream channel
- (void)setVideoConfig:(ZegoVideoConfig *)config channel:(ZegoPublishChannel)channel;

/// Gets the current video configurations.
///
/// This function can be used to get the main publish channel's current video frame rate, bit rate, video capture resolution, and video encoding output resolution.
///
/// @return Video configuration object
- (ZegoVideoConfig *)getVideoConfig;

/// Gets the current video configurations (for the specified channel).
///
/// This function can be used to get the specified publish channel's current video frame rate, bit rate, video capture resolution, and video encoding output resolution.
///
/// @param channel Publish stream channel
/// @return Video configuration object
- (ZegoVideoConfig *)getVideoConfig:(ZegoPublishChannel)channel;

/// Sets the video mirroring mode.
///
/// This function can be called to set whether the local preview video and the published video have mirror mode enabled.
///
/// @param mirrorMode Mirror mode for previewing or publishing the stream
- (void)setVideoMirrorMode:(ZegoVideoMirrorMode)mirrorMode;

/// Sets the video mirroring mode (for the specified channel).
///
/// This function can be called to set whether the local preview video and the published video have mirror mode enabled.
///
/// @param mirrorMode Mirror mode for previewing or publishing the stream
/// @param channel Publish stream channel
- (void)setVideoMirrorMode:(ZegoVideoMirrorMode)mirrorMode channel:(ZegoPublishChannel)channel;

#if TARGET_OS_IPHONE
/// Sets the video orientation.
///
/// This function sets the orientation of the video. The captured image is rotated according to the value of the parameter [UIInterfaceOrientation] compared to the forward direction of the phone. After rotation, it will be automatically adjusted to adapt the encoded image resolution.
///
/// @param orientation Video orientation
- (void)setAppOrientation:(UIInterfaceOrientation)orientation;
#endif

#if TARGET_OS_IPHONE
/// Sets the video orientation (for the specified channel).
///
/// This function sets the orientation of the video. The captured image is rotated according to the value of the parameter [UIInterfaceOrientation] compared to the forward direction of the phone. After rotation, it will be automatically adjusted to adapt the encoded image resolution.
///
/// @param orientation Video orientation
/// @param channel Publish stream channel
- (void)setAppOrientation:(UIInterfaceOrientation)orientation channel:(ZegoPublishChannel)channel;
#endif

/// Sets up the audio configurations.
///
/// You can set the combined value of the audio codec, bit rate, and audio channel through this function. If this function is not called, the default is standard quality mode. Should be used before publishing.
/// If the preset value cannot meet the developer's scenario, the developer can set the parameters according to the business requirements.
///
/// @param config Audio config
- (void)setAudioConfig:(ZegoAudioConfig *)config;

/// Sets up the audio configurations.
///
/// You can set the combined value of the audio codec, bit rate, and audio channel through this function. If this function is not called, the default is standard quality mode. Should be used before publishing.
/// If the preset value cannot meet the developer's scenario, the developer can set the parameters according to the business requirements.
///
/// @param config Audio config
/// @param channel Publish stream channel
- (void)setAudioConfig:(ZegoAudioConfig *)config channel:(ZegoPublishChannel)channel;

/// Gets the current audio configurations.
///
/// You can get the current audio codec, bit rate, and audio channel through this function.
///
/// @return Audio config
- (ZegoAudioConfig *)getAudioConfig;

/// Gets the current audio configurations.
///
/// You can get the current audio codec, bit rate, and audio channel through this function.
///
/// @param channel Publish stream channel
/// @return Audio config
- (ZegoAudioConfig *)getAudioConfig:(ZegoPublishChannel)channel;

/// Set encryption key for the publishing stream.
///
/// Called before and after [startPublishingStream] can both take effect.
/// Calling [stopPublishingStream] or [logoutRoom] will clear the encryption key.
/// Support calling this function to update the encryption key while publishing stream. Note that developers need to update the player's decryption key before updating the publisher's encryption key.
/// This function is only valid when publishing stream to the Zego RTC server.
///
/// @param key The encryption key, note that the key length only supports 16/24/32 bytes.
- (void)setPublishStreamEncryptionKey:(NSString *)key;

/// Set encryption key for the publishing stream.
///
/// Called before and after [startPublishingStream] can both take effect.
/// Calling [stopPublishingStream] or [logoutRoom] will clear the encryption key.
/// Support calling this function to update the encryption key while publishing stream. Note that developers need to update the player's decryption key before updating the publisher's encryption key.
/// This function is only valid when publishing stream to the Zego RTC server.
///
/// @param key The encryption key, note that the key length only supports 16/24/32 bytes.
/// @param channel Publish stream channel
- (void)setPublishStreamEncryptionKey:(NSString *)key channel:(ZegoPublishChannel)channel;

/// Take a snapshot of the publishing stream.
///
/// Please call this function after calling [startPublishingStream] or [startPreview]
/// The resolution of the snapshot is the encoding resolution set in [setVideoConfig]. If you need to change it to capture resolution, please call [setCapturePipelineScaleMode] to change the capture pipeline scale mode to [Post]
///
/// @param callback Results of take publish stream snapshot
- (void)takePublishStreamSnapshot:(ZegoPublisherTakeSnapshotCallback)callback;

/// Take a snapshot of the publishing stream (for the specified channel).
///
/// Please call this function after calling [startPublishingStream] or [startPreview]
/// The resolution of the snapshot is the encoding resolution set in [setVideoConfig]. If you need to change it to capture resolution, please call [setCapturePipelineScaleMode] to change the capture pipeline scale mode to [Post]
///
/// @param callback Results of take publish stream snapshot
/// @param channel Publish stream channel
- (void)takePublishStreamSnapshot:(ZegoPublisherTakeSnapshotCallback)callback channel:(ZegoPublishChannel)channel;

/// Stops or resumes sending the audio part of a stream.
///
/// This function can be called when publishing the stream to realize not publishing the audio data stream. The SDK still collects and processes the audio, but does not send the audio data to the network. It can be set before and after publishing.
/// If you stop sending audio streams, the remote user that play stream of local user publishing stream can receive `Mute` status change notification by monitoring [onRemoteMicStateUpdate] callbacks,
///
/// @param mute Whether to stop sending audio streams, YES means not to send audio stream, and NO means sending audio stream. The default is NO.
- (void)mutePublishStreamAudio:(BOOL)mute;

/// Stops or resumes sending the audio part of a stream (for the specified channel).
///
/// This function can be called when publishing the stream to realize not publishing the audio data stream. The SDK still collects and processes the audio, but does not send the audio data to the network. It can be set before and after publishing.
/// If you stop sending audio streams, the remote user that play stream of local user publishing stream can receive `Mute` status change notification by monitoring [onRemoteMicStateUpdate] callbacks,
///
/// @param mute Whether to stop sending audio streams, YES means not to send audio stream, and NO means sending audio stream. The default is NO.
/// @param channel Publish stream channel
- (void)mutePublishStreamAudio:(BOOL)mute channel:(ZegoPublishChannel)channel;

/// Stops or resumes sending the video part of a stream.
///
/// This function can be called when publishing the stream to realize not publishing the video stream. The local camera can still work normally, can capture, preview and process video images normally, but does not send the video data to the network. It can be set before and after publishing.
/// If you stop sending video streams locally, the remote user that play stream of local user publishing stream can receive `Mute` status change notification by monitoring [onRemoteCameraStateUpdate] callbacks,
///
/// @param mute Whether to stop sending video streams, YES means not to send video stream, and NO means sending video stream. The default is NO.
- (void)mutePublishStreamVideo:(BOOL)mute;

/// Stops or resumes sending the video part of a stream (for the specified channel).
///
/// This function can be called when publishing the stream to realize not publishing the video stream. The local camera can still work normally, can capture, preview and process video images normally, but does not send the video data to the network. It can be set before and after publishing.
/// If you stop sending video streams locally, the remote user that play stream of local user publishing stream can receive `Mute` status change notification by monitoring [onRemoteCameraStateUpdate] callbacks,
///
/// @param mute Whether to stop sending video streams, YES means not to send video stream, and NO means sending video stream. The default is NO.
/// @param channel Publish stream channel
- (void)mutePublishStreamVideo:(BOOL)mute channel:(ZegoPublishChannel)channel;

/// Enables or disables traffic control.
///
/// Traffic control enables SDK to dynamically adjust the bitrate of audio and video streaming according to its own and peer current network environment status.
/// Automatically adapt to the current network environment and fluctuations, so as to ensure the smooth publishing of stream.
///
/// @param enable Whether to enable traffic control. The default is ture.
/// @param property Adjustable property of traffic control, bitmask format. Should be one or the combinations of [ZegoTrafficControlProperty] enumeration. [AdaptiveFPS] as default.
- (void)enableTrafficControl:(BOOL)enable property:(ZegoTrafficControlProperty)property;

/// Enables or disables traffic control.
///
/// Traffic control enables SDK to dynamically adjust the bitrate of audio and video streaming according to its own and peer current network environment status.
/// Automatically adapt to the current network environment and fluctuations, so as to ensure the smooth publishing of stream.
///
/// @param enable Whether to enable traffic control. The default is ture.
/// @param property Adjustable property of traffic control, bitmask format. Should be one or the combinations of [ZegoTrafficControlProperty] enumeration. [AdaptiveFPS] as default.
/// @param channel Publish stream channel
- (void)enableTrafficControl:(BOOL)enable property:(ZegoTrafficControlProperty)property channel:(ZegoPublishChannel)channel;

/// Set the minimum video bitrate threshold for traffic control.
///
/// Set how should SDK send video data when the network conditions are poor and the minimum video bitrate threshold cannot be met.
/// When this function is not called, the SDK will automatically adjust the sent video data frames according to the current network uplink conditions by default.
///
/// @param bitrate Minimum video bitrate threshold for traffic control(kbps)
/// @param mode Video sending mode below the minimum bitrate.
- (void)setMinVideoBitrateForTrafficControl:(int)bitrate mode:(ZegoTrafficControlMinVideoBitrateMode)mode;

/// Sets the minimum video bitrate for traffic control.
///
/// Set how should SDK send video data when the network conditions are poor and the minimum video bitrate cannot be met.
/// When this function is not called, the SDK will automatically adjust the sent video data frames according to the current network uplink conditions by default.
///
/// @param bitrate Minimum video bitrate (kbps)
/// @param mode Video sending mode below the minimum bitrate.
/// @param channel Publish stream channel
- (void)setMinVideoBitrateForTrafficControl:(int)bitrate mode:(ZegoTrafficControlMinVideoBitrateMode)mode channel:(ZegoPublishChannel)channel;

/// Set the factors of concern that trigger traffic control
///
/// When the traffic control of the specified push channel is enabled through the enableTrafficControl interface, the interface can be used to control whether the traffic control is started due to poor remote network conditions
/// The function is valid before the stream is pushed. If you do not reset the settings before each push, you will continue to use the last configuration.
///
/// @param mode When LOCAL_ONLY is selected, only the local network status is concerned. When choosing REMOTE, also take into account the remote network.
- (void)setTrafficControlFocusOn:(ZegoTrafficControlFocusOnMode)mode;

/// Set the factors of concern that trigger traffic control
///
/// When the traffic control of the specified push channel is enabled through the enableTrafficControl interface, the interface can be used to control whether the traffic control is started due to poor remote network conditions
/// The function is valid before the stream is pushed. If you do not reset the settings before each push, you will continue to use the last configuration.
///
/// @param mode When LOCAL_ONLY is selected, only the local network status is concerned. When choosing REMOTE, also take into account the remote network.
/// @param channel Publish stream channel
- (void)setTrafficControlFocusOn:(ZegoTrafficControlFocusOnMode)mode channel:(ZegoPublishChannel)channel;

/// Sets the audio recording volume for stream publishing.
///
/// This function is used to set the audio collection volume. The local user can control the volume of the audio stream sent to the far end. It can be set before publishing.
///
/// @param volume Volume percentage. The range is 0 to 200. Default value is 100.
- (void)setCaptureVolume:(int)volume;

/// Set audio capture stereo mode.
///
/// This function is used to set the audio stereo capture mode. The default is mono, that is, dual channel collection is not enabled.
/// It needs to be invoked before [startPublishingStream], [startPlayingStream], [startPreview], [createMediaPlayer] and [createAudioEffectPlayer] to take effect.
///
/// @param mode Audio stereo capture mode
- (void)setAudioCaptureStereoMode:(ZegoAudioCaptureStereoMode)mode;

/// Adds a target CDN URL to which the stream will be relayed from ZEGO RTC server.
///
/// Developers can call this function to publish the audio and video streams that have been published to the ZEGO RTC server to a custom CDN content distribution network that has high latency but supports high concurrent playing stream.
/// Because this called function is essentially a dynamic relay of the audio and video streams published to the ZEGO RTC server to different CDNs, this function needs to be called after the audio and video stream is published to ZEGO RTC server successfully.
/// Since ZEGO RTC server itself can be configured to support CDN(content distribution networks), this function is mainly used by developers who have CDN content distribution services themselves.
/// You can use ZEGO's CDN audio and video streaming content distribution service at the same time by calling this function and then use the developer who owns the CDN content distribution service.
/// This function supports dynamic relay to the CDN content distribution network, so developers can use this function as a disaster recovery solution for CDN content distribution services.
/// When the [enablePublishDirectToCDN] function is set to YES to publish the stream straight to the CDN, then calling this function will have no effect.
///
/// @param targetURL CDN relay address, supported address format is rtmp.
/// @param streamID Stream ID
/// @param callback The execution result of update the relay CDN operation
- (void)addPublishCdnUrl:(NSString *)targetURL streamID:(NSString *)streamID callback:(nullable ZegoPublisherUpdateCdnUrlCallback)callback;

/// Deletes the specified CDN URL, which is used for relaying streams from ZEGO RTC server to CDN.
///
/// This function is called when a CDN relayed address has been added and needs to stop propagating the stream to the CDN.
/// This function does not stop publishing audio and video stream to the ZEGO ZEGO RTC server.
///
/// @param targetURL CDN relay address, supported address format rtmp.
/// @param streamID Stream ID
/// @param callback The execution result of update the relay CDN operation
- (void)removePublishCdnUrl:(NSString *)targetURL streamID:(NSString *)streamID callback:(nullable ZegoPublisherUpdateCdnUrlCallback)callback;

/// Whether to publish streams directly from the client to CDN without passing through Zego RTC server.
///
/// This function needs to be set before [startPublishingStream].
/// After calling this function to publish the audio and video stream directly to the CDN, calling [addPublishCdnUrl] and [removePublishCdnUrl] to dynamically relay to the CDN no longer takes effect,
/// because these two functions are to relay or stop relaying the audio and video stream from ZEGO RTC server to CDN,
/// if you enable the direct publish of audio and video streams to CDN, you will not be able to dynamically relay the audio and video streams to the CDN through the ZEGO RTC server.
///
/// @param enable Whether to enable direct publish CDN, YES: enable direct publish CDN, NO: disable direct publish CDN
/// @param config CDN configuration, if nil, use Zego's background default configuration
- (void)enablePublishDirectToCDN:(BOOL)enable config:(nullable ZegoCDNConfig *)config;

/// Whether to publish streams directly from the client to CDN without passing through Zego RTC server (for the specified channel).
///
/// This function needs to be set before [startPublishingStream].
/// After calling this function to publish the audio and video stream directly to the CDN, calling [addPublishCdnUrl] and [removePublishCdnUrl] to dynamically relay to the CDN no longer takes effect,
/// because these two functions are to relay or stop relaying the audio and video stream from ZEGO RTC server to CDN,
/// if you enable the direct publish of audio and video streams to CDN, you will not be able to dynamically relay the audio and video streams to the CDN through the ZEGO RTC server.
///
/// @param enable Whether to enable direct publish CDN, YES: enable direct publish CDN, NO: disable direct publish CDN
/// @param config CDN configuration, if nil, use Zego's background default configuration
/// @param channel Publish stream channel
- (void)enablePublishDirectToCDN:(BOOL)enable config:(nullable ZegoCDNConfig *)config channel:(ZegoPublishChannel)channel;

/// Sets up the stream watermark before stream publishing.
///
/// The layout of the watermark cannot exceed the video encoding resolution of the stream. It can be set at any time before or during the publishing stream
///
/// @param watermark The upper left corner of the watermark layout is the origin of the coordinate system, and the area cannot exceed the size set by the encoding resolution. If it is nil, the watermark is cancelled.
/// @param isPreviewVisible Whether the watermark can be seen in the local preview.
- (void)setPublishWatermark:(nullable ZegoWatermark *)watermark isPreviewVisible:(BOOL)isPreviewVisible;

/// Sets up the stream watermark before stream publishing (for the specified channel).
///
/// The layout of the watermark cannot exceed the video encoding resolution of the stream. It can be set at any time before or during the publishing stream.
///
/// @param watermark The upper left corner of the watermark layout is the origin of the coordinate system, and the area cannot exceed the size set by the encoding resolution. If it is nil, the watermark is cancelled.
/// @param isPreviewVisible the watermark is visible on local preview
/// @param channel Publish stream channel
- (void)setPublishWatermark:(nullable ZegoWatermark *)watermark isPreviewVisible:(BOOL)isPreviewVisible channel:(ZegoPublishChannel)channel;

/// Set the Supplemental Enhancement Information type
///
/// It must be set before [startPublishingStream].
///
/// @param config SEI configuration. The SEI defined by ZEGO is used by default.
- (void)setSEIConfig:(ZegoSEIConfig *)config;

/// Sends Supplemental Enhancement Information.
///
/// This function can synchronize some other additional information while the developer publishes streaming audio and video streaming data while sending streaming media enhancement supplementary information.
/// Generally, for scenarios such as synchronizing music lyrics or precise layout of video canvas, you can choose to use this function.
/// After the anchor sends the SEI, the audience can obtain the SEI content by monitoring the callback of [onPlayerRecvSEI].
/// Since SEI information follows video frames, and because of network problems, frames may be dropped, so SEI information may also be dropped. To solve this situation, it should be sent several times within the limited frequency.
/// After calling [startPublishingStream] to publish the stream successfully, you can call this function.
/// Limit frequency: Do not exceed 30 times per second.
/// The SEI data length is limited to 4096 bytes.
///
/// @param data SEI data
- (void)sendSEI:(NSData *)data;

/// Sends Supplemental Enhancement Information.
///
/// This function can synchronize some other additional information while the developer publishes streaming audio and video streaming data while sending streaming media enhancement supplementary information.
/// Generally, for scenarios such as synchronizing music lyrics or precise layout of video canvas, you can choose to use this function.
/// After the anchor sends the SEI, the audience can obtain the SEI content by monitoring the callback of [onPlayerRecvSEI].
/// Since SEI information follows video frames, and because of network problems, frames may be dropped, so SEI information may also be dropped. To solve this situation, it should be sent several times within the limited frequency.
/// After calling [startPublishingStream] to publish the stream successfully, you can call this function.
/// Limit frequency: Do not exceed 30 times per second.
/// The SEI data length is limited to 4096 bytes.
///
/// @param data SEI data
/// @param channel Publish stream channel
- (void)sendSEI:(NSData *)data channel:(ZegoPublishChannel)channel;

/// Enables or disables hardware encoding.
///
/// Whether to use the hardware encoding function when publishing the stream, the GPU is used to encode the stream and to reduce the CPU usage. The setting can take effect before the stream published. If it is set after the stream published, the stream should be stopped first before it takes effect.
/// Because hard-coded support is not particularly good for a few models, SDK uses software encoding by default. If the developer finds that the device is hot when publishing a high-resolution audio and video stream during testing of some models, you can consider calling this function to enable hard coding.
///
/// @param enable Whether to enable hardware encoding, YES: enable hardware encoding, NO: disable hardware encoding
- (void)enableHardwareEncoder:(BOOL)enable;

/// Sets the timing of video scaling in the video capture workflow. You can choose to do video scaling right after video capture (the default value) or before encoding.
///
/// This function needs to be set before previewing or streaming.
/// The main effect is whether the local preview is affected when the acquisition resolution is different from the encoding resolution.
///
/// @param mode The capture scale timing mode
- (void)setCapturePipelineScaleMode:(ZegoCapturePipelineScaleMode)mode;

@end

NS_ASSUME_NONNULL_END
