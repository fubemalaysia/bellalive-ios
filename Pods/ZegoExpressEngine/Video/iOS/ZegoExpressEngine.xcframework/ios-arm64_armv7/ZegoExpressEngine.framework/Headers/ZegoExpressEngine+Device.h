//
//  ZegoExpressEngine+Device.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (Device)

/// Mutes or unmutes the microphone.
///
/// This function is used to control whether the collected audio data is used. When the microphone is muted (disabled), the data is collected and discarded, and the microphone is still occupied.
/// The microphone is still occupied because closing or opening the microphone on the hardware is a relatively heavy operation, and real users may have frequent operations. For trade-off reasons, this function simply discards the collected data.
/// If you really want SDK to give up occupy the microphone, you can call the [enableAudioCaptureDevice] function.
/// Developers who want to control whether to use microphone on the UI should use this function to avoid unnecessary performance overhead by using the [enableAudioCaptureDevice].
///
/// @param mute Whether to mute (disable) the microphone, YES: mute (disable) microphone, NO: enable microphone. The default is NO.
- (void)muteMicrophone:(BOOL)mute;

/// Checks whether the microphone is muted.
///
/// Can be used with [muteMicrophone], determine whether the microphone is muted.
///
/// @return Whether the microphone is muted; YES: the microphone is muted; NO: the microphone is enable (not muted)
- (BOOL)isMicrophoneMuted;

/// Mutes or unmutes the audio output speaker.
///
/// After mute speaker, all the SDK sounds will not play, including playing stream, mediaplayer, etc. But the SDK will still occupy the output device.
///
/// @param mute Whether to mute (disable) speaker audio output, YES: mute (disable) speaker audio output, NO: enable speaker audio output. The default value is NO
- (void)muteSpeaker:(BOOL)mute;

/// Checks whether the audio output speaker is muted.
///
/// Can be used with [muteSpeaker], determine whether the speaker audio output is muted.
///
/// @return Whether the speaker is muted; YES: the speaker is muted; NO: the speaker is enable (not muted)
- (BOOL)isSpeakerMuted;

#if TARGET_OS_OSX
/// Gets a list of audio devices.
///
/// Get a list of audio devices. Only for macOS
///
/// @param deviceType Audio device type
/// @return Audo device List
- (NSArray<ZegoDeviceInfo *> *)getAudioDeviceList:(ZegoAudioDeviceType)deviceType;
#endif

#if TARGET_OS_OSX
/// Get the device ID of the default audio device.
///
/// Get the device ID of the default audio device. Only for macOS.
///
/// @param deviceType Audio device type
/// @return Default Audio device ID
- (NSString *)getDefaultAudioDeviceID:(ZegoAudioDeviceType)deviceType;
#endif

#if TARGET_OS_OSX
/// Chooses to use the specified audio device.
///
/// Chooses to use the specified audio device. Only for macOS.
///
/// @param deviceID ID of a device obtained by [getAudioDeviceList]
/// @param deviceType Audio device type
- (void)useAudioDevice:(NSString *)deviceID deviceType:(ZegoAudioDeviceType)deviceType;
#endif

#if TARGET_OS_OSX
/// Get volume for the specified audio device.
///
/// Get volume for the specified audio device. Only for macOS.
///
/// @param deviceID ID of a device obtained by [getAudioDeviceList]
/// @param deviceType Audio device type
/// @return Device volume
- (int)getAudioDeviceVolume:(NSString *)deviceID deviceType:(ZegoAudioDeviceType)deviceType;
#endif

#if TARGET_OS_OSX
/// Set volume for the specified audio device.
///
/// Only for macOS. The direct operating system device may fail due to system restrictions. Please use [setCaptureVolume] and [setPlayVolume] first to adjust the volume of publish and play streams.
///
/// @param deviceID ID of a device obtained by [getAudioDeviceList]
/// @param deviceType Audio device type
/// @param volume Device volume
- (void)setAudioDeviceVolume:(NSString *)deviceID deviceType:(ZegoAudioDeviceType)deviceType volume:(int)volume;
#endif

#if TARGET_OS_OSX
/// Turn on audio device volume monitoring.
///
/// Only for macOS.
///
/// @param deviceID ID of a device obtained by [getAudioDeviceList]
/// @param deviceType Audio device type
- (void)startAudioDeviceVolumeMonitor:(NSString *)deviceID deviceType:(ZegoAudioDeviceType)deviceType;
#endif

#if TARGET_OS_OSX
/// Turn on audio device volume monitoring.
///
/// Only for macOS.
///
/// @param deviceID ID of a device obtained by [getAudioDeviceList]
/// @param deviceType Audio device type
- (void)stopAudioDeviceVolumeMonitor:(NSString *)deviceID deviceType:(ZegoAudioDeviceType)deviceType;
#endif

#if TARGET_OS_OSX
/// Mutes or unmutes the audio device.
///
/// Only for macOS.
///
/// @param deviceID ID of a device obtained by [getAudioDeviceList]
/// @param deviceType Audio device type
/// @param mute Whether to mute the audio device; YES means to mute the audio device; NO means to unmute the audio device.
- (void)muteAudioDevice:(NSString *)deviceID deviceType:(ZegoAudioDeviceType)deviceType mute:(BOOL)mute;
#endif

#if TARGET_OS_OSX
/// Check if the audio device is muted.
///
/// Check if the audio device is muted. Only for macOS.
///
/// @param deviceID ID of a device obtained by [getAudioDeviceList]
/// @param deviceType Audio device type
/// @return Whether the audio device is muted; YES means the audio device is muted; NO means the audio device is not muted.
- (BOOL)isAudioDeviceMuted:(NSString *)deviceID deviceType:(ZegoAudioDeviceType)deviceType;
#endif

/// Enables or disables the audio capture device.
///
/// This function is used to control whether to release the audio collection device. When the audio collection device is turned off, the SDK will no longer occupy the audio device. Of course, if the stream is being published at this time, there is no audio data.
/// Occupying the audio capture device and giving up Occupying the audio device is a relatively heavy operation, and the [muteMicrophone] function is generally recommended.
///
/// @param enable Whether to enable the audio capture device, YES: disable audio capture device, NO: enable audio capture device
- (void)enableAudioCaptureDevice:(BOOL)enable;

#if TARGET_OS_IPHONE
/// get current audio route type
- (ZegoAudioRoute)getAudioRouteType;
#endif

#if TARGET_OS_IPHONE
/// Whether to use the built-in speaker to play audio.
///
/// When you choose not to use the built-in speaker to play sound, that is, set to [NO], the SDK will select the currently highest priority audio output device to play the sound according to the system schedule
///
/// @param defaultToSpeaker Whether to use the built-in speaker to play sound, YES: use the built-in speaker to play sound, NO: use the highest priority audio output device scheduled by the current system to play sound
- (void)setAudioRouteToSpeaker:(BOOL)defaultToSpeaker;
#endif

/// Turns on/off the camera.
///
/// This function is used to control whether to start the camera acquisition. After the camera is turned off, video capture will not be performed. At this time, the publish stream will also have no video data.
/// In the case of using the custom video capture function, since the developer has taken over the capture of video data, the SDK is no longer responsible for the capture of video data, but this API will still affect the behavior of whether to encode or not. Therefore, when developers use custom video capture, please ensure that the value of this API is YES
///
/// @param enable Whether to turn on the camera, YES: turn on camera, NO: turn off camera
- (void)enableCamera:(BOOL)enable;

/// Turns on/off the camera (for the specified channel).
///
/// This function is used to control whether to start the camera acquisition. After the camera is turned off, video capture will not be performed. At this time, the publish stream will also have no video data.
/// In the case of using the custom video capture function, since the developer has taken over the capture of video data, the SDK is no longer responsible for the capture of video data, but this API will still affect the behavior of whether to encode or not. Therefore, when developers use custom video capture, please ensure that the value of this API is YES
///
/// @param enable Whether to turn on the camera, YES: turn on camera, NO: turn off camera
/// @param channel Publishing stream channel
- (void)enableCamera:(BOOL)enable channel:(ZegoPublishChannel)channel;

#if TARGET_OS_IPHONE
/// Switches to the front or the rear camera.
///
/// This function is used to control the front or rear camera
/// In the case of using a custom video capture function, because the developer has taken over the video data capturing, the SDK is no longer responsible for the video data capturing, this function is no longer valid.
///
/// @param enable Whether to use the front camera, YES: use the front camera, NO: use the the rear camera. The default value is YES
- (void)useFrontCamera:(BOOL)enable;
#endif

#if TARGET_OS_IPHONE
/// Switches to the front or the rear camera (for the specified channel).
///
/// This function is used to control the front or rear camera
/// In the case of using a custom video capture function, because the developer has taken over the video data capturing, the SDK is no longer responsible for the video data capturing, this function is no longer valid.
///
/// @param enable Whether to use the front camera, YES: use the front camera, NO: use the the rear camera. The default value is YES
/// @param channel Publishing stream channel
- (void)useFrontCamera:(BOOL)enable channel:(ZegoPublishChannel)channel;
#endif

#if TARGET_OS_IPHONE
/// Set the camera zoom factor.
///
/// Every time the camera is restarted, the camera zoom factor will be restored to its initial value.
///
/// @param factor The zoom factor of the camera, the minimum value is 1.0, and the maximum value is the return value of [getCameraMaxZoomFactor].
- (void)setCameraZoomFactor:(float)factor;
#endif

#if TARGET_OS_IPHONE
/// Set the camera zoom factor.
///
/// Every time the camera is restarted, the camera zoom factor will be restored to its initial value.
///
/// @param factor The zoom factor of the camera, the minimum value is 1.0, and the maximum value is the return value of [getCameraMaxZoomFactor].
/// @param channel Publishing stream channel
- (void)setCameraZoomFactor:(float)factor channel:(ZegoPublishChannel)channel;
#endif

#if TARGET_OS_IPHONE
/// Get the maximum zoom factor of the camera.
///
/// This is only available after the camera has been successfully started, and can generally be called when the captured first frame is received, aka [onPublisherCapturedVideoFirstFrame] callback.
///
/// @return The maximum zoom factor of the camera.
- (float)getCameraMaxZoomFactor;
#endif

#if TARGET_OS_IPHONE
/// Get the maximum zoom factor of the camera.
///
/// This is only available after the camera has been successfully started, and can generally be called when the captured first frame is received, aka [onPublisherCapturedVideoFirstFrame] callback.
///
/// @param channel Publishing stream channel
/// @return The maximum zoom factor of the camera.
- (float)getCameraMaxZoomFactor:(ZegoPublishChannel)channel;
#endif

#if TARGET_OS_OSX
/// Chooses to use the specified video device.
///
/// Choose to use a video device. Only for macOS
///
/// @param deviceID ID of a device obtained by getVideoDeviceList
- (void)useVideoDevice:(NSString *)deviceID;
#endif

#if TARGET_OS_OSX
/// Chooses to use the specified video device (for the specified channel).
///
/// Choose to use a video device. Only for macOS
///
/// @param deviceID ID of a device obtained by getVideoDeviceList
/// @param channel Publishing stream channel
- (void)useVideoDevice:(NSString *)deviceID channel:(ZegoPublishChannel)channel;
#endif

#if TARGET_OS_OSX
/// Gets a list of video devices.
///
/// Choose to use a video device. Only for macOS. Only for macOS
///
/// @return Video device List
- (NSArray<ZegoDeviceInfo *> *)getVideoDeviceList;
#endif

#if TARGET_OS_OSX
/// Get the deviceID of the default video device.
///
/// Get the deviceID of the default video device. Only for macOS
///
/// @return Default video device ID
- (NSString *)getDefaultVideoDeviceID;
#endif

/// Starts sound level monitoring.
///
/// After starting monitoring, you can receive local audio sound level via [onCapturedSoundLevelUpdate] callback, and receive remote audio sound level via [onRemoteSoundLevelUpdate] callback.
/// Before entering the room, you can call [startPreview] with this function and combine it with [onCapturedSoundLevelUpdate] callback to determine whether the audio device is working properly.
/// [onCapturedSoundLevelUpdate] and [onRemoteSoundLevelUpdate] callback notification period is 100 ms.
- (void)startSoundLevelMonitor;

/// Starts sound level monitoring. Support setting the listening interval.
///
/// After starting monitoring, you can receive local audio sound level via [onCapturedSoundLevelUpdate] callback, and receive remote audio sound level via [onRemoteSoundLevelUpdate] callback.
/// Before entering the room, you can call [startPreview] with this function and combine it with [onCapturedSoundLevelUpdate] callback to determine whether the audio device is working properly.
/// [onCapturedSoundLevelUpdate] and [onRemoteSoundLevelUpdate] callback notification period is the value set by the parameter.
///
/// @param millisecond Monitoring time period of the sound level, in milliseconds, has a value range of [100, 3000]. Default is 100 ms.
- (void)startSoundLevelMonitor:(unsigned int)millisecond;

/// Stops sound level monitoring.
///
/// After the monitoring is stopped, the callback of the local/remote audio sound level will be stopped.
- (void)stopSoundLevelMonitor;

/// Starts audio spectrum monitoring.
///
/// After starting monitoring, you can receive local audio spectrum via [onCapturedAudioSpectrumUpdate] callback, and receive remote audio spectrum via [onRemoteAudioSpectrumUpdate] callback.
/// [onCapturedAudioSpectrumUpdate] and [onRemoteAudioSpectrumUpdate] callback notification period is 100 ms.
- (void)startAudioSpectrumMonitor;

/// Starts audio spectrum monitoring. Support setting the listening interval.
///
/// After starting monitoring, you can receive local audio spectrum via [onCapturedAudioSpectrumUpdate] callback, and receive remote audio spectrum via [onRemoteAudioSpectrumUpdate] callback.
/// [onCapturedAudioSpectrumUpdate] and [onRemoteAudioSpectrumUpdate] callback notification period is the value set by the parameter.
///
/// @param millisecond Monitoring time period of the audio spectrum, in milliseconds, has a value range of [100, 3000]. Default is 100 ms.
- (void)startAudioSpectrumMonitor:(unsigned int)millisecond;

/// Stops audio spectrum monitoring.
///
/// After the monitoring is stopped, the callback of the local/remote audio spectrum will be stopped.
- (void)stopAudioSpectrumMonitor;

/// Enables or disables headphone monitoring.
///
/// enable/disable headphone monitor, this setting takes effect when the headset is connected.
///
/// @param enable Whether to use headphone monitor, YES: enable, NO: disable
- (void)enableHeadphoneMonitor:(BOOL)enable;

/// Sets the headphone monitor volume.
///
/// set headphone monitor volume, this setting takes effect when the headset is connected.
///
/// @param volume headphone monitor volume, range from 0 to 200, 100 as default
- (void)setHeadphoneMonitorVolume:(int)volume;

#if TARGET_OS_OSX
/// Enables or disables system audio capture.
///
/// Enable sound card capture to mix sounds played by the system into the publishing stream, such as sounds played by the browser, sounds played by other software, etc. only for macOS
///
/// @param enable Whether to mix system playout
- (void)enableMixSystemPlayout:(BOOL)enable;
#endif

#if TARGET_OS_OSX
/// set mix system playout volume
///
/// only for macOS
///
/// @param volume the volume. Valid range [0, 200], default is 100
- (void)setMixSystemPlayoutVolume:(int)volume;
#endif

#if TARGET_OS_OSX
/// Enables or disables mix engine playout.
///
/// Enable engine playout to mix sounds played by engine into the stream publishing.. only for macOS
///
/// @param enable Whether to mix engine playout
- (void)enableMixEnginePlayout:(BOOL)enable;
#endif

#if TARGET_OS_IPHONE
/// Whether to use the built-in speaker to play audio.This function has been deprecated since version 2.3.0. Please use [setAudioRouteToSpeaker] instead.
///
/// When you choose not to use the built-in speaker to play sound, that is, set to NO, the SDK will select the currently highest priority audio output device to play the sound according to the system schedule
///
/// @deprecated This function has been deprecated since version 2.3.0. Please use [setAudioRouteToSpeaker] instead.
/// @param enable Whether to use the built-in speaker to play sound, YES: use the built-in speaker to play sound, NO: use the highest priority audio output device scheduled by the current system to play sound
- (void)setBuiltInSpeakerOn:(BOOL)enable DEPRECATED_ATTRIBUTE;
#endif

@end

NS_ASSUME_NONNULL_END
