//
//  ZegoExpressDefines.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVFoundation/AVFoundation.h>
#import "ZegoExpressErrorCode.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
typedef UIView ZGView;
typedef UIImage ZGImage;
#elif TARGET_OS_OSX
#import <AppKit/AppKit.h>
typedef NSView ZGView;
typedef NSImage ZGImage;
#endif

#define ZEGO_EXPRESS_VIDEO_SDK 1
#define ZEGO_EXPRESS_AUDIO_SDK 0

NS_ASSUME_NONNULL_BEGIN

@protocol ZegoMediaPlayerEventHandler;
@protocol ZegoMediaPlayerVideoHandler;
@protocol ZegoMediaPlayerAudioHandler;
@protocol ZegoAudioEffectPlayerEventHandler;
@class ZegoTestNetworkConnectivityResult;
@class ZegoNetworkProbeResult;
@class ZegoAccurateSeekConfig;
@class ZegoNetWorkResourceCache;
/// Callback for asynchronous destruction completion.
///
/// In general, developers do not need to listen to this callback.
typedef void(^ZegoDestroyCompletionCallback)(void);

/// Callback for setting room extra information.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
typedef void(^ZegoRoomSetRoomExtraInfoCallback)(int errorCode);

/// Log upload result callback.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
typedef void(^ZegoUploadLogResultCallback)(int errorCode);

/// Callback for setting stream extra information.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
typedef void(^ZegoPublisherSetStreamExtraInfoCallback)(int errorCode);

/// Callback for add/remove CDN URL.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
typedef void(^ZegoPublisherUpdateCdnUrlCallback)(int errorCode);

/// Results of take publish stream snapshot.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param image Snapshot image
typedef void(^ZegoPublisherTakeSnapshotCallback)(int errorCode, ZGImage * _Nullable image);

/// Results of take play stream snapshot.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param image Snapshot image
typedef void(^ZegoPlayerTakeSnapshotCallback)(int errorCode, ZGImage * _Nullable image);

/// Results of starting a mixer task.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param extendedData Extended Information
typedef void(^ZegoMixerStartCallback)(int errorCode, NSDictionary * _Nullable extendedData);

/// Results of stoping a mixer task.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
typedef void(^ZegoMixerStopCallback)(int errorCode);

/// Callback for sending broadcast messages.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param messageID ID of this message
typedef void(^ZegoIMSendBroadcastMessageCallback)(int errorCode, unsigned long long messageID);

/// Callback for sending barrage message.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param messageID ID of this message
typedef void(^ZegoIMSendBarrageMessageCallback)(int errorCode, NSString *messageID);

/// Callback for sending custom command.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
typedef void(^ZegoIMSendCustomCommandCallback)(int errorCode);

/// Callback for test network connectivity.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param result Network connectivity test results
typedef void(^ZegoTestNetworkConnectivityCallback)(int errorCode, ZegoTestNetworkConnectivityResult *result);

/// Callback for network probe.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param result Network probe result
typedef void(^ZegoNetworkProbeResultCallback)(int errorCode, ZegoNetworkProbeResult *result);

/// Callback for media player loads resources.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
typedef void(^ZegoMediaPlayerLoadResourceCallback)(int errorCode);

/// Callback for media player seek to playback progress.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
typedef void(^ZegoMediaPlayerSeekToCallback)(int errorCode);

/// The callback of the screenshot of the media player playing screen
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param image Snapshot image
typedef void(^ZegoMediaPlayerTakeSnapshotCallback)(int errorCode, ZGImage * _Nullable image);

/// Callback for audio effect player loads resources.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
typedef void(^ZegoAudioEffectPlayerLoadResourceCallback)(int errorCode);

/// Callback for audio effect player seek to playback progress.
///
/// @param errorCode Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
typedef void(^ZegoAudioEffectPlayerSeekToCallback)(int errorCode);


/// Application scenario.
typedef NS_ENUM(NSUInteger, ZegoScenario) {
    /// General scenario
    ZegoScenarioGeneral = 0,
    /// Communication scenario
    ZegoScenarioCommunication = 1,
    /// Live scenario
    ZegoScenarioLive = 2
};


/// Language.
typedef NS_ENUM(NSUInteger, ZegoLanguage) {
    /// English
    ZegoLanguageEnglish = 0,
    /// Chinese
    ZegoLanguageChinese = 1
};


/// engine state.
typedef NS_ENUM(NSUInteger, ZegoEngineState) {
    /// The engine has started
    ZegoEngineStateStart = 0,
    /// The engine has stoped
    ZegoEngineStateStop = 1
};


/// Room state.
typedef NS_ENUM(NSUInteger, ZegoRoomState) {
    /// Unconnected state, enter this state before logging in and after exiting the room. If there is a steady state abnormality in the process of logging in to the room, such as AppID and AppSign are incorrect, or if the same user name is logged in elsewhere and the local end is KickOut, it will enter this state.
    ZegoRoomStateDisconnected = 0,
    /// The state that the connection is being requested. It will enter this state after successful execution login room function. The display of the UI is usually performed using this state. If the connection is interrupted due to poor network quality, the SDK will perform an internal retry and will return to the requesting connection status.
    ZegoRoomStateConnecting = 1,
    /// The status that is successfully connected. Entering this status indicates that the login to the room has been successful. The user can receive the callback notification of the user and the stream information in the room.
    ZegoRoomStateConnected = 2
};


/// Publish channel.
typedef NS_ENUM(NSUInteger, ZegoPublishChannel) {
    /// Main publish channel
    ZegoPublishChannelMain = 0,
    /// Auxiliary publish channel
    ZegoPublishChannelAux = 1
};


/// Video rendering fill mode.
typedef NS_ENUM(NSUInteger, ZegoViewMode) {
    /// The proportional scaling up, there may be black borders
    ZegoViewModeAspectFit = 0,
    /// The proportional zoom fills the entire View and may be partially cut
    ZegoViewModeAspectFill = 1,
    /// Fill the entire view, the image may be stretched
    ZegoViewModeScaleToFill = 2
};


/// Mirror mode for previewing or playing the of the stream.
typedef NS_ENUM(NSUInteger, ZegoVideoMirrorMode) {
    /// The mirror image only for previewing locally. This mode is used by default.
    ZegoVideoMirrorModeOnlyPreviewMirror = 0,
    /// Both the video previewed locally and the far end playing the stream will see mirror image.
    ZegoVideoMirrorModeBothMirror = 1,
    /// Both the video previewed locally and the far end playing the stream will not see mirror image.
    ZegoVideoMirrorModeNoMirror = 2,
    /// The mirror image only for far end playing the stream.
    ZegoVideoMirrorModeOnlyPublishMirror = 3
};


/// SEI type
typedef NS_ENUM(NSUInteger, ZegoSEIType) {
    /// Using H.264 SEI (nalu type = 6, payload type = 243) type packaging, this type is not specified by the SEI standard, there is no conflict with the video encoder or the SEI in the video file, users do not need to follow the SEI content Do filtering, SDK uses this type by default.
    ZegoSEITypeZegoDefined = 0,
    /// SEI (nalu type = 6, payload type = 5) of H.264 is used for packaging. The H.264 standard has a prescribed format for this type: startcode + nalu type (6) + payload type (5) + len + payload (uuid + content) + trailing bits. Because the video encoder itself generates an SEI with a payload type of 5, or when a video file is used for streaming, such SEI may also exist in the video file, so when using this type, the user needs to use uuid + context as a buffer sending SEI. At this time, in order to distinguish the SEI generated by the video encoder itself, when the App sends this type of SEI, it can fill in the service-specific uuid (uuid length is 16 bytes). When the receiver uses the SDK to parse the SEI of the payload type 5, it will set filter string filters out the SEI matching the uuid and throws it to the business. If the filter string is not set, the SDK will throw all received SEI to the developer. uuid filter string setting function, [ZegoEngineConfig.advancedConfig("unregister_sei_filter","XXXXXX")], where unregister_sei_filter is the key, and XXXXX is the uuid filter string to be set.
    ZegoSEITypeUserUnregister = 1
};


/// Publish stream status.
typedef NS_ENUM(NSUInteger, ZegoPublisherState) {
    /// The state is not published, and it is in this state before publishing the stream. If a steady-state exception occurs in the publish process, such as AppID and AppSign are incorrect, or if other users are already publishing the stream, there will be a failure and enter this state.
    ZegoPublisherStateNoPublish = 0,
    /// The state that it is requesting to publish the stream after the [startPublishingStream] function is successfully called. The UI is usually displayed through this state. If the connection is interrupted due to poor network quality, the SDK will perform an internal retry and will return to the requesting state.
    ZegoPublisherStatePublishRequesting = 1,
    /// The state that the stream is being published, entering the state indicates that the stream has been successfully published, and the user can communicate normally.
    ZegoPublisherStatePublishing = 2
};


/// Voice changer preset value.
typedef NS_ENUM(NSUInteger, ZegoVoiceChangerPreset) {
    /// No Voice changer
    ZegoVoiceChangerPresetNone = 0,
    /// Male to child voice (loli voice effect)
    ZegoVoiceChangerPresetMenToChild = 1,
    /// Male to female voice (kindergarten voice effect)
    ZegoVoiceChangerPresetMenToWomen = 2,
    /// Female to child voice
    ZegoVoiceChangerPresetWomenToChild = 3,
    /// Female to male voice
    ZegoVoiceChangerPresetWomenToMen = 4,
    /// Foreigner voice effect
    ZegoVoiceChangerPresetForeigner = 5,
    /// Autobot Optimus Prime voice effect
    ZegoVoiceChangerPresetOptimusPrime = 6,
    /// Android robot voice effect
    ZegoVoiceChangerPresetAndroid = 7,
    /// Ethereal voice effect
    ZegoVoiceChangerPresetEthereal = 8,
    /// Magnetic(Male) voice effect
    ZegoVoiceChangerPresetMaleMagnetic = 9,
    /// Fresh(Female) voice effect
    ZegoVoiceChangerPresetFemaleFresh = 10
};


/// Reverberation preset value.
typedef NS_ENUM(NSUInteger, ZegoReverbPreset) {
    /// No Reverberation
    ZegoReverbPresetNone = 0,
    /// Soft room reverb effect
    ZegoReverbPresetSoftRoom = 1,
    /// Large room reverb effect
    ZegoReverbPresetLargeRoom = 2,
    /// Concert hall reverb effect
    ZegoReverbPresetConcertHall = 3,
    /// Valley reverb effect
    ZegoReverbPresetValley = 4,
    /// Recording studio reverb effect
    ZegoReverbPresetRecordingStudio = 5,
    /// Basement reverb effect
    ZegoReverbPresetBasement = 6,
    /// KTV reverb effect
    ZegoReverbPresetKTV = 7,
    /// Popular reverb effect
    ZegoReverbPresetPopular = 8,
    /// Rock reverb effect
    ZegoReverbPresetRock = 9,
    /// Vocal concert reverb effect
    ZegoReverbPresetVocalConcert = 10
};


/// Video configuration resolution and bitrate preset enumeration. The preset resolutions are adapted for mobile and desktop. On mobile, height is longer than width, and desktop is the opposite. For example, 1080p is actually 1080(w) x 1920(h) on mobile and 1920(w) x 1080(h) on desktop.
typedef NS_ENUM(NSUInteger, ZegoVideoConfigPreset) {
    /// Set the resolution to 320x180, the default is 15 fps, the code rate is 300 kbps
    ZegoVideoConfigPreset180P = 0,
    /// Set the resolution to 480x270, the default is 15 fps, the code rate is 400 kbps
    ZegoVideoConfigPreset270P = 1,
    /// Set the resolution to 640x360, the default is 15 fps, the code rate is 600 kbps
    ZegoVideoConfigPreset360P = 2,
    /// Set the resolution to 960x540, the default is 15 fps, the code rate is 1200 kbps
    ZegoVideoConfigPreset540P = 3,
    /// Set the resolution to 1280x720, the default is 15 fps, the code rate is 1500 kbps
    ZegoVideoConfigPreset720P = 4,
    /// Set the resolution to 1920x1080, the default is 15 fps, the code rate is 3000 kbps
    ZegoVideoConfigPreset1080P = 5
};


/// Deprecated
/// @deprecated Deprecated, use ZegoVideoConfigPreset instead
typedef NS_ENUM(NSUInteger, ZegoResolution) {
    /// Deprecated
    ZegoResolution180x320 DEPRECATED_ATTRIBUTE = 0,
    /// Deprecated
    ZegoResolution270x480 DEPRECATED_ATTRIBUTE = 1,
    /// Deprecated
    ZegoResolution360x640 DEPRECATED_ATTRIBUTE = 2,
    /// Deprecated
    ZegoResolution540x960 DEPRECATED_ATTRIBUTE = 3,
    /// Deprecated
    ZegoResolution720x1280 DEPRECATED_ATTRIBUTE = 4,
    /// Deprecated
    ZegoResolution1080x1920 DEPRECATED_ATTRIBUTE = 5
};


/// Deprecated
/// @deprecated Deprecated
typedef NS_ENUM(NSUInteger, ZegoPublisherFirstFrameEvent) {
    /// Deprecated
    ZegoPublisherFirstFrameEventAudioCaptured DEPRECATED_ATTRIBUTE = 0,
    /// Deprecated
    ZegoPublisherFirstFrameEventVideoCaptured DEPRECATED_ATTRIBUTE = 1
};


/// Stream quality level.
typedef NS_ENUM(NSUInteger, ZegoStreamQualityLevel) {
    /// Excellent
    ZegoStreamQualityLevelExcellent = 0,
    /// Good
    ZegoStreamQualityLevelGood = 1,
    /// Normal
    ZegoStreamQualityLevelMedium = 2,
    /// Bad
    ZegoStreamQualityLevelBad = 3,
    /// Failed
    ZegoStreamQualityLevelDie = 4
};


/// Audio channel type.
typedef NS_ENUM(NSUInteger, ZegoAudioChannel) {
    /// Unknown
    ZegoAudioChannelUnknown = 0,
    /// Mono
    ZegoAudioChannelMono = 1,
    /// Stereo
    ZegoAudioChannelStereo = 2
};


/// Audio capture stereo mode.
typedef NS_ENUM(NSUInteger, ZegoAudioCaptureStereoMode) {
    /// Disable capture stereo, i.e. capture mono
    ZegoAudioCaptureStereoModeNone = 0,
    /// Always enable capture stereo
    ZegoAudioCaptureStereoModeAlways = 1,
    /// Adaptive mode, capture stereo when publishing stream only, capture mono when publishing and playing stream (e.g. talk/intercom scenes)
    ZegoAudioCaptureStereoModeAdaptive = 2
};


/// Audio mix mode.
typedef NS_ENUM(NSUInteger, ZegoAudioMixMode) {
    /// Default mode, no special behavior
    ZegoAudioMixModeRaw = 0,
    /// Audio focus mode, which can highlight the sound of a certain stream in multiple audio streams
    ZegoAudioMixModeFocused = 1
};


/// Audio Codec ID.
typedef NS_ENUM(NSUInteger, ZegoAudioCodecID) {
    /// default
    ZegoAudioCodecIDDefault = 0,
    /// Normal
    ZegoAudioCodecIDNormal = 1,
    /// Normal2
    ZegoAudioCodecIDNormal2 = 2,
    /// Normal3
    ZegoAudioCodecIDNormal3 = 3,
    /// Low
    ZegoAudioCodecIDLow = 4,
    /// Low2
    ZegoAudioCodecIDLow2 = 5,
    /// Low3
    ZegoAudioCodecIDLow3 = 6
};


/// Video codec ID.
typedef NS_ENUM(NSUInteger, ZegoVideoCodecID) {
    /// Default (H.264)
    ZegoVideoCodecIDDefault = 0,
    /// Scalable Video Coding (H.264 SVC)
    ZegoVideoCodecIDSVC = 1,
    /// VP8
    ZegoVideoCodecIDVP8 = 2,
    /// H.265
    ZegoVideoCodecIDH265 = 3
};


/// Player video layer.
typedef NS_ENUM(NSUInteger, ZegoPlayerVideoLayer) {
    /// The layer to be played depends on the network status
    ZegoPlayerVideoLayerAuto = 0,
    /// Play the base layer (small resolution)
    ZegoPlayerVideoLayerBase = 1,
    /// Play the extend layer (big resolution)
    ZegoPlayerVideoLayerBaseExtend = 2
};


/// Video stream type
typedef NS_ENUM(NSUInteger, ZegoVideoStreamType) {
    /// The type to be played depends on the network status
    ZegoVideoStreamTypeDefault = 0,
    /// small resolution type
    ZegoVideoStreamTypeSmall = 1,
    /// big resolution type
    ZegoVideoStreamTypeBig = 2
};


/// Audio echo cancellation mode.
typedef NS_ENUM(NSUInteger, ZegoAECMode) {
    /// Aggressive echo cancellation may affect the sound quality slightly, but the echo will be very clean
    ZegoAECModeAggressive = 0,
    /// Moderate echo cancellation, which may slightly affect a little bit of sound, but the residual echo will be less
    ZegoAECModeMedium = 1,
    /// Comfortable echo cancellation, that is, echo cancellation does not affect the sound quality of the sound, and sometimes there may be a little echo, but it will not affect the normal listening.
    ZegoAECModeSoft = 2
};


/// Active Noise Suppression mode.
typedef NS_ENUM(NSUInteger, ZegoANSMode) {
    /// Soft ANS. It may significantly impair the sound quality, but it has a good noise reduction effect.
    ZegoANSModeSoft = 0,
    /// Medium ANS. It may damage some sound quality, but it has a good noise reduction effect.
    ZegoANSModeMedium = 1,
    /// Aggressive ANS. In most instances, the sound quality will not be damaged, but some noise will remain.
    ZegoANSModeAggressive = 2
};


/// Traffic control property (bitmask enumeration).
typedef NS_OPTIONS(NSUInteger, ZegoTrafficControlProperty) {
    /// Basic
    ZegoTrafficControlPropertyBasic = 0,
    /// Adaptive FPS
    ZegoTrafficControlPropertyAdaptiveFPS = 1,
    /// Adaptive resolution
    ZegoTrafficControlPropertyAdaptiveResolution = 1 << 1,
    /// Adaptive Audio bitrate
    ZegoTrafficControlPropertyAdaptiveAudioBitrate = 1 << 2
};


/// Video transmission mode when current bitrate is lower than the set minimum bitrate.
typedef NS_ENUM(NSUInteger, ZegoTrafficControlMinVideoBitrateMode) {
    /// Stop video transmission when current bitrate is lower than the set minimum bitrate
    ZegoTrafficControlMinVideoBitrateModeNoVideo = 0,
    /// Video is sent at a very low frequency (no more than 2fps) which is lower than the set minimum bitrate
    ZegoTrafficControlMinVideoBitrateModeUltraLowFPS = 1
};


/// Factors that trigger traffic control
typedef NS_ENUM(NSUInteger, ZegoTrafficControlFocusOnMode) {
    /// Focus only on the local network
    ZegoTrafficControlFounsOnLocalOnly = 0,
    /// Pay attention to the local network, but also take into account the remote network, currently only effective in the 1v1 scenario
    ZegoTrafficControlFounsOnRemote = 1
};


/// Playing stream status.
typedef NS_ENUM(NSUInteger, ZegoPlayerState) {
    /// The state of the flow is not played, and it is in this state before the stream is played. If the steady flow anomaly occurs during the playing process, such as AppID and AppSign are incorrect, it will enter this state.
    ZegoPlayerStateNoPlay = 0,
    /// The state that the stream is being requested for playing. After the [startPlayingStream] function is successfully called, it will enter the state. The UI is usually displayed through this state. If the connection is interrupted due to poor network quality, the SDK will perform an internal retry and will return to the requesting state.
    ZegoPlayerStatePlayRequesting = 1,
    /// The state that the stream is being playing, entering the state indicates that the stream has been successfully played, and the user can communicate normally.
    ZegoPlayerStatePlaying = 2
};


/// Media event when playing.
typedef NS_ENUM(NSUInteger, ZegoPlayerMediaEvent) {
    /// Audio stuck event when playing
    ZegoPlayerMediaEventAudioBreakOccur = 0,
    /// Audio stuck event recovery when playing
    ZegoPlayerMediaEventAudioBreakResume = 1,
    /// Video stuck event when playing
    ZegoPlayerMediaEventVideoBreakOccur = 2,
    /// Video stuck event recovery when playing
    ZegoPlayerMediaEventVideoBreakResume = 3
};


/// Deprecated
/// @deprecated Deprecated
typedef NS_ENUM(NSUInteger, ZegoPlayerFirstFrameEvent) {
    /// Deprecated
    ZegoPlayerFirstFrameEventAudioRcv DEPRECATED_ATTRIBUTE = 0,
    /// Deprecated
    ZegoPlayerFirstFrameEventVideoRcv DEPRECATED_ATTRIBUTE = 1,
    /// Deprecated
    ZegoPlayerFirstFrameEventVideoRender DEPRECATED_ATTRIBUTE = 2
};


/// Stream Resource Mode
typedef NS_ENUM(NSUInteger, ZegoStreamResourceMode) {
    /// Default mode. The SDK will automatically select the streaming resource according to the cdnConfig parameters set by the player config and the ready-made background configuration.
    ZegoStreamResourceModeDefault = 0,
    /// Playing stream only from CDN.
    ZegoStreamResourceModeOnlyCDN = 1,
    /// Playing stream only from L3.
    ZegoStreamResourceModeOnlyL3 = 2,
    /// Playing stream only from RTC.
    ZegoStreamResourceModeOnlyRTC = 3
};


/// Update type.
typedef NS_ENUM(NSUInteger, ZegoUpdateType) {
    /// Add
    ZegoUpdateTypeAdd = 0,
    /// Delete
    ZegoUpdateTypeDelete = 1
};


/// State of CDN relay.
typedef NS_ENUM(NSUInteger, ZegoStreamRelayCDNState) {
    /// The state indicates that there is no CDN relay
    ZegoStreamRelayCDNStateNoRelay = 0,
    /// The CDN relay is being requested
    ZegoStreamRelayCDNStateRelayRequesting = 1,
    /// Entering this status indicates that the CDN relay has been successful
    ZegoStreamRelayCDNStateRelaying = 2
};


/// Reason for state of CDN relay changed.
typedef NS_ENUM(NSUInteger, ZegoStreamRelayCDNUpdateReason) {
    /// No error
    ZegoStreamRelayCDNUpdateReasonNone = 0,
    /// Server error
    ZegoStreamRelayCDNUpdateReasonServerError = 1,
    /// Handshake error
    ZegoStreamRelayCDNUpdateReasonHandshakeFailed = 2,
    /// Access point error
    ZegoStreamRelayCDNUpdateReasonAccessPointError = 3,
    /// Stream create failure
    ZegoStreamRelayCDNUpdateReasonCreateStreamFailed = 4,
    /// Bad name
    ZegoStreamRelayCDNUpdateReasonBadName = 5,
    /// CDN server actively disconnected
    ZegoStreamRelayCDNUpdateReasonCDNServerDisconnected = 6,
    /// Active disconnect
    ZegoStreamRelayCDNUpdateReasonDisconnected = 7,
    /// All mixer input streams sessions closed
    ZegoStreamRelayCDNUpdateReasonMixStreamAllInputStreamClosed = 8,
    /// All mixer input streams have no data
    ZegoStreamRelayCDNUpdateReasonMixStreamAllInputStreamNoData = 9,
    /// Internal error of stream mixer server
    ZegoStreamRelayCDNUpdateReasonMixStreamServerInternalError = 10
};


/// Beauty feature (bitmask enumeration).
typedef NS_OPTIONS(NSUInteger, ZegoBeautifyFeature) {
    /// No beautifying
    ZegoBeautifyFeatureNone = 0,
    /// Polish
    ZegoBeautifyFeaturePolish = 1 << 0,
    /// Sharpen
    ZegoBeautifyFeatureWhiten = 1 << 1,
    /// Skin whiten
    ZegoBeautifyFeatureSkinWhiten = 1 << 2,
    /// Whiten
    ZegoBeautifyFeatureSharpen = 1 << 3
};


/// Remote device status.
typedef NS_ENUM(NSUInteger, ZegoRemoteDeviceState) {
    /// Device on
    ZegoRemoteDeviceStateOpen = 0,
    /// General device error
    ZegoRemoteDeviceStateGenericError = 1,
    /// Invalid device ID
    ZegoRemoteDeviceStateInvalidID = 2,
    /// No permission
    ZegoRemoteDeviceStateNoAuthorization = 3,
    /// Captured frame rate is 0
    ZegoRemoteDeviceStateZeroFPS = 4,
    /// The device is occupied
    ZegoRemoteDeviceStateInUseByOther = 5,
    /// The device is not plugged in or unplugged
    ZegoRemoteDeviceStateUnplugged = 6,
    /// The system needs to be restarted
    ZegoRemoteDeviceStateRebootRequired = 7,
    /// System media services stop, such as under the iOS platform, when the system detects that the current pressure is huge (such as playing a lot of animation), it is possible to disable all media related services.
    ZegoRemoteDeviceStateSystemMediaServicesLost = 8,
    /// Capturing disabled
    ZegoRemoteDeviceStateDisable = 9,
    /// The remote device is muted
    ZegoRemoteDeviceStateMute = 10,
    /// The device is interrupted, such as a phone call interruption, etc.
    ZegoRemoteDeviceStateInterruption = 11,
    /// There are multiple apps at the same time in the foreground, such as the iPad app split screen, the system will prohibit all apps from using the camera.
    ZegoRemoteDeviceStateInBackground = 12,
    /// CDN server actively disconnected
    ZegoRemoteDeviceStateMultiForegroundApp = 13,
    /// The system is under high load pressure and may cause abnormal equipment.
    ZegoRemoteDeviceStateBySystemPressure = 14
};


/// Audio device type.
typedef NS_ENUM(NSUInteger, ZegoAudioDeviceType) {
    /// Audio input type
    ZegoAudioDeviceTypeInput = 0,
    /// Audio output type
    ZegoAudioDeviceTypeOutput = 1
};


/// Audio route
typedef NS_ENUM(NSUInteger, ZegoAudioRoute) {
    /// Speaker
    ZegoAudioRouteSpeaker = 0,
    /// Headphone
    ZegoAudioRouteHeadphone = 1,
    /// Bluetooth device
    ZegoAudioRouteBluetooth = 2,
    /// Receiver
    ZegoAudioRouteReceiver = 3,
    /// External USB audio device
    ZegoAudioRouteExternalUSB = 4,
    /// Apple AirPlay
    ZegoAudioRouteAirPlay = 5
};


/// Mix stream content type.
typedef NS_ENUM(NSUInteger, ZegoMixerInputContentType) {
    /// Mix stream for audio only
    ZegoMixerInputContentTypeAudio = 0,
    /// Mix stream for both audio and video
    ZegoMixerInputContentTypeVideo = 1
};


/// Capture pipeline scale mode.
typedef NS_ENUM(NSUInteger, ZegoCapturePipelineScaleMode) {
    /// Zoom immediately after acquisition, default
    ZegoCapturePipelineScaleModePre = 0,
    /// Scaling while encoding
    ZegoCapturePipelineScaleModePost = 1
};


/// Video frame format.
typedef NS_ENUM(NSUInteger, ZegoVideoFrameFormat) {
    /// Unknown format, will take platform default
    ZegoVideoFrameFormatUnknown = 0,
    /// I420 (YUV420Planar) format
    ZegoVideoFrameFormatI420 = 1,
    /// NV12 (YUV420SemiPlanar) format
    ZegoVideoFrameFormatNV12 = 2,
    /// NV21 (YUV420SemiPlanar) format
    ZegoVideoFrameFormatNV21 = 3,
    /// BGRA32 format
    ZegoVideoFrameFormatBGRA32 = 4,
    /// RGBA32 format
    ZegoVideoFrameFormatRGBA32 = 5,
    /// ARGB32 format
    ZegoVideoFrameFormatARGB32 = 6,
    /// ABGR32 format
    ZegoVideoFrameFormatABGR32 = 7,
    /// I422 (YUV422Planar) format
    ZegoVideoFrameFormatI422 = 8
};


/// Video encoded frame format.
typedef NS_ENUM(NSUInteger, ZegoVideoEncodedFrameFormat) {
    /// AVC AVCC format
    ZegoVideoEncodedFrameFormatAVCC = 0,
    /// AVC Annex-B format
    ZegoVideoEncodedFrameFormatAnnexB = 1
};


/// Video frame buffer type.
typedef NS_ENUM(NSUInteger, ZegoVideoBufferType) {
    /// Raw data type video frame
    ZegoVideoBufferTypeUnknown = 0,
    /// Raw data type video frame
    ZegoVideoBufferTypeRawData = 1,
    /// Encoded data type video frame
    ZegoVideoBufferTypeEncodedData = 2,
    /// Texture 2D type video frame
    ZegoVideoBufferTypeGLTexture2D = 3,
    /// CVPixelBuffer type video frame
    ZegoVideoBufferTypeCVPixelBuffer = 4
};


/// Video frame format series.
typedef NS_ENUM(NSUInteger, ZegoVideoFrameFormatSeries) {
    /// RGB series
    ZegoVideoFrameFormatSeriesRGB = 0,
    /// YUV series
    ZegoVideoFrameFormatSeriesYUV = 1
};


/// Video frame flip mode.
typedef NS_ENUM(NSUInteger, ZegoVideoFlipMode) {
    /// No flip
    ZegoVideoFlipModeNone = 0,
    /// X-axis flip
    ZegoVideoFlipModeX = 1,
    /// Y-axis flip
    ZegoVideoFlipModeY = 2,
    /// X-Y-axis flip
    ZegoVideoFlipModeXY = 3
};


/// Customize the audio processing configuration type.
typedef NS_ENUM(NSUInteger, ZegoCustomAudioProcessType) {
    /// Remote audio processing
    ZegoCustomAudioProcessTypeRemote = 0,
    /// Capture audio processing
    ZegoCustomAudioProcessTypeCapture = 1,
    /// Remote audio and capture audio processing
    ZegoCustomAudioProcessTypeCaptureAndRemote = 2
};


/// Audio Config Preset.
typedef NS_ENUM(NSUInteger, ZegoAudioConfigPreset) {
    /// Basic sound quality (16 kbps, Mono, ZegoAudioCodecIDDefault)
    ZegoAudioConfigPresetBasicQuality = 0,
    /// Standard sound quality (48 kbps, Mono, ZegoAudioCodecIDDefault)
    ZegoAudioConfigPresetStandardQuality = 1,
    /// Standard sound quality (56 kbps, Stereo, ZegoAudioCodecIDDefault)
    ZegoAudioConfigPresetStandardQualityStereo = 2,
    /// High sound quality (128 kbps, Mono, ZegoAudioCodecIDDefault)
    ZegoAudioConfigPresetHighQuality = 3,
    /// High sound quality (192 kbps, Stereo, ZegoAudioCodecIDDefault)
    ZegoAudioConfigPresetHighQualityStereo = 4
};


/// Player state.
typedef NS_ENUM(NSUInteger, ZegoMediaPlayerState) {
    /// Not playing
    ZegoMediaPlayerStateNoPlay = 0,
    /// Playing
    ZegoMediaPlayerStatePlaying = 1,
    /// Pausing
    ZegoMediaPlayerStatePausing = 2,
    /// End of play
    ZegoMediaPlayerStatePlayEnded = 3
};


/// Player network event.
typedef NS_ENUM(NSUInteger, ZegoMediaPlayerNetworkEvent) {
    /// Network resources are not playing well, and start trying to cache data
    ZegoMediaPlayerNetworkEventBufferBegin = 0,
    /// Network resources can be played smoothly
    ZegoMediaPlayerNetworkEventBufferEnded = 1
};


/// Audio channel.
typedef NS_ENUM(NSUInteger, ZegoMediaPlayerAudioChannel) {
    /// Audio channel left
    ZegoMediaPlayerAudioChannelLeft = 0,
    /// Audio channel right
    ZegoMediaPlayerAudioChannelRight = 1,
    /// Audio channel all
    ZegoMediaPlayerAudioChannelAll = 2
};


/// AudioEffectPlayer state.
typedef NS_ENUM(NSUInteger, ZegoAudioEffectPlayState) {
    /// Not playing
    ZegoAudioEffectPlayStateNoPlay = 0,
    /// Playing
    ZegoAudioEffectPlayStatePlaying = 1,
    /// Pausing
    ZegoAudioEffectPlayStatePausing = 2,
    /// End of play
    ZegoAudioEffectPlayStatePlayEnded = 3
};


/// volume type.
typedef NS_ENUM(NSUInteger, ZegoVolumeType) {
    /// volume local
    ZegoVolumeTypeLocal = 0,
    /// volume remote
    ZegoVolumeTypeRemote = 1
};


/// audio sample rate.
typedef NS_ENUM(NSUInteger, ZegoAudioSampleRate) {
    /// Unknown
    ZegoAudioSampleRateUnknown = 0,
    /// 8K
    ZegoAudioSampleRate8K = 8000,
    /// 16K
    ZegoAudioSampleRate16K = 16000,
    /// 22.05K
    ZegoAudioSampleRate22K = 22050,
    /// 24K
    ZegoAudioSampleRate24K = 24000,
    /// 32K
    ZegoAudioSampleRate32K = 32000,
    /// 44.1K
    ZegoAudioSampleRate44K = 44100,
    /// 48K
    ZegoAudioSampleRate48K = 48000
};


/// Audio capture source type.
typedef NS_ENUM(NSUInteger, ZegoAudioSourceType) {
    /// Default audio capture source (the main channel uses custom audio capture by default; the aux channel uses the same sound as main channel by default)
    ZegoAudioSourceTypeDefault = 0,
    /// Use custom audio capture, refer to [enableCustomAudioIO]
    ZegoAudioSourceTypeCustom = 1,
    /// Use media player as audio source, only support aux channel
    ZegoAudioSourceTypeMediaPlayer = 2
};


/// Record type.
typedef NS_ENUM(NSUInteger, ZegoDataRecordType) {
    /// This field indicates that the Express-Audio SDK records audio by default, and the Express-Video SDK records audio and video by default. When recording files in .aac format, audio is also recorded by default.
    ZegoDataRecordTypeDefault = 0,
    /// only record audio
    ZegoDataRecordTypeOnlyAudio = 1,
    /// only record video, Audio SDK and recording .aac format files are invalid.
    ZegoDataRecordTypeOnlyVideo = 2,
    /// record audio and video. Express-Audio SDK and .aac format files are recorded only audio.
    ZegoDataRecordTypeAudioAndVideo = 3
};


/// Record state.
typedef NS_ENUM(NSUInteger, ZegoDataRecordState) {
    /// Unrecorded state, which is the state when a recording error occurs or before recording starts.
    ZegoDataRecordStateNoRecord = 0,
    /// Recording in progress, in this state after successfully call [startRecordingCapturedData] function
    ZegoDataRecordStateRecording = 1,
    /// Record successs
    ZegoDataRecordStateSuccess = 2
};


/// Audio data callback function enable bitmask enumeration.
typedef NS_OPTIONS(NSUInteger, ZegoAudioDataCallbackBitMask) {
    /// The mask bit of this field corresponds to the enable [onCapturedAudioData] callback function
    ZegoAudioDataCallbackBitMaskCaptured = 1 << 0,
    /// The mask bit of this field corresponds to the enable [onPlaybackAudioData] callback function
    ZegoAudioDataCallbackBitMaskPlayback = 1 << 1,
    /// The mask bit of this field corresponds to the enable [onMixedAudioData] callback function
    ZegoAudioDataCallbackBitMaskMixed = 1 << 2,
    /// The mask bit of this field corresponds to the enable [onPlayerAudioData] callback function
    ZegoAudioDataCallbackBitMaskPlayer = 1 << 3
};


/// Network mode
typedef NS_ENUM(NSUInteger, ZegoNetworkMode) {
    /// Offline (No network)
    ZegoNetworkModeOffline = 0,
    /// Unknown network mode
    ZegoNetworkModeUnknown = 1,
    /// Wired Ethernet (LAN)
    ZegoNetworkModeEthernet = 2,
    /// Wi-Fi (WLAN)
    ZegoNetworkModeWiFi = 3,
    /// 2G Network (GPRS/EDGE/CDMA1x/etc.)
    ZegoNetworkMode2G = 4,
    /// 3G Network (WCDMA/HSDPA/EVDO/etc.)
    ZegoNetworkMode3G = 5,
    /// 4G Network (LTE)
    ZegoNetworkMode4G = 6,
    /// 5G Network (NR (NSA/SA))
    ZegoNetworkMode5G = 7
};


/// network speed test type
typedef NS_ENUM(NSUInteger, ZegoNetworkSpeedTestType) {
    /// uplink
    ZegoNetworkSpeedTestTypeUplink = 0,
    /// downlink
    ZegoNetworkSpeedTestTypeDownlink = 1
};


/// Log config.
///
/// Configure the log file save path and the maximum log file size.
@interface ZegoLogConfig : NSObject

/// The log file save path. The default path is [NSCachesDirectory]/ZegoLogs/
@property (nonatomic, copy) NSString *logPath;

/// The maximum log file size (Bytes). The default maximum size is 5MB (5 * 1024 * 1024 Bytes)
@property (nonatomic, assign) unsigned long long logSize;

@end


/// Custom video capture configuration.
///
/// Custom video capture, that is, the developer is responsible for collecting video data and sending the collected video data to SDK for video data encoding and publishing to the ZEGO RTC server. This feature is generally used by developers who use third-party beauty features or record game screen living.
/// When you need to use the custom video capture function, you need to set an instance of this class as a parameter to the [enableCustomVideoCapture] function.
/// Because when using custom video capture, SDK will no longer start the camera to capture video data. You need to collect video data from video sources by yourself.
@interface ZegoCustomVideoCaptureConfig : NSObject

/// Custom video capture video frame data type
@property (nonatomic, assign) ZegoVideoBufferType bufferType;

@end


/// Custom video process configuration.
@interface ZegoCustomVideoProcessConfig : NSObject

/// Custom video process video frame data type. The default value is [ZegoVideoBufferTypeCVPixelBuffer].
@property (nonatomic, assign) ZegoVideoBufferType bufferType;

@end


/// Custom video render configuration.
///
/// When you need to use the custom video render function, you need to set an instance of this class as a parameter to the [enableCustomVideoRender] function.
@interface ZegoCustomVideoRenderConfig : NSObject

/// Custom video capture video frame data type
@property (nonatomic, assign) ZegoVideoBufferType bufferType;

/// Custom video rendering video frame data format。Useless when set bufferType as [EncodedData]
@property (nonatomic, assign) ZegoVideoFrameFormatSeries frameFormatSeries;

/// Whether the engine also renders while customizing video rendering. The default value is [false]. Useless when set bufferType as [EncodedData]
@property (nonatomic, assign) BOOL enableEngineRender;

@end


/// Custom audio configuration.
@interface ZegoCustomAudioConfig : NSObject

/// Audio capture source type
@property (nonatomic, assign) ZegoAudioSourceType sourceType;

@end


/// Advanced engine configuration.
@interface ZegoEngineConfig : NSObject

/// @deprecated This property has been deprecated since version 2.3.0, please use the [setLogConfig] function instead.
@property (nonatomic, strong, nullable) ZegoLogConfig *logConfig DEPRECATED_ATTRIBUTE;

/// Other special function switches, if not set, no special function will be used by default. Please contact ZEGO technical support before use.
@property (nonatomic, copy, nullable) NSDictionary<NSString *, NSString *> *advancedConfig;

@end


/// Advanced room configuration.
///
/// Configure maximum number of users in the room and authentication token, etc.
@interface ZegoRoomConfig : NSObject

/// The maximum number of users in the room, Passing 0 means unlimited, the default is unlimited.
@property (nonatomic, assign) unsigned int maxMemberCount;

/// Whether to enable the user in and out of the room callback notification [onRoomUserUpdate], the default is off. If developers need to use ZEGO Room user notifications, make sure that each user who login sets this flag to true
@property (nonatomic, assign) BOOL isUserStatusNotify;

/// The token issued by the developer's business server is used to ensure security. The generation rules are detailed in Room Login Authentication Description https://doc-en.zego.im/article/3881 Default is empty string, that is, no authentication
@property (nonatomic, copy) NSString *token;

/// Create a default room configuration
///
/// The default configuration parameters are: the maximum number of users in the room is unlimited, the user will not be notified when the user enters or leaves the room, no authentication.
///
/// @return ZegoRoomConfig instance
+ (instancetype)defaultConfig;

@end


/// Video config.
///
/// Configure parameters used for publishing stream, such as bitrate, frame rate, and resolution.
/// Developers should note that the width and height resolution of the mobile and desktop are opposite. For example, 360p, the resolution of the mobile is 360x640, and the desktop is 640x360.
@interface ZegoVideoConfig : NSObject

/// Capture resolution, control the resolution of camera image acquisition. SDK requires the width and height to be set to even numbers. Only the camera is not started and the custom video capture is not used, the setting is effective. For performance reasons, the SDK scales the video frame to the encoding resolution after capturing from camera and before rendering to the preview view. Therefore, the resolution of the preview image is the encoding resolution. If you need the resolution of the preview image to be this value, Please call [setCapturePipelineScaleMode] first to change the capture pipeline scale mode to [Post]
@property (nonatomic, assign) CGSize captureResolution;

/// Encode resolution, control the image resolution of the encoder when publishing stream. SDK requires the width and height to be set to even numbers. The settings before and after publishing stream can be effective
@property (nonatomic, assign) CGSize encodeResolution;

/// Frame rate, control the frame rate of the camera and the frame rate of the encoder. Only the camera is not started, the setting is effective
@property (nonatomic, assign) int fps;

/// Bit rate in kbps. The settings before and after publishing stream can be effective
@property (nonatomic, assign) int bitrate;

/// The codec id to be used, the default value is [default]. Settings only take effect before publishing stream
@property (nonatomic, assign) ZegoVideoCodecID codecID;

/// Create default video configuration(360p, 15fps, 600kbps)
///
/// 360p, 15fps, 600kbps
///
/// @return ZegoVideoConfig instance
+ (instancetype)defaultConfig;

/// Create video configuration with preset enumeration values
///
/// @return ZegoVideoConfig instance
+ (instancetype)configWithPreset:(ZegoVideoConfigPreset)preset;

/// Create video configuration with preset enumeration values
///
/// @return ZegoVideoConfig instance
- (instancetype)initWithPreset:(ZegoVideoConfigPreset)preset;

/// This function is deprecated
///
/// please use [+configWithPreset:] instead
+ (instancetype)configWithResolution:(ZegoResolution)resolution DEPRECATED_ATTRIBUTE;

/// This function is deprecated
///
/// please use [-initWithPreset:] instead
- (instancetype)initWithResolution:(ZegoResolution)resolution DEPRECATED_ATTRIBUTE;

@end


/// Externally encoded data traffic control information.
@interface ZegoTrafficControlInfo : NSObject

/// Video FPS to be adjusted
@property (nonatomic, assign) int fps;

/// Video bitrate in kbps to be adjusted
@property (nonatomic, assign) int bitrate;

/// Video resolution to be adjusted
@property (nonatomic, assign) CGSize resolution;

@end


/// SEI configuration
///
/// Used to set the relevant configuration of the Supplemental Enhancement Information.
@interface ZegoSEIConfig : NSObject

/// SEI type
@property (nonatomic, assign) ZegoSEIType type;

/// Create a default SEI config object
///
/// @return ZegoSEIConfig instance
+ (instancetype)defaultConfig;

@end


/// Voice changer parameter.
///
/// Developer can use the built-in presets of the SDK to change the parameters of the voice changer.
@interface ZegoVoiceChangerParam : NSObject

/// Pitch parameter, value range [-8.0, 8.0], the larger the value, the sharper the sound, set it to 0.0 to turn off. Note that the voice changer effect is only valid for the captured sound.
@property (nonatomic, assign) float pitch;

/// Create voice changer param configuration with preset enumeration values
///
/// @deprecated This function is deprecated after 1.17.0. Please use the ZegoExpressEngine's [setVoiceChangerPreset] function instead
/// @return ZegoVoiceChangerParam instance
+ (instancetype)paramWithPreset:(ZegoVoiceChangerPreset)preset DEPRECATED_ATTRIBUTE;

/// Create voice changer param configuration with preset enumeration values
///
/// @deprecated This function is deprecated after 1.17.0. Please use the ZegoExpressEngine's [setVoiceChangerPreset] function instead
/// @return ZegoVoiceChangerParam instance
- (instancetype)initWithPreset:(ZegoVoiceChangerPreset)preset DEPRECATED_ATTRIBUTE;

@end


/// Audio reverberation parameters.
///
/// Developers can use the SDK's built-in presets to change the parameters of the reverb.
@interface ZegoReverbParam : NSObject

/// Room size, in the range [0.0, 1.0], to control the size of the "room" in which the reverb is generated, the larger the room, the stronger the reverb.
@property (nonatomic, assign) float roomSize;

/// Echo, in the range [0.0, 0.5], to control the trailing length of the reverb.
@property (nonatomic, assign) float reverberance;

/// Reverb Damping, range [0.0, 2.0], controls the attenuation of the reverb, the higher the damping, the higher the attenuation.
@property (nonatomic, assign) float damping;

/// Dry/wet ratio, the range is greater than or equal to 0.0, to control the ratio between reverberation, direct sound and early reflections; dry part is set to 1 by default; the smaller the dry/wet ratio, the larger the wet ratio, the stronger the reverberation effect.
@property (nonatomic, assign) float dryWetRatio;

/// Create reverb param configuration with preset enumeration values
///
/// @deprecated This function is deprecated after 1.17.0. Please use the ZegoExpressEngine's [setReverbPreset] function instead
/// @return ZegoReverbParam instance
+ (instancetype)paramWithPreset:(ZegoReverbPreset)preset DEPRECATED_ATTRIBUTE;

/// Create reverb param configuration with preset enumeration values
///
/// @deprecated This function is deprecated after 1.17.0. Please use the ZegoExpressEngine's [setReverbPreset] function instead
/// @return ZegoReverbParam instance
- (instancetype)initWithPreset:(ZegoReverbPreset)preset DEPRECATED_ATTRIBUTE;

@end


/// Audio reverberation advanced parameters.
///
/// Developers can use the SDK's built-in presets to change the parameters of the reverb.
@interface ZegoReverbAdvancedParam : NSObject

/// Room size(%), in the range [0.0, 1.0], to control the size of the "room" in which the reverb is generated, the larger the room, the stronger the reverb.
@property (nonatomic, assign) float roomSize;

/// Echo(%), in the range [0.0, 100.0], to control the trailing length of the reverb.
@property (nonatomic, assign) float reverberance;

/// Reverb Damping(%), range [0.0, 100.0], controls the attenuation of the reverb, the higher the damping, the higher the attenuation.
@property (nonatomic, assign) float damping;

/// only wet
@property (nonatomic, assign) BOOL wetOnly;

/// wet gain(dB), range [-20.0, 10.0]
@property (nonatomic, assign) float wetGain;

/// dry gain(dB), range [-20.0, 10.0]
@property (nonatomic, assign) float dryGain;

/// Tone Low. 100% by default
@property (nonatomic, assign) float toneLow;

/// Tone High. 100% by default
@property (nonatomic, assign) float toneHigh;

/// PreDelay(ms), range [0.0, 200.0]
@property (nonatomic, assign) float preDelay;

/// Stereo Width(%). 0% by default
@property (nonatomic, assign) float stereoWidth;

@end


/// Audio reverberation echo parameters.
@interface ZegoReverbEchoParam : NSObject

/// Gain of input audio signal, in the range [0.0, 1.0]
@property (nonatomic, assign) float inGain;

/// Gain of output audio signal, in the range [0.0, 1.0]
@property (nonatomic, assign) float outGain;

/// Number of echos, in the range [0, 7]
@property (nonatomic, assign) int numDelays;

/// Respective delay of echo signal, in milliseconds, in the range [0, 5000] ms
@property (nonatomic, copy) NSArray<NSNumber *> *delay;

/// Respective decay coefficient of echo signal, in the range [0.0, 1.0]
@property (nonatomic, copy) NSArray<NSNumber *> *decay;

@end


/// User object.
///
/// Configure user ID and username to identify users in the room.
/// Note that the userID must be unique under the same appID, otherwise mutual kicks out will occur.
/// It is strongly recommended that userID corresponds to the user ID of the business APP, that is, a userID and a real user are fixed and unique, and should not be passed to the SDK in a random userID. Because the unique and fixed userID allows ZEGO technicians to quickly locate online problems.
@interface ZegoUser : NSObject

/// User ID, a string with a maximum length of 64 bytes or less.Please do not fill in sensitive user information in this field, including but not limited to mobile phone number, ID number, passport number, real name, etc. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
@property (nonatomic, copy) NSString *userID;

/// User Name, a string with a maximum length of 256 bytes or less.Please do not fill in sensitive user information in this field, including but not limited to mobile phone number, ID number, passport number, real name, etc.
@property (nonatomic, copy) NSString *userName;

/// Create a ZegoUser object
///
/// userName and userID are set to match
///
/// @return ZegoUser instance
+ (instancetype)userWithUserID:(NSString *)userID;

/// Create a ZegoUser object
///
/// userName and userID are set to match
- (instancetype)initWithUserID:(NSString *)userID;

/// Create a ZegoUser object
///
/// @return ZegoUser instance
+ (instancetype)userWithUserID:(NSString *)userID userName:(NSString *)userName;

/// Create a ZegoUser object
///
/// @return ZegoUser instance
- (instancetype)initWithUserID:(NSString *)userID userName:(NSString *)userName;

@end


/// Stream object.
///
/// Identify an stream object
@interface ZegoStream : NSObject

/// User object instance.Please do not fill in sensitive user information in this field, including but not limited to mobile phone number, ID number, passport number, real name, etc.
@property (nonatomic, strong) ZegoUser *user;

/// Stream ID, a string of up to 256 characters. You cannot include URL keywords, otherwise publishing stream and playing stream will fails. Only support numbers, English characters and '~', '!', '@', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
@property (nonatomic, copy) NSString *streamID;

/// Stream extra info
@property (nonatomic, copy) NSString *extraInfo;

@end


/// Room extra information.
@interface ZegoRoomExtraInfo : NSObject

/// The key of the room extra information.
@property (nonatomic, copy) NSString *key;

/// The value of the room extra information.
@property (nonatomic, copy) NSString *value;

/// The user who update the room extra information.Please do not fill in sensitive user information in this field, including but not limited to mobile phone number, ID number, passport number, real name, etc.
@property (nonatomic, strong) ZegoUser *updateUser;

/// Update time of the room extra information, UNIX timestamp, in milliseconds.
@property (nonatomic, assign) unsigned long long updateTime;

@end


/// View object.
///
/// Configure view object, view Mode, background color
@interface ZegoCanvas : NSObject

/// View object
@property (nonatomic, strong) ZGView *view;

/// View mode, default is ZegoViewModeAspectFit
@property (nonatomic, assign) ZegoViewMode viewMode;

/// Background color, the format is 0xRRGGBB, default is black, which is 0x000000
@property (nonatomic, assign) int backgroundColor;

/// Create a ZegoCanvas, default viewMode is ZegoViewModeAspectFit, default background color is black
///
/// @return ZegoCanvas instance
+ (instancetype)canvasWithView:(ZGView *)view;

/// Create a ZegoCanvas, default viewMode is ZegoViewModeAspectFit, default background color is black
///
/// @return ZegoCanvas instance
- (instancetype)initWithView:(ZGView *)view;

@end


/// Published stream quality information.
///
/// Audio and video parameters and network quality, etc.
@interface ZegoPublishStreamQuality : NSObject

/// Video capture frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double videoCaptureFPS;

/// Video encoding frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double videoEncodeFPS;

/// Video transmission frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double videoSendFPS;

/// Video bit rate in kbps
@property (nonatomic, assign) double videoKBPS;

/// Audio capture frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double audioCaptureFPS;

/// Audio transmission frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double audioSendFPS;

/// Audio bit rate in kbps
@property (nonatomic, assign) double audioKBPS;

/// Local to server delay, in milliseconds
@property (nonatomic, assign) int rtt;

/// Packet loss rate, in percentage, 0.0 ~ 1.0
@property (nonatomic, assign) double packetLostRate;

/// Published stream quality level
@property (nonatomic, assign) ZegoStreamQualityLevel level;

/// Whether to enable hardware encoding
@property (nonatomic, assign) BOOL isHardwareEncode;

/// Video codec ID
@property (nonatomic, assign) ZegoVideoCodecID videoCodecID;

/// Total number of bytes sent, including audio, video, SEI
@property (nonatomic, assign) double totalSendBytes;

/// Number of audio bytes sent
@property (nonatomic, assign) double audioSendBytes;

/// Number of video bytes sent
@property (nonatomic, assign) double videoSendBytes;

@end


/// CDN config object.
///
/// Includes CDN URL and authentication parameter string
@interface ZegoCDNConfig : NSObject

/// CDN URL
@property (nonatomic, copy) NSString *url;

/// Auth param of URL
@property (nonatomic, copy) NSString *authParam;

@end


/// Relay to CDN info.
///
/// Including the URL of the relaying CDN, relaying state, etc.
@interface ZegoStreamRelayCDNInfo : NSObject

/// URL of publishing stream to CDN
@property (nonatomic, copy) NSString *url;

/// State of relaying to CDN
@property (nonatomic, assign) ZegoStreamRelayCDNState state;

/// Reason for relay state changed
@property (nonatomic, assign) ZegoStreamRelayCDNUpdateReason updateReason;

/// The timestamp when the state changed, UNIX timestamp, in milliseconds.
@property (nonatomic, assign) unsigned long long stateTime;

@end


/// Advanced player configuration.
///
/// Configure playing stream CDN configuration, video layer
@interface ZegoPlayerConfig : NSObject

/// Stream resource mode
@property (nonatomic, assign) ZegoStreamResourceMode resourceMode;

/// The CDN configuration for playing stream. If set, the stream is play according to the URL instead of the streamID. After that, the streamID is only used as the ID of SDK internal callback.
@property (nonatomic, strong, nullable) ZegoCDNConfig *cdnConfig;

/// @deprecated This property has been deprecated since version 1.19.0, please use the [setPlayStreamVideoLayer] function instead.
/// @discussion This function only works when the remote publisher set the video codecID as SVC
@property (nonatomic, assign) ZegoPlayerVideoLayer videoLayer DEPRECATED_ATTRIBUTE;

@end


/// Played stream quality information.
///
/// Audio and video parameters and network quality, etc.
@interface ZegoPlayStreamQuality : NSObject

/// Video receiving frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double videoRecvFPS;

/// Video dejitter frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double videoDejitterFPS;

/// Video decoding frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double videoDecodeFPS;

/// Video rendering frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double videoRenderFPS;

/// Video bit rate in kbps
@property (nonatomic, assign) double videoKBPS;

/// Video break rate, the unit is (number of breaks / every 10 seconds)
@property (nonatomic, assign) double videoBreakRate;

/// Audio receiving frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double audioRecvFPS;

/// Audio dejitter frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double audioDejitterFPS;

/// Audio decoding frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double audioDecodeFPS;

/// Audio rendering frame rate. The unit of frame rate is f/s
@property (nonatomic, assign) double audioRenderFPS;

/// Audio bit rate in kbps
@property (nonatomic, assign) double audioKBPS;

/// Audio break rate, the unit is (number of breaks / every 10 seconds)
@property (nonatomic, assign) double audioBreakRate;

/// Server to local delay, in milliseconds
@property (nonatomic, assign) int rtt;

/// Packet loss rate, in percentage, 0.0 ~ 1.0
@property (nonatomic, assign) double packetLostRate;

/// Delay from peer to peer, in milliseconds
@property (nonatomic, assign) int peerToPeerDelay;

/// Packet loss rate from peer to peer, in percentage, 0.0 ~ 1.0
@property (nonatomic, assign) double peerToPeerPacketLostRate;

/// Published stream quality level
@property (nonatomic, assign) ZegoStreamQualityLevel level;

/// Delay after the data is received by the local end, in milliseconds
@property (nonatomic, assign) int delay;

/// The difference between the video timestamp and the audio timestamp, used to reflect the synchronization of audio and video, in milliseconds. This value is less than 0 means the number of milliseconds that the video leads the audio, greater than 0 means the number of milliseconds that the video lags the audio, and 0 means no difference. When the absolute value is less than 200, it can basically be regarded as synchronized audio and video, when the absolute value is greater than 200 for 10 consecutive seconds, it can be regarded as abnormal
@property (nonatomic, assign) int avTimestampDiff;

/// Whether to enable hardware decoding
@property (nonatomic, assign) BOOL isHardwareDecode;

/// Video codec ID
@property (nonatomic, assign) ZegoVideoCodecID videoCodecID;

/// Total number of bytes received, including audio, video, SEI
@property (nonatomic, assign) double totalRecvBytes;

/// Number of audio bytes received
@property (nonatomic, assign) double audioRecvBytes;

/// Number of video bytes received
@property (nonatomic, assign) double videoRecvBytes;

@end


/// Device Info.
///
/// Including device ID and name
@interface ZegoDeviceInfo : NSObject

/// Device ID
@property (nonatomic, copy) NSString *deviceID;

/// Device name
@property (nonatomic, copy) NSString *deviceName;

@end


/// System performance monitoring status
@interface ZegoPerformanceStatus : NSObject

/// Current CPU usage of the app, value range [0, 1]
@property (nonatomic, assign) double cpuUsageApp;

/// Current CPU usage of the system, value range [0, 1]
@property (nonatomic, assign) double cpuUsageSystem;

/// Current memory usage of the app, value range [0, 1]
@property (nonatomic, assign) double memoryUsageApp;

/// Current memory usage of the system, value range [0, 1]
@property (nonatomic, assign) double memoryUsageSystem;

/// Current memory used of the app, in MB
@property (nonatomic, assign) double memoryUsedApp;

@end


/// Beauty configuration options.
///
/// Configure the parameters of skin peeling, whitening and sharpening
@interface ZegoBeautifyOption : NSObject

/// The sample step size of beauty peeling, the value range is [0,1], default 0.2
@property (nonatomic, assign) double polishStep;

/// Brightness parameter for beauty and whitening, the larger the value, the brighter the brightness, ranging from [0,1], default 0.5
@property (nonatomic, assign) double whitenFactor;

/// Beauty sharpening parameter, the larger the value, the stronger the sharpening, value range [0,1], default 0.1
@property (nonatomic, assign) double sharpenFactor;

/// Create a default beauty parameter object
///
/// @return ZegoBeautifyOption instance
+ (instancetype)defaultConfig;

@end


/// Mix stream audio configuration.
///
/// Configure video frame rate, bitrate, and resolution for mixer task
@interface ZegoMixerAudioConfig : NSObject

/// Audio bitrate in kbps, default is 48 kbps, cannot be modified after starting a mixer task
@property (nonatomic, assign) int bitrate;

/// Audio channel, default is Mono
@property (nonatomic, assign) ZegoAudioChannel channel;

/// codec ID, default is ZegoAudioCodecIDDefault
@property (nonatomic, assign) ZegoAudioCodecID codecID;

/// Multi-channel audio stream mixing mode. If [ZegoAudioMixMode] is selected as [Focused], the SDK will select 4 input streams with [isAudioFocus] set as the focus voice highlight. If it is not selected or less than 4 channels are selected, it will automatically fill in 4 channels
@property (nonatomic, assign) ZegoAudioMixMode mixMode;

/// Create a default mix stream audio configuration
///
/// @return ZegoMixerAudioConfig instance
+ (instancetype)defaultConfig;

@end


/// Mix stream video config object.
///
/// Configure video frame rate, bitrate, and resolution for mixer task
@interface ZegoMixerVideoConfig : NSObject

/// Video FPS, cannot be modified after starting a mixer task
@property (nonatomic, assign) int fps;

/// Video bitrate in kbps
@property (nonatomic, assign) int bitrate;

/// video resolution
@property (nonatomic, assign) CGSize resolution;

/// Create a mixer video configuration
///
/// @return ZegoMixerVideoConfig instance
+ (instancetype)configWithResolution:(CGSize)resolution fps:(int)fps bitrate:(int)bitrate;

/// Create a mixer video configuration
///
/// @return ZegoMixerVideoConfig instance
- (instancetype)initWithResolution:(CGSize)resolution fps:(int)fps bitrate:(int)bitrate;

@end


/// Mixer input.
///
/// Configure the mix stream input stream ID, type, and the layout
@interface ZegoMixerInput : NSObject

/// Stream ID, a string of up to 256 characters. You cannot include URL keywords, otherwise publishing stream and playing stream will fails. Only support numbers, English characters and '~', '!', '@', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
@property (nonatomic, copy) NSString *streamID;

/// Mix stream content type
@property (nonatomic, assign) ZegoMixerInputContentType contentType;

/// Stream layout. When the mixed stream is an audio stream (that is, the ContentType parameter is set to the audio mixed stream type), the layout field is not processed inside the SDK, and there is no need to pay attention to this parameter.
@property (nonatomic, assign) CGRect layout;

/// If enable soundLevel in mix stream task, an unique soundLevelID is need for every stream
@property (nonatomic, assign) unsigned int soundLevelID;

/// Whether the focus voice is enabled in the current input stream, the sound of this stream will be highlighted if enabled
@property (nonatomic, assign) BOOL isAudioFocus;

/// Create a mixed input object
///
/// @return ZegoMixerInput instance
- (instancetype)initWithStreamID:(NSString *)streamID contentType:(ZegoMixerInputContentType)contentType layout:(CGRect)layout;

/// Create a mixed input object
///
/// @return ZegoMixerInput instance
- (instancetype)initWithStreamID:(NSString *)streamID contentType:(ZegoMixerInputContentType)contentType layout:(CGRect)layout soundLevelID:(unsigned int)soundLevelID;

@end


/// Mixer output object.
///
/// Configure mix stream output target URL or stream ID
@interface ZegoMixerOutput : NSObject

/// Mix stream output target, URL or stream ID, if set to be URL format, only RTMP URL surpported, for example rtmp://xxxxxxxx
@property (nonatomic, copy) NSString *target;

/// Create a mix stream output object
///
/// @return ZegoMixerOutput instance
- (instancetype)initWithTarget:(NSString *)target;

@end


/// Watermark object.
///
/// Configure a watermark image URL and the layout of the watermark in the screen.
@interface ZegoWatermark : NSObject

/// The path of the watermark image. Support local file absolute path (file://xxx), Asset resource path (asset://xxx). The format supports png, jpg.
@property (nonatomic, copy) NSString *imageURL;

/// Watermark image layout
@property (nonatomic, assign) CGRect layout;

/// Create a watermark object
///
/// @return ZegoWatermark instance
- (instancetype)initWithImageURL:(NSString *)imageURL layout:(CGRect)layout;

@end


/// Mix stream task object.
///
/// This class is the configuration class of the stream mixing task. When a stream mixing task is requested to the ZEGO RTC server, the configuration of the stream mixing task is required.
/// This class describes the detailed configuration information of this stream mixing task.
@interface ZegoMixerTask : NSObject

/// Mix stream task ID, a string of up to 256 characters. You cannot include URL keywords, otherwise publishing stream and playing stream will fails. Only support numbers, English characters and '~', '!', '@', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'.
@property (nonatomic, copy, readonly) NSString *taskID;

/// This function is unavaialble
///
/// Please use [initWithTaskID:] instead
+ (instancetype)new NS_UNAVAILABLE;

/// This function is unavaialble
///
/// Please use [initWithTaskID:] instead
- (instancetype)init NS_UNAVAILABLE;

/// Create a mix stream task object with TaskID
///
/// @return ZegoMixerTask instance
- (instancetype)initWithTaskID:(NSString *)taskID;

/// Set the audio configuration of the mix stream task object
- (void)setAudioConfig:(ZegoMixerAudioConfig *)audioConfig;

/// Set the video configuration of the mix stream task object
- (void)setVideoConfig:(ZegoMixerVideoConfig *)videoConfig;

/// Set the input stream list for the mix stream task object
- (void)setInputList:(NSArray<ZegoMixerInput *> *)inputList;

/// Set the output list of the mix stream task object
- (void)setOutputList:(NSArray<ZegoMixerOutput *> *)outputList;

/// Set the watermark of the mix stream task object
- (void)setWatermark:(ZegoWatermark *)watermark;

/// Set the background image of the mix stream task object
- (void)setBackgroundImageURL:(NSString *)backgroundImageURL;

/// Enable or disable sound level callback for the task. If enabled, then the remote player can get the soundLevel of every stream in the inputlist by [onMixerSoundLevelUpdate] callback.
- (void)enableSoundLevel:(BOOL)enable;

/// Set advanced configuration, such as specifying video encoding and others. If you need to use it, contact ZEGO technical support.
- (void)setAdvancedConfig:(NSDictionary<NSString *, NSString *> *)config;

@end


/// Broadcast message info.
///
/// The received object of the room broadcast message, including the message content, message ID, sender, sending time
@interface ZegoBroadcastMessageInfo : NSObject

/// message content
@property (nonatomic, copy) NSString *message;

/// message id
@property (nonatomic, assign) unsigned long long messageID;

/// Message send time, UNIX timestamp, in milliseconds.
@property (nonatomic, assign) unsigned long long sendTime;

/// Message sender.Please do not fill in sensitive user information in this field, including but not limited to mobile phone number, ID number, passport number, real name, etc.
@property (nonatomic, strong) ZegoUser *fromUser;

@end


/// Barrage message info.
///
/// The received object of the room barrage message, including the message content, message ID, sender, sending time
@interface ZegoBarrageMessageInfo : NSObject

/// message content
@property (nonatomic, copy) NSString *message;

/// message id
@property (nonatomic, copy) NSString *messageID;

/// Message send time, UNIX timestamp, in milliseconds.
@property (nonatomic, assign) unsigned long long sendTime;

/// Message sender.Please do not fill in sensitive user information in this field, including but not limited to mobile phone number, ID number, passport number, real name, etc.
@property (nonatomic, strong) ZegoUser *fromUser;

@end


/// Object for video frame fieldeter.
///
/// Including video frame format, width and height, etc.
@interface ZegoVideoFrameParam : NSObject

/// Video frame format
@property (nonatomic, assign) ZegoVideoFrameFormat format;

/// Number of bytes per line (for example: BGRA only needs to consider strides [0], I420 needs to consider strides [0,1,2])
@property (nonatomic, assign) int *strides;

/// Video frame size
@property (nonatomic, assign) CGSize size;

@end


/// Object for video encoded frame fieldeter.
///
/// Including video encoded frame format, width and height, etc.
@interface ZegoVideoEncodedFrameParam : NSObject

/// Video encoded frame format
@property (nonatomic, assign) ZegoVideoEncodedFrameFormat format;

/// Whether it is a keyframe
@property (nonatomic, assign) BOOL isKeyFrame;

/// Video frame rotation
@property (nonatomic, assign) int rotation;

/// Video frame size
@property (nonatomic, assign) CGSize size;

/// SEI data
@property (nonatomic, strong) NSData *SEIData;

@end


/// Parameter object for audio frame.
///
/// Including the sampling rate and channel of the audio frame
@interface ZegoAudioFrameParam : NSObject

/// Sampling Rate
@property (nonatomic, assign) ZegoAudioSampleRate sampleRate;

/// Audio channel, default is Mono
@property (nonatomic, assign) ZegoAudioChannel channel;

@end


/// Audio configuration.
///
/// Configure audio bitrate, audio channel, audio encoding for publishing stream
@interface ZegoAudioConfig : NSObject

/// Audio bitrate in kbps, default is 48 kbps. The settings before and after publishing stream can be effective
@property (nonatomic, assign) int bitrate;

/// Audio channel, default is Mono. The setting only take effect before publishing stream
@property (nonatomic, assign) ZegoAudioChannel channel;

/// codec ID, default is ZegoAudioCodecIDDefault. The setting only take effect before publishing stream
@property (nonatomic, assign) ZegoAudioCodecID codecID;

/// Create a default audio configuration
///
/// ZegoAudioConfigPresetStandardQuality (48 kbps, Mono, ZegoAudioCodecIDDefault)
///
/// @return ZegoAudioConfig instance
+ (instancetype)defaultConfig;

/// Create a audio configuration with preset enumeration values
///
/// @return ZegoAudioConfig instance
+ (instancetype)configWithPreset:(ZegoAudioConfigPreset)preset;

/// Create a audio configuration with preset enumeration values
///
/// @return ZegoAudioConfig instance
- (instancetype)initWithPreset:(ZegoAudioConfigPreset)preset;

@end


/// audio mixing data.
@interface ZegoAudioMixingData : NSObject

/// Audio PCM data that needs to be mixed into the stream
@property (nonatomic, strong, nullable) NSData *audioData;

/// Audio data attributes, including sample rate and number of channels. Currently supports 16k 32k 44.1k 48k sampling rate, mono or stereo channel, 16-bit deep PCM data. Developers need to explicitly specify audio data attributes, otherwise mixing will not take effect.
@property (nonatomic, strong) ZegoAudioFrameParam *param;

/// SEI data, used to transfer custom data. When audioData is null, SEIData will not be sent
@property (nonatomic, strong, nullable) NSData *SEIData;

@end


/// Customize the audio processing configuration object.
///
/// Including custom audio acquisition type, sampling rate, channel number, sampling number and other parameters
@interface ZegoCustomAudioProcessConfig : NSObject

/// Sampling rate, the sampling rate of the input data expected by the audio pre-processing module in App. If 0, the default is the SDK internal sampling rate.
@property (nonatomic, assign) ZegoAudioSampleRate sampleRate;

/// Number of sound channels, the expected number of sound channels for input data of the audio pre-processing module in App. If 0, the default is the number of internal channels in the SDK
@property (nonatomic, assign) ZegoAudioChannel channel;

/// The number of samples required to encode a frame; When encode = false, if samples = 0, the SDK will use the internal sample number, and the SDK will pass the audio data to the external pre-processing module. If the samples! = 0 (the effective value of samples is between [160, 2048]), and the SDK will send audio data to the external preprocessing module that sets the length of sample number. Encode = true, the number of samples for a frame of AAC encoding can be set as (480/512/1024/1960/2048)
@property (nonatomic, assign) int samples;

@end


/// Record config.
@interface ZegoDataRecordConfig : NSObject

/// The path to save the recording file, absolute path, need to include the file name, the file name need to specify the suffix, currently supports .mp4/.flv/.aac format files, if multiple recording for the same path, will overwrite the file with the same name. The maximum length should be less than 1024 bytes.
@property (nonatomic, copy) NSString *filePath;

/// Type of recording media
@property (nonatomic, assign) ZegoDataRecordType recordType;

@end


/// File recording progress.
@interface ZegoDataRecordProgress : NSObject

/// Current recording duration in milliseconds
@property (nonatomic, assign) unsigned long long duration;

/// Current recording file size in byte
@property (nonatomic, assign) unsigned long long currentFileSize;

@end


/// Network probe config
@interface ZegoNetworkProbeConfig : NSObject

/// Whether do traceroute, enabling tranceRoute will significantly increase network detection time
@property (nonatomic, assign) BOOL enableTraceroute;

@end


/// http probe result
@interface ZegoNetworkProbeHttpResult : NSObject

/// http probe errorCode, 0 means the connection is normal
@property (nonatomic, assign) int errorCode;

/// http request cost time, the unit is millisecond
@property (nonatomic, assign) unsigned int requestCostTime;

@end


/// tcp probe result
@interface ZegoNetworkProbeTcpResult : NSObject

/// tcp probe errorCode, 0 means the connection is normal
@property (nonatomic, assign) int errorCode;

/// tcp rtt, the unit is millisecond
@property (nonatomic, assign) unsigned int rtt;

/// tcp connection cost time, the unit is millisecond
@property (nonatomic, assign) unsigned int connectCostTime;

@end


/// udp probe result
@interface ZegoNetworkProbeUdpResult : NSObject

/// udp probe errorCode, 0 means the connection is normal
@property (nonatomic, assign) int errorCode;

/// The total time that the SDK send udp data to server and receive a reply, the unit is millisecond
@property (nonatomic, assign) unsigned int rtt;

@end


/// traceroute result
///
/// Jump up to 30 times. The traceroute result is for reference and does not represent the final network connection result. The priority is http, tcp, udp probe result.
@interface ZegoNetworkProbeTracerouteResult : NSObject

/// traceroute error code, 0 means normal
@property (nonatomic, assign) int errorCode;

/// Time consumed by trace route, the unit is millisecond
@property (nonatomic, assign) unsigned int tracerouteCostTime;

@end


/// Network probe result
@interface ZegoNetworkProbeResult : NSObject

/// http probe result
@property (nonatomic, strong, nullable) ZegoNetworkProbeHttpResult *httpProbeResult;

/// tcp probe result
@property (nonatomic, strong, nullable) ZegoNetworkProbeTcpResult *tcpProbeResult;

/// udp probe result
@property (nonatomic, strong, nullable) ZegoNetworkProbeUdpResult *udpProbeResult;

/// traceroute result
@property (nonatomic, strong, nullable) ZegoNetworkProbeTracerouteResult *tracerouteResult;

@end


/// Network speed test config
@interface ZegoNetworkSpeedTestConfig : NSObject

/// Test uplink or not
@property (nonatomic, assign) BOOL testUplink;

/// The unit is kbps. Recommended to use the bitrate in ZegoVideoConfig when call startPublishingStream to determine whether the network uplink environment is suitable.
@property (nonatomic, assign) int expectedUplinkBitrate;

/// Test downlink or not
@property (nonatomic, assign) BOOL testDownlink;

/// The unit is kbps. Recommended to use the bitrate in ZegoVideoConfig when call startPublishingStream to determine whether the network downlink environment is suitable.
@property (nonatomic, assign) int expectedDownlinkBitrate;

@end


/// test connectivity result
@interface ZegoTestNetworkConnectivityResult : NSObject

/// connect cost
@property (nonatomic, assign) unsigned int connectCost;

@end


/// network speed test quality
@interface ZegoNetworkSpeedTestQuality : NSObject

/// Time to connect to the server, in milliseconds. During the speed test, if the network connection is disconnected, it will automatically initiate a reconnection, and this variable will be updated accordingly.
@property (nonatomic, assign) unsigned int connectCost;

/// rtt, in milliseconds
@property (nonatomic, assign) unsigned int rtt;

/// packet lost rate. in percentage, 0.0 ~ 1.0
@property (nonatomic, assign) double packetLostRate;

@end


/// AudioEffectPlayer play configuration.
@interface ZegoAudioEffectPlayConfig : NSObject

/// The number of play counts. When set to 0, it will play in an infinite loop until the user invoke [stop]. The default is 1, which means it will play only once.
@property (nonatomic, assign) unsigned int playCount;

/// Whether to mix audio effects into the publishing stream, the default is false.
@property (nonatomic, assign) BOOL isPublishOut;

@end


/// Zego MediaPlayer.
///
/// Yon can use ZegoMediaPlayer to play media resource files on the local or remote server, and can mix the sound of the media resource files that are played into the publish stream to achieve the effect of background music.
@interface ZegoMediaPlayer : NSObject

/// Total duration of media resources
/// @discussion You should load resource before getting this variable, otherwise the value is 0
/// @discussion The unit is millisecond
@property (nonatomic, assign, readonly) unsigned long long totalDuration;

/// Current playback progress of the media resource
/// @discussion You should load resource before getting this variable, otherwise the value is 0
/// @discussion The unit is millisecond
@property (nonatomic, assign, readonly) unsigned long long currentProgress;

/// The current local playback volume of the mediaplayer, the range is 0 ~ 200, with the default value of 60
@property (nonatomic, assign, readonly) int playVolume;

/// The current publish volume of the mediaplayer, the range is 0 ~ 200, with the default value of 60
@property (nonatomic, assign, readonly) int publishVolume;

/// Player's current playback status
@property (nonatomic, assign, readonly) ZegoMediaPlayerState currentState;

/// Number of the audio tracks of the media resource
@property (nonatomic, assign, readonly) unsigned int audioTrackCount;

/// Media player index
@property (nonatomic, strong, readonly) NSNumber *index;

/// Set event callback handler for media player.
///
/// Developers can change the player UI widget according to the related event callback of the media player
///
/// @param handler Media player event callback object
- (void)setEventHandler:(nullable id<ZegoMediaPlayerEventHandler>)handler;

/// Set video callback handler.
///
/// Developers can set this callback to throw the video data of the media resource file played by the media player
///
/// @param handler Video event callback object for media player
/// @param format Video frame format for video data
/// @param type Buffer type for video data
- (void)setVideoHandler:(nullable id<ZegoMediaPlayerVideoHandler>)handler format:(ZegoVideoFrameFormat)format type:(ZegoVideoBufferType)type;

/// Set audio callback handler.
///
/// You can set this callback to throw the audio data of the media resource file played by the media player
///
/// @param handler Audio event callback object for media player
- (void)setAudioHandler:(nullable id<ZegoMediaPlayerAudioHandler>)handler;

/// Load media resource.
///
/// Yon can pass the absolute path of the local resource or the URL of the network resource
///
/// @param path the absolute path of the local resource or the URL of the network resource
/// @param callback Notification of resource loading results
- (void)loadResource:(NSString *)path callback:(nullable ZegoMediaPlayerLoadResourceCallback)callback;

/// Start playing.
///
/// You need to load resources before playing
- (void)start;

/// Stop playing.
- (void)stop;

/// Pause playing.
- (void)pause;

/// resume playing.
- (void)resume;

/// Set the specified playback progress.
///
/// Unit is millisecond
///
/// @param millisecond Point in time of specified playback progress
/// @param callback the result notification of set the specified playback progress
- (void)seekTo:(unsigned long long)millisecond callback:(nullable ZegoMediaPlayerSeekToCallback)callback;

/// Whether to repeat playback.
///
/// @param enable repeat playback flag. The default is NO.
- (void)enableRepeat:(BOOL)enable;

/// Whether to mix the player's sound into the stream being published.
///
/// @param enable Aux audio flag. The default is NO.
- (void)enableAux:(BOOL)enable;

/// Whether to play locally silently.
///
/// If [enableAux] switch is turned on, there is still sound in the publishing stream. The default is NO.
///
/// @param mute Mute local audio flag, The default is NO.
- (void)muteLocal:(BOOL)mute;

/// Set the view of the player playing video.
///
/// @param canvas Video rendered canvas object
- (void)setPlayerCanvas:(nullable ZegoCanvas *)canvas;

/// Set mediaplayer volume. Both the local play volume and the publish volume are set.
///
/// @param volume The range is 0 ~ 200. The default is 60.
- (void)setVolume:(int)volume;

/// Set mediaplayer local play volume.
///
/// @param volume The range is 0 ~ 200. The default is 60.
- (void)setPlayVolume:(int)volume;

/// Set mediaplayer publish volume.
///
/// @param volume The range is 0 ~ 200. The default is 60.
- (void)setPublishVolume:(int)volume;

/// Set playback progress callback interval.
///
/// This function can control the callback frequency of [mediaPlayer:playingProgress:]. When the callback interval is set to 0, the callback is stopped. The default callback interval is 1s
/// This callback are not returned exactly at the set callback interval, but rather at the frequency at which the audio or video frames are processed to determine whether the callback is needed to call
///
/// @param millisecond Interval of playback progress callback in milliseconds
- (void)setProgressInterval:(unsigned long long)millisecond;

/// Set the audio track of the playback file.
///
/// @param index Audio track index, the number of audio tracks can be obtained through the [audioTrackCount].
- (void)setAudioTrackIndex:(unsigned int)index;

/// Setting up the specific voice changer parameters.
///
/// @param param Voice changer parameters
/// @param audioChannel The audio channel to be voice changed
- (void)setVoiceChangerParam:(ZegoVoiceChangerParam *)param audioChannel:(ZegoMediaPlayerAudioChannel)audioChannel;

/// Take a screenshot of the current playing screen of the media player.
///
/// Only in the case of calling `setPlayerCanvas` to set the display controls and the playback state, can the screenshot be taken normally
///
/// @param callback The callback of the screenshot of the media player playing screen
- (void)takeSnapshot:(ZegoMediaPlayerTakeSnapshotCallback)callback;

/// Open precise seek and set relevant attributes.
///
/// Call the setting before loading the resource. After setting, it will be valid throughout the life cycle of the media player. For multiple calls to ‘enableAccurateSeek’, the configuration is an overwrite relationship, and each call to ‘enableAccurateSeek’ only takes effect on the resources loaded later.
///
/// @param enable Whether to enable accurate seek
/// @param config The property setting of precise seek is valid only when enable is YES.
- (void)enableAccurateSeek:(BOOL)enable config:(ZegoAccurateSeekConfig *)config;

/// Set the maximum cache duration and cache data size of web materials.
///
/// The setting must be called before loading the resource, and it will take effect during the entire life cycle of the media player.
/// Time and size are not allowed to be 0 at the same time. The SDK internal default time is 5000, and the size is 15*1024*1024 byte.When one of time and size reaches the set value first, the cache will stop.
///
/// @param time The maximum length of the cache time, in ms, the SDK internal default is 5000; the effective value is greater than or equal to 2000; if you fill in 0, it means no limit.
/// @param size The maximum size of the cache, the unit is byte, the internal default size of the SDK is 15*1024*1024 byte; the effective value is greater than or equal to 5000000, if you fill in 0, it means no limit.
- (void)setNetWorkResourceMaxCache:(unsigned int)time size:(unsigned int)size;

/// Get the playable duration and size of the cached data of the current network material cache queue
///
/// @return Returns the current cached information, including the length of time the data can be played and the size of the cached data.
- (ZegoNetWorkResourceCache *)getNetWorkResourceCache;

/// Use this interface to set the cache threshold that the media player needs to resume playback. The SDK default value is 5000ms，The valid value is greater than or equal to 1000ms
///
/// @param threshold Threshold that needs to be reached to resume playback, unit ms.
- (void)setNetWorkBufferThreshold:(unsigned int)threshold;

/// This function is unavaialble
///
/// Please use the [createMediaPlayer] function in ZegoExpressEngine class instead.
+ (instancetype)new NS_UNAVAILABLE;

/// This function is unavaialble
///
/// Please use the [createMediaPlayer] function in ZegoExpressEngine class instead.
- (instancetype)init NS_UNAVAILABLE;

@end


/// Precise seek configuration
@interface ZegoAccurateSeekConfig : NSObject

/// The timeout time for precise search; if not set, the SDK internal default is set to 5000 milliseconds, the effective value range is [2000, 10000], the unit is ms
@property (nonatomic, assign) unsigned long long timeout;

@end


/// Media player network cache information
@interface ZegoNetWorkResourceCache : NSObject

/// Cached duration, unit ms
@property (nonatomic, assign) unsigned int time;

/// Cached size, unit byte
@property (nonatomic, assign) unsigned int size;

@end

@interface ZegoAudioEffectPlayer : NSObject

/// set audio effect player event handler.
///
/// @param handler event handler for audio effect player
- (void)setEventHandler:(nullable id<ZegoAudioEffectPlayerEventHandler>)handler;

/// Start playing audio effect.
///
/// The default is only played once and is not mixed into the publishing stream, if you want to change this please modify [config].
///
/// @param audioEffectID ID for the audio effect. The SDK uses audioEffectID to control the playback of sound effects. The SDK does not force the user to pass in this parameter as a fixed value. It is best to ensure that each sound effect can have a unique id. The recommended methods are static self-incrementing id or the hash of the incoming sound effect file path.
/// @param path The absolute path of the local resource. "assets://"、"ipod-library://" and network url are not supported. Set path as nil or "" if resource is loaded already using [loadResource]
/// @param config Audio effect playback configuration. Set nil will only be played once, and will not be mixed into the publishing stream.
- (void)start:(unsigned int)audioEffectID path:(nullable NSString *)path config:(nullable ZegoAudioEffectPlayConfig *)config;

/// Stop playing audio effect.
///
/// @param audioEffectID ID for the audio effect
- (void)stop:(unsigned int)audioEffectID;

/// Pause playing audio effect.
///
/// @param audioEffectID ID for the audio effect
- (void)pause:(unsigned int)audioEffectID;

/// Resume playing audio effect.
///
/// @param audioEffectID ID for the audio effect
- (void)resume:(unsigned int)audioEffectID;

/// Stop playing all audio effect.
- (void)stopAll;

/// Pause playing all audio effect.
- (void)pauseAll;

/// Resume playing all audio effect.
- (void)resumeAll;

/// Set the specified playback progress.
///
/// Unit is millisecond
///
/// @param millisecond Point in time of specified playback progress
/// @param audioEffectID ID for the audio effect
/// @param callback seek to result
- (void)seekTo:(unsigned long long)millisecond audioEffectID:(unsigned int)audioEffectID callback:(nullable ZegoAudioEffectPlayerSeekToCallback)callback;

/// Set volume for the audio effect. Both the local play volume and the publish volume are set.
///
/// @param volume The range is 0 ~ 200. The default is 100.
/// @param audioEffectID ID for the audio effect
- (void)setVolume:(int)volume audioEffectID:(unsigned int)audioEffectID;

/// Set volume for all audio effect. Both the local play volume and the publish volume are set.
///
/// @param volume The range is 0 ~ 200. The default is 100.
- (void)setVolumeAll:(int)volume;

/// Get the total progress of your media resources.
///
/// You should load resource before invoking this function, otherwise the return value is 0
///
/// @param audioEffectID ID for the audio effect
/// @return Unit is millisecond
- (unsigned long long)getTotalDuration:(unsigned int)audioEffectID;

/// Get current playing progress.
///
/// You should load resource before invoking this function, otherwise the return value is 0
///
/// @param audioEffectID ID for the audio effect
- (unsigned long long)getCurrentProgress:(unsigned int)audioEffectID;

/// Load audio effect resource.
///
/// In a scene where the same sound effect is played frequently, the SDK provides the function of preloading the sound effect file into the memory in order to optimize the performance of repeatedly reading and decoding the file. Preloading supports loading up to 15 sound effect files at the same time, and the duration of the sound effect files cannot exceed 30s, otherwise an error will be reported when loading
///
/// @param path the absolute path of the audio effect resource.
/// @param audioEffectID ID for the audio effect
/// @param callback load audio effect resource result
- (void)loadResource:(NSString *)path audioEffectID:(unsigned int)audioEffectID callback:(nullable ZegoAudioEffectPlayerLoadResourceCallback)callback;

/// Unload audio effect resource.
///
/// After the sound effects are used up, related resources can be released through this function; otherwise, the SDK will release the loaded resources when the AudioEffectPlayer instance is destroyed.
///
/// @param audioEffectID ID for the audio effect loaded
- (void)unloadResource:(unsigned int)audioEffectID;

/// Get audio effect player index.
///
/// @return Audio effect player index
- (NSNumber *)getIndex;

/// This function is unavaialble.
///
/// Please use the [createAudioEffectPlayer] function in ZegoExpressEngine class instead.
+ (instancetype)new NS_UNAVAILABLE;

/// This function is unavaialble
///
/// Please use the [createAudioEffectPlayer] function in ZegoExpressEngine class instead.
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
