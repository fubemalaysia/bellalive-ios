//
//  ZegoExpressEventHandler.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressDefines.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Zego Event Handler

@protocol ZegoEventHandler <NSObject>

@optional

/// The callback for obtaining debugging error information.
///
/// When the SDK functions are not used correctly, the callback prompts for detailed error information, which is controlled by the [setDebugVerbose] function
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param funcName Function name
/// @param info Detailed error information
- (void)onDebugError:(int)errorCode funcName:(NSString *)funcName info:(NSString *)info;

/// The callback triggered when the audio/video engine state changes.
///
/// When the developer calls the function that enables audio and video related functions, such as calling [startPreview], [startPublishingStream], [startPlayingStream] and MediaPlayer related function, the audio/video engine will start; when all audio and video functions are stopped, the engine state will become stopped.
/// When the developer has been [loginRoom], once [logoutRoom] is called, the audio/video engine will stop (preview, publishing/playing stream, MediaPlayer and other audio and video related functions will also stop).
///
/// @param state The audio/video engine state
- (void)onEngineStateUpdate:(ZegoEngineState)state;

#pragma mark Room Callback

/// The callback triggered when the room connection state changes.
///
/// This callback is triggered when the connection status of the room changes, and the reason for the change is notified. Developers can use this callback to determine the status of the current user in the room.
/// When the user starts to log in to the room, the room is successfully logged in, or the room fails to log in, the [onRoomStateUpdate] callback will be triggered to notify the developer of the status of the current user connected to the room.
/// If the connection is being requested for a long time, the general probability is that the user's network is unstable.
///
/// @param state Changed room state
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param extendedData Extended Information with state updates. When the room login is successful, the key "room_session_id" can be used to obtain the unique RoomSessionID of each audio and video communication, which identifies the continuous communication from the first user in the room to the end of the audio and video communication. It can be used in scenarios such as call quality scoring and call problem diagnosis.
/// @param roomID Room ID, a string of up to 128 bytes in length.
- (void)onRoomStateUpdate:(ZegoRoomState)state errorCode:(int)errorCode extendedData:(nullable NSDictionary *)extendedData roomID:(NSString *)roomID;

/// The callback triggered when the number of other users in the room increases or decreases.
///
/// This callback is used to monitor the increase or decrease of other users in the room, and the developer can judge the situation of the users in the room based on this callback.
/// If developers need to use ZEGO room users notifications, please ensure that the [ZegoRoomConfig] sent by each user when logging in to the room has the [isUserStatusNotify] property set to YES, otherwise the callback notification will not be received.
/// The user logs in to the room, and there is no other user in the room at this time, the callback will not be triggered.
/// The user logs in to the room. If multiple other users already exist in the room, the callback will be triggered. At this time, the callback belongs to the ADD type and contains the full list of users in the room. At the same time, other users in the room will also receive this callback of the ADD type, but there are only new current users in the received user list.
/// When the user is already in the room, this callback will be triggered when other users in the room log in or log out of the room.
///
/// @param updateType Update type (add/delete)
/// @param userList List of users changed in the current room
/// @param roomID Room ID where the user is logged in, a string of up to 128 bytes in length.
- (void)onRoomUserUpdate:(ZegoUpdateType)updateType userList:(NSArray<ZegoUser *> *)userList roomID:(NSString *)roomID;

/// The callback triggered every 30 seconds to report the current number of online users.
///
/// This function is called back every 30 seconds.
/// Developers can use this callback to show the number of user online in the current room.
///
/// @param count Count of online users
/// @param roomID Room ID where the user is logged in, a string of up to 128 bytes in length.
- (void)onRoomOnlineUserCountUpdate:(int)count roomID:(NSString *)roomID;

/// (Deprecated, please use the callback with the same name with the [extendedData] parameter instead) The callback triggered when the number of streams published by the other users in the same room increases or decreases.
///
/// This callback is used to monitor stream addition or stream deletion notifications of other users in the room. Developers can use this callback to determine whether other users in the same room start or stop publishing stream, so as to achieve active playing stream [startPlayingStream] or take the initiative to stop the playing stream [stopPlayingStream], and use it to change the UI controls at the same time.
/// The user logs in to the room, and there is no other stream in the room at this time, the callback will not be triggered.
/// The user logs in to the room. If there are multiple streams of other users in the room, the callback will be triggered. At this time, the callback belongs to the ADD type and contains the full list of streams in the room.
/// When the user is already in the room, when other users in the room start or stop publishing stream (that is, when a stream is added or deleted), this callback will be triggered to notify the changed stream list.
///
/// @deprecated This callback function has been deprecated, please use the callback function with the same name with the [extendedData] parameter.
/// @param updateType Update type (add/delete)
/// @param streamList Updated stream list
/// @param roomID Room ID where the user is logged in, a string of up to 128 bytes in length.
- (void)onRoomStreamUpdate:(ZegoUpdateType)updateType streamList:(NSArray<ZegoStream *> *)streamList roomID:(NSString *)roomID DEPRECATED_ATTRIBUTE;

/// The callback triggered when the number of streams published by the other users in the same room increases or decreases.
///
/// This callback is used to monitor stream addition or stream deletion notifications of other users in the room. Developers can use this callback to determine whether other users in the same room start or stop publishing stream, so as to achieve active playing stream [startPlayingStream] or take the initiative to stop the playing stream [stopPlayingStream], and use it to change the UI controls at the same time.
/// The user logs in to the room, and there is no other stream in the room at this time, the callback will not be triggered.
/// The user logs in to the room. If there are multiple streams of other users in the room, the callback will be triggered. At this time, the callback belongs to the ADD type and contains the full list of streams in the room.
/// When the user is already in the room, when other users in the room start or stop publishing stream (that is, when a stream is added or deleted), this callback will be triggered to notify the changed stream list.
///
/// @param updateType Update type (add/delete)
/// @param streamList Updated stream list
/// @param extendedData Extended information with stream updates.
/// @param roomID Room ID where the user is logged in, a string of up to 128 bytes in length.
- (void)onRoomStreamUpdate:(ZegoUpdateType)updateType streamList:(NSArray<ZegoStream *> *)streamList extendedData:(nullable NSDictionary *)extendedData roomID:(NSString *)roomID;

/// The callback triggered when there is an update on the extra information of the streams published by other users in the same room.
///
/// When a user publishing the stream update the extra information of the stream in the same room, other users in the same room will receive the callback.
/// The stream extra information is an extra information identifier of the stream ID. Unlike the stream ID, which cannot be modified during the publishing process, the stream extra information can be modified midway through the stream corresponding to the stream ID.
/// Developers can synchronize variable content related to stream IDs based on stream additional information.
///
/// @param streamList List of streams that the extra info was updated.
/// @param roomID Room ID where the user is logged in, a string of up to 128 bytes in length.
- (void)onRoomStreamExtraInfoUpdate:(NSArray<ZegoStream *> *)streamList roomID:(NSString *)roomID;

/// The callback triggered when there is an update on the extra information of the room.
///
/// When a user update the room extra information, other users in the same room will receive the callback.
///
/// @param roomExtraInfoList List of the extra info updated.
/// @param roomID Room ID where the user is logged in, a string of up to 128 bytes in length.
- (void)onRoomExtraInfoUpdate:(NSArray<ZegoRoomExtraInfo *> *)roomExtraInfoList roomID:(NSString *)roomID;

/// Callback notification that room Token authentication is about to expire.
///
/// When the developer receives this callback, he can use [renewToken] to update the token authentication information.
///
/// @param remainTimeInSecond The remaining time before the token expires.
/// @param roomID Room ID where the user is logged in, a string of up to 128 bytes in length.
- (void)onRoomTokenWillExpire:(int)remainTimeInSecond roomID:(NSString *)roomID;

#pragma mark Publisher Callback

/// The callback triggered when the state of stream publishing changes.
///
/// After publishing the stream successfully, the notification of the publish stream state change can be obtained through the callback function.
/// You can roughly judge the user's uplink network status based on whether the state parameter is in [PUBLISH_REQUESTING].
/// The parameter [extendedData] is extended information with state updates. If you use ZEGO's CDN content distribution network, after the stream is successfully published, the keys of the content of this parameter are [flv_url_list], [rtmp_url_list], [hls_url_list]. These correspond to the publishing stream URLs of the flv, rtmp, and hls protocols.
///
/// @param state State of publishing stream
/// @param errorCode The error code corresponding to the status change of the publish stream, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param extendedData Extended information with state updates.
/// @param streamID Stream ID
- (void)onPublisherStateUpdate:(ZegoPublisherState)state errorCode:(int)errorCode extendedData:(nullable NSDictionary *)extendedData streamID:(NSString *)streamID;

/// Callback for current stream publishing quality.
///
/// After calling the [startPublishingStream] successfully, the callback will be received every 3 seconds. Through the callback, the collection frame rate, bit rate, RTT, packet loss rate and other quality data of the published audio and video stream can be obtained, and the health of the publish stream can be monitored in real time.
/// You can monitor the health of the published audio and video streams in real time according to the quality parameters of the callback function, in order to show the uplink network status in real time on the device UI.
/// If you does not know how to use the parameters of this callback function, you can only pay attention to the [level] field of the [quality] parameter, which is a comprehensive value describing the uplink network calculated by SDK based on the quality parameters.
///
/// @param quality Publishing stream quality, including audio and video framerate, bitrate, RTT, etc.
/// @param streamID Stream ID
- (void)onPublisherQualityUpdate:(ZegoPublishStreamQuality *)quality streamID:(NSString *)streamID;

/// The callback triggered when the first audio frame is captured.
///
/// After the [startPublishingStream] function is called successfully, this callback will be called when SDK received the first frame of audio data.
/// In the case of no startPublishingStream audio and video stream or preview, the first startPublishingStream audio and video stream or first preview, that is, when the engine of the audio and video module inside SDK starts, it will collect audio data of the local device and receive this callback.
/// Developers can use this callback to determine whether SDK has actually collected audio data. If the callback is not received, the audio capture device is occupied or abnormal.
- (void)onPublisherCapturedAudioFirstFrame;

/// The callback triggered when the first video frame is captured.
///
/// After the [startPublishingStream] function is called successfully, this callback will be called when SDK received the first frame of video data.
/// In the case of no startPublishingStream video stream or preview, the first startPublishingStream video stream or first preview, that is, when the engine of the audio and video module inside SDK starts, it will collect video data of the local device and receive this callback.
/// Developers can use this callback to determine whether SDK has actually collected video data. If the callback is not received, the video capture device is occupied or abnormal.
///
/// @param channel Publishing stream channel.If you only publish one audio and video stream, you can ignore this parameter.
- (void)onPublisherCapturedVideoFirstFrame:(ZegoPublishChannel)channel;

/// The callback triggered when the first video frame is rendered.
///
/// this callback will be called after SDK rendered the first frame of video data captured.
///
/// @param channel Publishing stream channel.If you only publish one audio and video stream, you can ignore this parameter.
- (void)onPublisherRenderVideoFirstFrame:(ZegoPublishChannel)channel;

/// The callback triggered when the video capture resolution changes.
///
/// After the successful publish, the callback will be received if there is a change in the video capture resolution in the process of publishing the stream.
/// When the audio and video stream is not published or previewed for the first time, the publishing stream or preview first time, that is, the engine of the audio and video module inside the SDK is started, the video data of the local device will be collected, and the collection resolution will change at this time.
/// You can use this callback to remove the cover of the local preview UI and similar operations.You can also dynamically adjust the scale of the preview view based on the resolution of the callback.
///
/// @param size Video capture resolution
/// @param channel Publishing stream channel.If you only publish one audio and video stream, you can ignore this parameter.
- (void)onPublisherVideoSizeChanged:(CGSize)size channel:(ZegoPublishChannel)channel;

/// The callback triggered when the state of relayed streaming to CDN changes.
///
/// After the ZEGO RTC server relays the audio and video streams to the CDN, this callback will be received if the CDN relay status changes, such as a stop or a retry.
/// Developers can use this callback to determine whether the audio and video streams of the relay CDN are normal. If they are abnormal, further locate the cause of the abnormal audio and video streams of the relay CDN and make corresponding disaster recovery strategies.
/// If you do not understand the cause of the abnormality, you can contact ZEGO technicians to analyze the specific cause of the abnormality.
///
/// @param infoList List of information that the current CDN is relaying
/// @param streamID Stream ID
- (void)onPublisherRelayCDNStateUpdate:(NSArray<ZegoStreamRelayCDNInfo *> *)infoList streamID:(NSString *)streamID;

#pragma mark Player Callback

/// The callback triggered when the state of stream playing changes.
///
/// After publishing the stream successfully, the notification of the publish stream state change can be obtained through the callback function.
/// You can roughly judge the user's downlink network status based on whether the state parameter is in [PLAY_REQUESTING].
///
/// @param state State of playing stream
/// @param errorCode The error code corresponding to the status change of the playing stream, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param extendedData Extended Information with state updates. As the standby, only an empty json table is currently returned
/// @param streamID stream ID
- (void)onPlayerStateUpdate:(ZegoPlayerState)state errorCode:(int)errorCode extendedData:(nullable NSDictionary *)extendedData streamID:(NSString *)streamID;

/// Callback for current stream playing quality.
///
/// After calling the [startPlayingStream] successfully, this callback will be triggered every 3 seconds. The collection frame rate, bit rate, RTT, packet loss rate and other quality data can be obtained, such the health of the publish stream can be monitored in real time.
/// You can monitor the health of the played audio and video streams in real time according to the quality parameters of the callback function, in order to show the downlink network status on the device UI in real time.
/// If you does not know how to use the various parameters of the callback function, you can only focus on the level field of the quality parameter, which is a comprehensive value describing the downlink network calculated by SDK based on the quality parameters.
///
/// @param quality Playing stream quality, including audio and video framerate, bitrate, RTT, etc.
/// @param streamID Stream ID
- (void)onPlayerQualityUpdate:(ZegoPlayStreamQuality *)quality streamID:(NSString *)streamID;

/// The callback triggered when a media event occurs during streaming playing.
///
/// This callback is triggered when an event such as audio and video jamming and recovery occurs in the playing stream.
/// You can use this callback to make statistics on stutters or to make friendly displays in the UI of the app.
///
/// @param event Specific events received when playing the stream.
/// @param streamID Stream ID
- (void)onPlayerMediaEvent:(ZegoPlayerMediaEvent)event streamID:(NSString *)streamID;

/// The callback triggered when the first audio frame is received.
///
/// After the [startPlayingStream] function is called successfully, this callback will be called when SDK received the first frame of audio data.
///
/// @param streamID Stream ID
- (void)onPlayerRecvAudioFirstFrame:(NSString *)streamID;

/// The callback triggered when the first video frame is received.
///
/// After the [startPlayingStream] function is called successfully, this callback will be called when SDK received the first frame of video data.
///
/// @param streamID Stream ID
- (void)onPlayerRecvVideoFirstFrame:(NSString *)streamID;

/// The callback triggered when the first video frame is rendered.
///
/// After the [startPlayingStream] function is called successfully, this callback will be called when SDK rendered the first frame of video data.
/// Developer can use this callback to count time consuming that take the first frame time or update the UI for playing stream.
///
/// @param streamID Stream ID
- (void)onPlayerRenderVideoFirstFrame:(NSString *)streamID;

/// The callback triggered when the stream playback resolution changes.
///
/// If there is a change in the video resolution of the playing stream, the callback will be triggered, and the user can adjust the display for that stream dynamically.
/// If the publishing stream end triggers the internal stream flow control of SDK due to a network problem, the encoding resolution of the streaming end may be dynamically reduced, and this callback will also be received at this time.
/// If the stream is only audio data, the callback will not be received.
/// This callback will be triggered when the played audio and video stream is actually rendered to the set UI play canvas. You can use this callback notification to update or switch UI components that actually play the stream.
///
/// @param size Video decoding resolution
/// @param streamID Stream ID
- (void)onPlayerVideoSizeChanged:(CGSize)size streamID:(NSString *)streamID;

/// The callback triggered when Supplemental Enhancement Information is received.
///
/// After the remote stream is successfully played, when the remote stream sends SEI (such as directly calling [sendSEI], audio mixing with SEI data, and sending custom video capture encoded data with SEI, etc.), the local end will receive this callback.
/// Since the video encoder itself generates an SEI with a payload type of 5, or when a video file is used for publishing, such SEI may also exist in the video file. Therefore, if the developer needs to filter out this type of SEI, it can be before [createEngine] Call [ZegoEngineConfig.advancedConfig("unregister_sei_filter", "XXXXX")]. Among them, unregister_sei_filter is the key, and XXXXX is the uuid filter string to be set.
///
/// @param data SEI content
/// @param streamID Stream ID
- (void)onPlayerRecvSEI:(NSData *)data streamID:(NSString *)streamID;

#pragma mark Mixer Callback

/// The callback triggered when the state of relayed streaming of the mixed stream to CDN changes.
///
/// In the general case of the ZEGO RTC server's stream mixing task, the output stream is published to the CDN using the RTMP protocol, and changes in the state during the publish will be notified from this callback function.
///
/// @param infoList List of information that the current CDN is being mixed
/// @param taskID Stream mixing task ID
- (void)onMixerRelayCDNStateUpdate:(NSArray<ZegoStreamRelayCDNInfo *> *)infoList taskID:(NSString *)taskID;

/// The callback triggered when the sound level of any input stream changes in the stream mixing process.
///
/// You can use this callback to show the effect of the anchors sound level when the audience plays the mixed stream. So audience can notice which anchor is speaking.
///
/// @param soundLevels Sound level hash map, key is the soundLevelID of every single stream in this mixer stream, value is the sound level value of that single stream, value ranging from 0.0 to 100.0
- (void)onMixerSoundLevelUpdate:(NSDictionary<NSNumber *, NSNumber *> *)soundLevels;

#pragma mark Device Callback

#if TARGET_OS_OSX
/// The callback triggered when there is a change to audio devices (i.e. new device added or existing device deleted).
///
/// only for macOS; This callback is triggered when an audio device is added or removed from the system. By listening to this callback, users can update the sound collection or output using a specific device when necessary.
///
/// @param deviceInfo Audio device information
/// @param updateType Update type (add/delete)
/// @param deviceType Audio device type
- (void)onAudioDeviceStateChanged:(ZegoDeviceInfo *)deviceInfo updateType:(ZegoUpdateType)updateType deviceType:(ZegoAudioDeviceType)deviceType;
#endif

#pragma mark Device Callback

#if TARGET_OS_OSX
/// The callback triggered when there is a change of the volume fo the audio devices.
///
/// only for macOS.
///
/// @param volume audio device volume
/// @param deviceType Audio device type
/// @param deviceID Audio device ID
- (void)onAudioDeviceVolumeChanged:(int)volume deviceType:(ZegoAudioDeviceType)deviceType deviceID:(NSString *)deviceID;
#endif

#if TARGET_OS_OSX
/// The callback triggered when there is a change to video devices (i.e. new device added or existing device deleted).
///
/// only for macOS; This callback is triggered when a video device is added or removed from the system. By listening to this callback, users can update the video capture using a specific device when necessary.
///
/// @param deviceInfo Audio device information
/// @param updateType Update type (add/delete)
- (void)onVideoDeviceStateChanged:(ZegoDeviceInfo *)deviceInfo updateType:(ZegoUpdateType)updateType;
#endif

/// The local captured audio sound level callback.
///
/// To trigger this callback function, the [startSoundLevelMonitor] function must be called to start the sound level monitor and you must be in a state where it is publishing the audio and video stream or be in [startPreview] state.
/// The callback notification period is the setting parameter of [startSoundLevelMonitor].
///
/// @param soundLevel Locally captured sound level value, ranging from 0.0 to 100.0
- (void)onCapturedSoundLevelUpdate:(NSNumber *)soundLevel;

/// The remote playing streams audio sound level callback.
///
/// To trigger this callback function, the [startSoundLevelMonitor] function must be called to start the sound level monitor and you must be in a state where it is playing the audio and video stream.
/// The callback notification period is the setting parameter of [startSoundLevelMonitor].
///
/// @param soundLevels Remote sound level hash map, key is the streamID, value is the sound level value of the corresponding streamID, value ranging from 0.0 to 100.0
- (void)onRemoteSoundLevelUpdate:(NSDictionary<NSString *, NSNumber *> *)soundLevels;

/// The local captured audio spectrum callback.
///
/// To trigger this callback function, the [startAudioSpectrumMonitor] function must be called to start the audio spectrum monitor and you must be in a state where it is publishing the audio and video stream or be in [startPreview] state.
/// The callback notification period is the setting parameter of [startAudioSpectrumMonitor].
///
/// @param audioSpectrum Locally captured audio spectrum value list. Spectrum value range is [0-2^30]
- (void)onCapturedAudioSpectrumUpdate:(NSArray<NSNumber *> *)audioSpectrum;

/// The remote playing streams audio spectrum callback.
///
/// To trigger this callback function, the [startAudioSpectrumMonitor] function must be called to start the audio spectrum monitor and you must be in a state where it is playing the audio and video stream.
/// The callback notification period is the setting parameter of [startAudioSpectrumMonitor].
///
/// @param audioSpectrums Remote audio spectrum hash map, key is the streamID, value is the audio spectrum list of the corresponding streamID. Spectrum value range is [0-2^30]
- (void)onRemoteAudioSpectrumUpdate:(NSDictionary<NSString *, NSArray<NSNumber *> *> *)audioSpectrums;

/// The callback triggered when a device exception occurs.
///
/// This callback is triggered when an exception occurs when reading or writing the audio and video device.
///
/// @param errorCode The error code corresponding to the status change of the playing stream, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param deviceName device name
- (void)onDeviceError:(int)errorCode deviceName:(NSString *)deviceName;

/// The callback triggered when the state of the remote camera changes.
///
/// When the state of the remote camera device changes, such as switching the camera, by monitoring this callback, it is possible to obtain an event related to the far-end camera, which can be used to prompt the user that the video may be abnormal.
/// Developers of 1v1 education scenarios or education small class scenarios and similar scenarios can use this callback notification to determine whether the camera device of the remote publishing stream device is working normally, and preliminary understand the cause of the device problem according to the corresponding state.
/// This callback will not be called back when the remote stream is play from the CDN, and will not be called back if the remote stream end user has enabled custom video capture function.
///
/// @param state Remote camera status
/// @param streamID Stream ID
- (void)onRemoteCameraStateUpdate:(ZegoRemoteDeviceState)state streamID:(NSString *)streamID;

/// The callback triggered when the state of the remote microphone changes.
///
/// When the state of the remote microphone device is changed, such as switching a microphone, etc., by listening to the callback, it is possible to obtain an event related to the remote microphone, which can be used to prompt the user that the audio may be abnormal.
/// Developers of 1v1 education scenarios or education small class scenarios and similar scenarios can use this callback notification to determine whether the microphone device of the remote publishing stream device is working normally, and preliminary understand the cause of the device problem according to the corresponding state.
/// This callback will not be called back when the remote stream is play from the CDN, and will not be called back if the remote stream end user has enabled custom audio capture function.
///
/// @param state Remote microphone status
/// @param streamID Stream ID
- (void)onRemoteMicStateUpdate:(ZegoRemoteDeviceState)state streamID:(NSString *)streamID;

/// Callback for device's audio route changed.
///
/// This callback will be called when there are changes in audio routing such as earphone plugging, speaker and receiver switching, etc.
///
/// @param audioRoute Current audio route
- (void)onAudioRouteChange:(ZegoAudioRoute)audioRoute;

#pragma mark IM Callback

/// The callback triggered when Broadcast Messages are received.
///
/// This callback is used to receive broadcast messages sent by other users, and barrage messages sent by users themselves will not be notified through this callback.
///
/// @param messageList list of received messages.
/// @param roomID Room ID
- (void)onIMRecvBroadcastMessage:(NSArray<ZegoBroadcastMessageInfo *> *)messageList roomID:(NSString *)roomID;

/// The callback triggered when Barrage Messages are received.
///
/// This callback is used to receive barrage messages sent by other users, and barrage messages sent by users themselves will not be notified through this callback.
///
/// @param messageList list of received messages.
/// @param roomID Room ID
- (void)onIMRecvBarrageMessage:(NSArray<ZegoBarrageMessageInfo *> *)messageList roomID:(NSString *)roomID;

/// The callback triggered when a Custom Command is received.
///
/// This callback is used to receive custom signaling sent by other users, and barrage messages sent by users themselves will not be notified through this callback.
///
/// @param command Command content received
/// @param fromUser Sender of the command
/// @param roomID Room ID
- (void)onIMRecvCustomCommand:(NSString *)command fromUser:(ZegoUser *)fromUser roomID:(NSString *)roomID;

#pragma mark Utilities Callback

/// The system performance status callback.
///
/// To trigger this callback function, the [startPerformanceMonitor] function must be called to start the system performance monitor.
/// The callback notification period is the setting parameter of [startPerformanceMonitor].
///
/// @param status The system performance status.
- (void)onPerformanceStatusUpdate:(ZegoPerformanceStatus *)status;

/// Callback for network mode changed.
///
/// This callback will be called when the device's network mode changes, such as switching from WiFi to 5G, or when the network is disconnected.
///
/// @param mode Current network mode.
- (void)onNetworkModeChanged:(ZegoNetworkMode)mode;

/// The callback triggered when error occurred when testing network speed.
///
/// @param errorCode The error code corresponding to the network speed test, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param type Uplink or downlink
- (void)onNetworkSpeedTestError:(int)errorCode type:(ZegoNetworkSpeedTestType)type;

/// The callback triggered when quality updated when testing network speed.
///
/// When error occurs or called stopNetworkSpeedTest, this callback will be stopped.
///
/// @param quality Network speed quality
/// @param type Uplink or downlink
- (void)onNetworkSpeedTestQualityUpdate:(ZegoNetworkSpeedTestQuality *)quality type:(ZegoNetworkSpeedTestType)type;

/// Receive custom JSON content
///
/// @param content JSON string content
- (void)onRecvExperimentalAPI:(NSString *)content;

@end

#pragma mark - Zego Api Called Event Handler

@protocol ZegoApiCalledEventHandler <NSObject>

@optional

/// Method execution result callback
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param funcName Function name
/// @param info Detailed error information
- (void)onApiCalledResult:(int)errorCode funcName:(NSString *)funcName info:(NSString *)info;

@end

#pragma mark - Zego Audio Mixing Handler

@protocol ZegoAudioMixingHandler <NSObject>

@optional

/// The callback for copying audio data to the SDK for audio mixing. This function should be used together with enableAudioMixing.
///
/// Supports 16k 32k 44.1k 48k sample rate, mono or dual channel, 16-bit deep PCM audio data
/// This callback is a high frequency callback. To ensure the quality of the mixing data, please do not handle time-consuming operations in this callback
///
/// @param expectedDataLength Expected length of incoming audio mixing data
/// @return Data to be mixed
- (ZegoAudioMixingData *)onAudioMixingCopyData:(unsigned int)expectedDataLength;

@end

#pragma mark - Zego Media Player Event Handler

@protocol ZegoMediaPlayerEventHandler <NSObject>

@optional

/// The callback triggered when the state of the media player changes.
///
/// @param mediaPlayer Callback player object
/// @param state Media player status
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
- (void)mediaPlayer:(ZegoMediaPlayer *)mediaPlayer stateUpdate:(ZegoMediaPlayerState)state errorCode:(int)errorCode;

/// The callback triggered when the network status of the media player changes.
///
/// @param mediaPlayer Callback player object
/// @param networkEvent Network status event
- (void)mediaPlayer:(ZegoMediaPlayer *)mediaPlayer networkEvent:(ZegoMediaPlayerNetworkEvent)networkEvent;

/// The callback to report the current playback progress of the media player.
///
/// @param mediaPlayer Callback player object
/// @param millisecond Progress in milliseconds
- (void)mediaPlayer:(ZegoMediaPlayer *)mediaPlayer playingProgress:(unsigned long long)millisecond;

/// The callback triggered when the media player got media side info.
///
/// @param mediaPlayer Callback player object
/// @param data SEI content
- (void)mediaPlayer:(ZegoMediaPlayer *)mediaPlayer recvSEI:(NSData *)data;

@end

#pragma mark - Zego Media Player Video Handler

@protocol ZegoMediaPlayerVideoHandler <NSObject>

@optional

/// The callback triggered when the media player throws out video frame data.
///
/// @param mediaPlayer Callback player object
/// @param data Raw data of video frames (eg: RGBA only needs to consider data[0], I420 needs to consider data[0,1,2])
/// @param dataLength Data length (eg: RGBA only needs to consider dataLength[0], I420 needs to consider dataLength[0,1,2])
/// @param param Video frame flip mode
- (void)mediaPlayer:(ZegoMediaPlayer *)mediaPlayer videoFrameRawData:(const unsigned char * _Nonnull * _Nonnull)data dataLength:(unsigned int *)dataLength param:(ZegoVideoFrameParam *)param;

/// The callback triggered when the media player throws out video frame data (in CVPixelBuffer format).
///
/// @param mediaPlayer Callback player object
/// @param buffer video data of CVPixelBuffer format
/// @param param video data frame param
- (void)mediaPlayer:(ZegoMediaPlayer *)mediaPlayer videoFramePixelBuffer:(CVPixelBufferRef)buffer param:(ZegoVideoFrameParam *)param;

@end

#pragma mark - Zego Media Player Audio Handler

@protocol ZegoMediaPlayerAudioHandler <NSObject>

@optional

/// The callback triggered when the media player throws out audio frame data.
///
/// @param mediaPlayer Callback player object
/// @param data Raw data of audio frames
/// @param dataLength Data length
/// @param param audio frame flip mode
- (void)mediaPlayer:(ZegoMediaPlayer *)mediaPlayer audioFrameData:(const unsigned char *)data dataLength:(unsigned int)dataLength param:(ZegoAudioFrameParam *)param;

@end

#pragma mark - Zego Audio Effect Player Event Handler

@protocol ZegoAudioEffectPlayerEventHandler <NSObject>

@optional

/// Audio effect playback state callback.
///
/// This callback is triggered when the playback state of a audio effect of the audio effect player changes.
///
/// @param audioEffectPlayer Audio effect player instance that triggers this callback
/// @param audioEffectID The ID of the audio effect resource that triggered this callback
/// @param state The playback state of the audio effect
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
- (void)audioEffectPlayer:(ZegoAudioEffectPlayer *)audioEffectPlayer audioEffectID:(unsigned int)audioEffectID playStateUpdate:(ZegoAudioEffectPlayState)state errorCode:(int)errorCode;

@end

#pragma mark - Zego Data Record Event Handler

@protocol ZegoDataRecordEventHandler <NSObject>

@optional

/// The callback triggered when the state of data recording (to a file) changes.
///
/// @param state File recording status, according to which you should determine the state of the file recording or the prompt of the UI.
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param config Record config
/// @param channel Publishing stream channel
- (void)onCapturedDataRecordStateUpdate:(ZegoDataRecordState)state errorCode:(int)errorCode config:(ZegoDataRecordConfig *)config channel:(ZegoPublishChannel)channel;

/// The callback to report the current recording progress.
///
/// @param progress File recording progress, which allows developers to hint at the UI, etc.
/// @param config Record config
/// @param channel Publishing stream channel
- (void)onCapturedDataRecordProgressUpdate:(ZegoDataRecordProgress *)progress config:(ZegoDataRecordConfig *)config channel:(ZegoPublishChannel)channel;

@end

#pragma mark - Zego Custom Video Capture Handler

@protocol ZegoCustomVideoCaptureHandler <NSObject>

@optional

/// The callback triggered when the SDK is ready to receive captured video data. Only those video data that are sent to the SDK after this callback is received are valid.
///
/// @param channel Publishing stream channel
- (void)onStart:(ZegoPublishChannel)channel;

/// The callback triggered when SDK stops receiving captured video data.
///
/// @param channel Publishing stream channel
- (void)onStop:(ZegoPublishChannel)channel;

/// SDK detects network changes and informs developers that it needs to do traffic control
/// In the case of custom video capture by sending encoded data, the SDK cannot know the external encoding configuration, so the traffic control operation needs to be completed by the developer.
/// The SDK will notify the developer of the recommended value of the video configuration according to the current network situation, and the developer needs to modify the encoder configuration by himself to ensure the smoothness of video transmission
/// Please do not perform time-consuming operations in this callback. If you need to perform time-consuming operations, please switch threads
///
/// @param trafficControlInfo traffic control info
/// @param channel Publishing stream channel
- (void)onEncodedDataTrafficControl:(ZegoTrafficControlInfo *)trafficControlInfo channel:(ZegoPublishChannel)channel;

@end

#pragma mark - Zego Custom Video Render Handler

@protocol ZegoCustomVideoRenderHandler <NSObject>

@optional

/// The callback for obtaining the locally captured video frames (Raw Data).
///
/// @param data Raw data of video frames (eg: RGBA only needs to consider data[0], I420 needs to consider data[0,1,2])
/// @param dataLength Data length (eg: RGBA only needs to consider dataLength[0], I420 needs to consider dataLength[0,1,2])
/// @param param Video frame parameters
/// @param flipMode video flip mode
/// @param channel Publishing stream channel
- (void)onCapturedVideoFrameRawData:(unsigned char * _Nonnull * _Nonnull)data dataLength:(unsigned int *)dataLength param:(ZegoVideoFrameParam *)param flipMode:(ZegoVideoFlipMode)flipMode channel:(ZegoPublishChannel)channel;

/// The callback for obtaining the video frames (Raw Data) of the remote stream. Different streams can be identified by streamID.
///
/// @param data Raw data of video frames (eg: RGBA only needs to consider data[0], I420 needs to consider data[0,1,2])
/// @param dataLength Data length (eg: RGBA only needs to consider dataLength[0], I420 needs to consider dataLength[0,1,2])
/// @param param Video frame parameters
/// @param streamID Stream ID
- (void)onRemoteVideoFrameRawData:(unsigned char * _Nonnull * _Nonnull)data dataLength:(unsigned int *)dataLength param:(ZegoVideoFrameParam *)param streamID:(NSString *)streamID;

/// The callback for obtaining the locally captured video frames (CVPixelBuffer).
///
/// @param buffer video data of CVPixelBuffer format
/// @param param Video frame param
/// @param flipMode video flip mode
/// @param channel Publishing stream channel
- (void)onCapturedVideoFrameCVPixelBuffer:(CVPixelBufferRef)buffer param:(ZegoVideoFrameParam *)param flipMode:(ZegoVideoFlipMode)flipMode channel:(ZegoPublishChannel)channel;

/// The callback for obtaining the video frames (CVPixelBuffer) of the remote stream. Different streams can be identified by streamID.
///
/// @param buffer video data of CVPixelBuffer format
/// @param param Video frame param
/// @param streamID Stream ID
- (void)onRemoteVideoFrameCVPixelBuffer:(CVPixelBufferRef)buffer param:(ZegoVideoFrameParam *)param streamID:(NSString *)streamID;

/// The callback for obtianing the video frames (Encoded Data) of the remote stream. Different streams can be identified by streamID.
///
/// @param data Encoded data of video frames
/// @param dataLength Data length
/// @param param Video frame parameters
/// @param referenceTimeMillisecond video frame reference time, UNIX timestamp, in milliseconds.
/// @param streamID Stream ID
- (void)onRemoteVideoFrameEncodedData:(unsigned char * _Nonnull)data dataLength:(unsigned int)dataLength param:(ZegoVideoEncodedFrameParam *)param referenceTimeMillisecond:(unsigned long long)referenceTimeMillisecond streamID:(NSString *)streamID;

@end

#pragma mark - Zego Custom Video Process Handler

@protocol ZegoCustomVideoProcessHandler <NSObject>

@optional

/// The SDK informs the developer that it is about to start custom video processing
///
/// It is recommended to initialize other resources in this callback
///
/// @param channel Publishing stream channel
- (void)onStart:(ZegoPublishChannel)channel;

/// The SDK informs the developer to stop custom video processing
///
/// It is recommended to destroy other resources in this callback
///
/// @param channel Publishing stream channel
- (void)onStop:(ZegoPublishChannel)channel;

/// Call back when the original video data of type [CVPixelBuffer] is obtained
///
/// This callback takes effect when [enableCustomVideoProcessing] is called to enable custom video processing and the bufferType of config is passed in [ZEGO_VIDEO_BUFFER_TYPE_CVPIXELBUFFER]
/// After the developer has processed the original image, he must call [sendCustomVideoProcessedCVPixelbuffer] to send the processed data back to the SDK, otherwise it will cause frame loss
/// Precondition： call [setCustomVideoProcessHandler] to set callback
/// Supported version： 2.2.0
///
/// @param buffer CVPixelBuffer type video frame data to be sent to the SDK
/// @param timestamp Timestamp of this video frame
/// @param channel Publishing stream channel
- (void)onCapturedUnprocessedCVPixelBuffer:(CVPixelBufferRef)buffer timestamp:(CMTime)timestamp channel:(ZegoPublishChannel)channel;

@end

#pragma mark - Zego Custom Audio Process Handler

@protocol ZegoCustomAudioProcessHandler <NSObject>

@optional

/// Custom audio processing local captured PCM audio frame callback.
///
/// @param data Audio data in PCM format
/// @param dataLength Length of the data
/// @param param Parameters of the audio frame
- (void)onProcessCapturedAudioData:(unsigned char * _Nonnull)data dataLength:(unsigned int)dataLength param:(ZegoAudioFrameParam *)param;

/// Custom audio processing remote playing stream PCM audio frame callback.
///
/// @param data Audio data in PCM format
/// @param dataLength Length of the data
/// @param param Parameters of the audio frame
/// @param streamID Corresponding stream ID
- (void)onProcessRemoteAudioData:(unsigned char * _Nonnull)data dataLength:(unsigned int)dataLength param:(ZegoAudioFrameParam *)param streamID:(NSString *)streamID;

@end

#pragma mark - Zego Audio Data Handler

@protocol ZegoAudioDataHandler <NSObject>

@optional

/// The callback for obtaining the audio data captured by the local microphone.
///
/// In non-custom audio capture mode, the SDK capture the microphone's sound, but the developer may also need to get a copy of the audio data captured by the SDK is available through this callback.
/// On the premise of calling [setAudioDataHandler] to set the listener callback, after calling [enableAudioDataCallback] to set the mask 0b01 that means 1 << 0, this callback will be triggered only when it is in the publishing stream state.
///
/// @param data Audio data in PCM format
/// @param dataLength Length of the data
/// @param param Parameters of the audio frame
- (void)onCapturedAudioData:(const unsigned char * _Nonnull)data dataLength:(unsigned int)dataLength param:(ZegoAudioFrameParam *)param;

/// The callback for obtaining the audio data of all the streams playback by SDK.
///
/// This function will callback all the mixed audio data to be playback. This callback can be used for that you needs to fetch all the mixed audio data to be playback to proccess.
/// On the premise of calling [setAudioDataHandler] to set the listener callback, after calling [enableAudioDataCallback] to set the mask 0b100 that means 1 << 2, this callback will be triggered only when it is in the SDK inner audio and video engine started(called the [startPreivew] or [startPlayingStream] or [startPublishingStream]).
/// When the engine is started in the non-playing stream state or the media player is not used to play the media file, the audio data to be called back is muted audio data.
///
/// @param data Audio data in PCM format
/// @param dataLength Length of the data
/// @param param Parameters of the audio frame
- (void)onPlaybackAudioData:(const unsigned char * _Nonnull)data dataLength:(unsigned int)dataLength param:(ZegoAudioFrameParam *)param;

/// The callback for obtaining the mixed audio data. Such mixed auido data are generated by the SDK by mixing the audio data of all the remote playing streams and the auido data captured locally.
///
/// The audio data of all playing data is mixed with the data captured by the local microphone before it is sent to the loudspeaker, and calleback out in this way.
/// On the premise of calling [setAudioDataHandler] to set the listener callback, after calling [enableAudioDataCallback] to set the mask 0x04, this callback will be triggered only when it is in the publishing stream state or playing stream state.
///
/// @param data Audio data in PCM format
/// @param dataLength Length of the data
/// @param param Parameters of the audio frame
- (void)onMixedAudioData:(const unsigned char * _Nonnull)data dataLength:(unsigned int)dataLength param:(ZegoAudioFrameParam *)param;

/// The callback for obtaining the audio data of each stream.
///
/// This function will call back the data corresponding to each playing stream. Different from [onPlaybackAudioData], the latter is the mixed data of all playing streams. If developers need to process a piece of data separately, they can use this callback.
/// On the premise of calling [setAudioDataHandler] to set up listening for this callback, calling [enableAudioDataCallback] to set the mask 0x08 that is 1 << 3, and this callback will be triggered when the SDK audio and video engine starts to play the stream.
///
/// @param data Audio data in PCM format
/// @param dataLength Length of the data
/// @param param Parameters of the audio frame
/// @param streamID Corresponding stream ID
- (void)onPlayerAudioData:(const unsigned char * _Nonnull)data dataLength:(unsigned int)dataLength param:(ZegoAudioFrameParam *)param streamID:(NSString *)streamID;

@end

NS_ASSUME_NONNULL_END
