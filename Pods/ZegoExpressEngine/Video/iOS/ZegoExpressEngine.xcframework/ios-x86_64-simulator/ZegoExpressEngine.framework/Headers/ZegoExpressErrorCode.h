
#ifndef ZegoExpressErrorCode_h
#define ZegoExpressErrorCode_h

typedef NS_ENUM(NSUInteger, ZegoErrorCode) {

    /// Execution successful.
    ZegoErrorCodeCommonSuccess                                             = 0,

    /// Engine not yet created. Please create the engine first before calling non-static functions.
    ZegoErrorCodeCommonEngineNotCreate                                     = 1000001,

    /// Not yet logged in to any room. Please log in to a room before publishing or playing streams.
    ZegoErrorCodeCommonNotLoginRoom                                        = 1000002,

    /// Engine not yet started. Please call `startPreviewView`, `startPublishing`, or `startPlayingStream` to get the engine started first.
    ZegoErrorCodeCommonEngineNotStarted                                    = 1000003,

    /// An API not supported by the current platform is called; for example, an API that sets the Android context is called on a non-Android platform.
    ZegoErrorCodeCommonUnsupportedPlatform                                 = 1000006,

    /// Invalid Android context.
    ZegoErrorCodeCommonInvalidAndroidEnvironment                           = 1000007,

    /// The event handler has already been set by calling `setEventHandler`. Please do not repeat the setting. If you do need to set up the event handler again, please call `setEventHandler` to set it to null first before applying the new setting.
    ZegoErrorCodeCommonEventHandlerExists                                  = 1000008,

    /// This feature is not included in the SDK. Please contact ZEGO technical support.
    ZegoErrorCodeCommonSdkNoModule                                         = 1000010,

    /// The input stream ID is too long. The maximum length should be less than 256 bytes.
    ZegoErrorCodeCommonStreamIdTooLong                                     = 1000014,

    /// The input stream ID is empty.
    ZegoErrorCodeCommonStreamIdNull                                        = 1000015,

    /// The input stream ID contains invalid characters.
    ZegoErrorCodeCommonStreamIdInvalidCharacter                            = 1000016,

    /// This AppID has been removed from production.
    ZegoErrorCodeCommonAppOfflineError                                     = 1000037,

    /// There is an error in the backend configurations. Please check the configuration items of the app.
    ZegoErrorCodeCommonAppFlexiableConfigError                             = 1000038,

    /// Incorrect CDN address. Please check the supported protocol and format.
    ZegoErrorCodeCommonCdnUrlInvalid                                       = 1000055,

    /// DNS resolution failed. Please check network configurations.
    ZegoErrorCodeCommonDnsResolveError                                     = 1000060,

    /// Server dispatching exception. Please contact ZEGO technical support to solve the problem.
    ZegoErrorCodeCommonDispatchError                                       = 1000065,

    /// Internal null pointer error. Please contact ZEGO technical support to solve the problem.
    ZegoErrorCodeCommonInnerNullptr                                        = 1000090,

    /// AppID cannot be 0. Please check if the AppID is correct.
    ZegoErrorCodeEngineAppidZero                                           = 1001000,

    /// The length of the input AppSign must be 64 bytes.
    ZegoErrorCodeEngineAppsignInvalidLength                                = 1001001,

    /// The input AppSign contains invalid characters. Only '0'-'9', 'a'-'f', 'A'-'F' are valid.
    ZegoErrorCodeEngineAppsignInvalidCharacter                             = 1001002,

    /// The input AppSign is empty.
    ZegoErrorCodeEngineAppsignNull                                         = 1001003,

    /// Authentication failed. Please check if the AppID is correct, or whether the production environment was selected for SDK initialization without prior go-live process.
    ZegoErrorCodeEngineAppidIncorrectOrNotOnline                           = 1001004,

    /// AppSign authentication failed. Please check if the AppSign is correct.
    ZegoErrorCodeEngineAppsignIncorrect                                    = 1001005,

    /// No write permission to the log file.
    ZegoErrorCodeEngineLogNoWritePermission                                = 1001014,

    /// The log file path is too long.
    ZegoErrorCodeEngineLogPathTooLong                                      = 1001015,

    /// The experimental API json parameter parsing failed. Please check the correctness of the json content. Such as the correctness of the json format, whether the method name or parameters are passed correctly, etc.
    ZegoErrorCodeEngineExperimentalJsonStrInvalid                          = 1001091,

    /// The number of rooms the user attempted to log into simultaneously exceeds the maximum number allowed. Currently, a user can only be logged in to one main room and one multi room at the same time.
    ZegoErrorCodeRoomCountExceed                                           = 1002001,

    /// The input room ID is incorrect, please check if this room ID is currently logged in.
    ZegoErrorCodeRoomRoomidIncorrect                                       = 1002002,

    /// The input user ID is empty.
    ZegoErrorCodeRoomUserIdNull                                            = 1002005,

    /// The input user ID contains invalid characters.
    ZegoErrorCodeRoomUserIdInvalidCharacter                                = 1002006,

    /// The input user ID is too long. The maximum length should be less than 64 bytes.
    ZegoErrorCodeRoomUserIdTooLong                                         = 1002007,

    /// The input user name is empty.
    ZegoErrorCodeRoomUserNameNull                                          = 1002008,

    /// The input user name contains invalid characters.
    ZegoErrorCodeRoomUserNameInvalidCharacter                              = 1002009,

    /// The input user name is too long. The maximum length should be less than 256 bytes.
    ZegoErrorCodeRoomUserNameTooLong                                       = 1002010,

    /// The input room ID is empty.
    ZegoErrorCodeRoomRoomidNull                                            = 1002011,

    /// The input room ID contains invalid characters.
    ZegoErrorCodeRoomRoomidInvalidCharacter                                = 1002012,

    /// The input room ID is too long. The maximum length should be less than 128 bytes.
    ZegoErrorCodeRoomRoomidTooLong                                         = 1002013,

    /// The key for room extra info is empty.
    ZegoErrorCodeRoomRoomExtraInfoKeyEmpty                                 = 1002014,

    /// The key for room extra info is too long. The maximum length should be less than 128 bytes.
    ZegoErrorCodeRoomRoomExtraInfoKeyTooLong                               = 1002015,

    /// The value for room extra info is too long. The maximum length should be less than 4096 bytes.
    ZegoErrorCodeRoomRoomExtraInfoValueTooLong                             = 1002016,

    /// The set key of the room extra info exceeds the maximum number supported. If you need to modify the number of setting keys, please contact ZEGO technical support.
    ZegoErrorCodeRoomRoomExtraInfoExceedKeys                               = 1002017,

    /// Login failed, possibly due to network problems.
    ZegoErrorCodeRoomErrorConnectFailed                                    = 1002030,

    /// Login timed out, possibly due to network problems.
    ZegoErrorCodeRoomErrorLoginTimeout                                     = 1002031,

    /// Room login authentication failed.
    ZegoErrorCodeRoomErrorAuthenticationFailed                             = 1002033,

    /// The number of users logging into the room exceeds the maximum number of concurrent users configured for the room. (In the test environment, the default maximum number of users in the room is 50)
    ZegoErrorCodeRoomErrorExceedMaximumMember                              = 1002034,

    /// The total number of rooms logged in at the same time exceeds the limit. (In the test environment, the maximum number of concurrent rooms is 10)
    ZegoErrorCodeRoomErrorExceedMaximumRoomCount                           = 1002035,

    /// The user is kicked out of the room, possibly because the same user ID is logged in on another device.
    ZegoErrorCodeRoomKickedOut                                             = 1002050,

    /// Room connection is temporarily interrupted, possibly due to network problems. Retrying...
    ZegoErrorCodeRoomConnectTemporaryBroken                                = 1002051,

    /// Room disconnected, possibly due to network problems.
    ZegoErrorCodeRoomDisconnect                                            = 1002052,

    /// Room login retry has exceeded the maximum retry time.
    ZegoErrorCodeRoomRetryTimeout                                          = 1002053,

    /// The business server has sent a signal to kick the user out of the room. Please check the reason for the kick-out.
    ZegoErrorCodeRoomManualKickedOut                                       = 1002055,

    /// You must log in to the main room with `loginRoom` before logging in to multi room
    ZegoErrorCodeRoomWrongLoginSequence                                    = 1002061,

    /// You must log out of the multi room before logging out of the main room
    ZegoErrorCodeRoomWrongLogoutSequence                                   = 1002062,

    /// No multi-room permission, please contact ZEGO technical support to enable it.
    ZegoErrorCodeRoomNoMultiRoomPermission                                 = 1002063,

    /// Room ID has been used by other login room interface
    ZegoErrorCodeRoomRoomIdHasBeenUsed                                     = 1002064,

    /// Room login failed due to internal system exceptions.
    ZegoErrorCodeRoomInnerError                                            = 1002099,

    /// Stream publishing failed, possibly due to no data in the stream.
    ZegoErrorCodePublisherPublishStreamFailed                              = 1003001,

    /// Incorrect bitrate setting. Please check if the bitrate value is in the correct unit (kbps).
    ZegoErrorCodePublisherBitrateInvalid                                   = 1003002,

    /// Incorrect setting of stream publishing traffic control parameters.
    ZegoErrorCodePublisherTrafficModeInvalid                               = 1003005,

    /// Stream publishing is temporarily interrupted. Retrying...
    ZegoErrorCodePublisherErrorNetworkInterrupt                            = 1003020,

    /// Stream publish retry has exceeds the maximum retry time.
    ZegoErrorCodePublisherErrorRetryTimeout                                = 1003021,

    /// Failed to publish the stream. The user is already publishing streams.
    ZegoErrorCodePublisherErrorAlreadyDoPublish                            = 1003023,

    /// Failed to publish the stream. Publishing of this stream is prohibited by backend configuration.
    ZegoErrorCodePublisherErrorServerForbid                                = 1003025,

    /// Failed to publish the stream. The same stream already exists in the room.
    ZegoErrorCodePublisherErrorRepetitivePublishStream                     = 1003028,

    /// The connection to the RTMP server is interrupted. Please check whether there is any problem with the network connection or the stream publishing URL.
    ZegoErrorCodePublisherRtmpServerDisconnect                             = 1003029,

    /// Failed to take publish stream snapshot, please check whether the state of the publish channel to be snapshot is normal.
    ZegoErrorCodePublisherTakePublishStreamSnapshotFailed                  = 1003030,

    /// Failed to get status updates of relayed streaming to CDN. Please check whether the URL is valid.
    ZegoErrorCodePublisherUpdateCdnTargetError                             = 1003040,

    /// Failed to send SEI. The SEI data is null.
    ZegoErrorCodePublisherSeiDataNull                                      = 1003043,

    /// Failed to send SEI because the SEI data is too long. The maximum length should be less than 4096 bytes.
    ZegoErrorCodePublisherSeiDataTooLong                                   = 1003044,

    /// The extra info of the stream is null.
    ZegoErrorCodePublisherExtraInfoNull                                    = 1003050,

    /// The extra info of the stream is too long. The maximum length should be less than 1024 bytes.
    ZegoErrorCodePublisherExtraInfoTooLong                                 = 1003051,

    /// Failed to update the extra info of the stream. Please check the network connection.
    ZegoErrorCodePublisherUpdateExtraInfoFailed                            = 1003053,

    /// The watermark URL is null.
    ZegoErrorCodePublisherWatermarkUrlNull                                 = 1003055,

    /// The watermark URL is too long. The maximum length should be less than 1024 bytes.
    ZegoErrorCodePublisherWatermarkUrlTooLong                              = 1003056,

    /// Invalid watermark format. The supported formats are `jpg` and `png`.
    ZegoErrorCodePublisherWatermarkUrlInvalid                              = 1003057,

    /// Incorrect watermark layout. The layout area cannot exceed the encoding resolution.
    ZegoErrorCodePublisherWatermarkLayoutInvalid                           = 1003058,

    /// The publish stream encryption key is invalid, the key length only supports 16/24/32 bytes.
    ZegoErrorCodePublisherEncryptionKeyInvalid                             = 1003060,

    /// Stream publishing failed due to system internal exceptions.
    ZegoErrorCodePublisherInnerError                                       = 1003099,

    /// Stream playing failed, possibly due to no data in the stream.
    ZegoErrorCodePlayerPlayStreamFailed                                    = 1004001,

    /// Stream playing failed because the stream does not exist. Please check whether the remote end publish is indeed successful, or whether the publish and play environment are inconsistent
    ZegoErrorCodePlayerPlayStreamNotExist                                  = 1004002,

    /// The number of streams the user attempted to play simultaneously exceeds the maximum number allowed. Currently, up to 12 steams can be played at the same time. Please contact ZEGO technical support to increase the capacity if necessary.
    ZegoErrorCodePlayerCountExceed                                         = 1004010,

    /// Stream playing is temporarily interrupted. Retrying...
    ZegoErrorCodePlayerErrorNetworkInterrupt                               = 1004020,

    /// Failed to play the stream. Publishing of this stream is prohibited by backend configuration.
    ZegoErrorCodePlayerErrorServerForbid                                   = 1004025,

    /// Failed to take play stream snapshot, please check whether the state of the stream to be snapshot is normal.
    ZegoErrorCodePlayerTakePlayStreamSnapshotFailed                        = 1004030,

    /// The play stream decryption key is invalid, the key length only supports 16/24/32 bytes.
    ZegoErrorCodePlayerDecryptionKeyInvalid                                = 1004060,

    /// Decrypt the play stream failed, please check whether the decryption key is correct
    ZegoErrorCodePlayerDecryptionFailed                                    = 1004061,

    /// Stream playing failed due to system internal exceptions.
    ZegoErrorCodePlayerInnerError                                          = 1004099,

    /// Stream mixing service not yet enabled. Please contact ZEGO technical support to enable the service.
    ZegoErrorCodeMixerNoServices                                           = 1005000,

    /// The stream mixing task ID is null.
    ZegoErrorCodeMixerTaskIdNull                                           = 1005001,

    /// The stream mixing task ID is too long. The maximum length should be less than 256 bytes.
    ZegoErrorCodeMixerTaskIdTooLong                                        = 1005002,

    /// The stream mixing task ID contains invalid characters.
    ZegoErrorCodeMixerTaskIdInvalidCharacter                               = 1005003,

    /// No output is specified in the configuration of the stream mixing task.
    ZegoErrorCodeMixerNoOutputTarget                                       = 1005005,

    /// Incorrect stream mixing output. Please check if the streamID of the output target contains invalid characters.
    ZegoErrorCodeMixerOutputTargetInvalid                                  = 1005006,

    /// Failed to start the stream mixing task, possibly due to network problems.
    ZegoErrorCodeMixerStartRequestError                                    = 1005010,

    /// Failed to stop the stream mixing task, possibly due to network problems.
    ZegoErrorCodeMixerStopRequestError                                     = 1005011,

    /// The stream mixing task must be stopped by the user who started the task.
    ZegoErrorCodeMixerNotOwnerStopMixer                                    = 1005012,

    /// Starts stream mixing tasks too frequently.
    ZegoErrorCodeMixerStartQpsOverload                                     = 1005015,

    /// Stops stream mixing tasks too frequently.
    ZegoErrorCodeMixerStopQpsOverload                                      = 1005016,

    /// The input stream list of the stream mixing task is null.
    ZegoErrorCodeMixerInputListInvalid                                     = 1005020,

    /// The output stream list of the stream mixing task is null.
    ZegoErrorCodeMixerOutputListInvalid                                    = 1005021,

    /// The video configuration of the stream mixing task is invalid.
    ZegoErrorCodeMixerVideoConfigInvalid                                   = 1005023,

    /// The audio configuration of the stream mixing task is invalid. Please check if an unsupported codec is used.
    ZegoErrorCodeMixerAudioConfigInvalid                                   = 1005024,

    /// The number of input streams exceeds the maximum number allowed. Up to 9 input streams can be specified.
    ZegoErrorCodeMixerExceedMaxInputCount                                  = 1005025,

    /// The input stream does not exist.
    ZegoErrorCodeMixerInputStreamNotExists                                 = 1005026,

    /// Invalid stream mixing input parameters. It may be that the layout of the input streams exceeds the canvas.
    ZegoErrorCodeMixerInputParametersError                                 = 1005027,

    /// The number of output streams exceeds the maximum number allowed. Up to 3 output streams can be specified.
    ZegoErrorCodeMixerExceedMaxOutputCount                                 = 1005030,

    /// Exceed the maximum number of focus voice input streams, and support up to 4 input streams to set focus voice
    ZegoErrorCodeMixerExceedMaxAudioFocusStreamCount                       = 1005031,

    /// Stream mixing authentication failed.
    ZegoErrorCodeMixerAuthenticationFailed                                 = 1005050,

    /// The input watermark is null.
    ZegoErrorCodeMixerWatermarkNull                                        = 1005061,

    /// Invalid watermark parameter. It may be that the layout of the watermark exceeds the canvas.
    ZegoErrorCodeMixerWatermarkParametersError                             = 1005062,

    /// Invalid watermark URL. The URL must start with `preset-id://`, and must end with `.jpg` or `.png`.
    ZegoErrorCodeMixerWatermarkUrlInvalid                                  = 1005063,

    /// Invalid background image URL. The URL must start with `preset-id://`, and must end with `.jpg` or `.png`.
    ZegoErrorCodeMixerBackgroundImageUrlInvalid                            = 1005067,

    /// The server for auto stream mixing is not found. Please contact ZEGO technical support to enable it.
    ZegoErrorCodeMixerAutoMixStreamServerNotFound                          = 1005070,

    /// Stream mixing internal error.
    ZegoErrorCodeMixerInnerError                                           = 1005099,

    /// Generic device error.
    ZegoErrorCodeDeviceErrorTypeGeneric                                    = 1006001,

    /// The device ID does not exist.
    ZegoErrorCodeDeviceErrorTypeInvalidId                                  = 1006002,

    /// No permission to access the device. Please check the permissions of the camera or microphone.
    ZegoErrorCodeDeviceErrorTypeNoAuthorization                            = 1006003,

    /// The frame rate of the capture device is 0.
    ZegoErrorCodeDeviceErrorTypeZeroFps                                    = 1006004,

    /// The device is occupied.
    ZegoErrorCodeDeviceErrorTypeInUseByOther                               = 1006005,

    /// The device is unplugged.
    ZegoErrorCodeDeviceErrorTypeUnplugged                                  = 1006006,

    /// The device needs to be restarted.
    ZegoErrorCodeDeviceErrorTypeRebootRequired                             = 1006007,

    /// The device media is lost.
    ZegoErrorCodeDeviceErrorMediaServicesLost                              = 1006008,

    /// The device list cannot be empty when trying to release devices.
    ZegoErrorCodeDeviceFreeDeviceListNull                                  = 1006020,

    /// The set sound level monitoring interval is out of range.
    ZegoErrorCodeDeviceSouldLevelIntervalInvalid                           = 1006031,

    /// The set audio spectrum monitoring interval is out of range.
    ZegoErrorCodeDeviceAudioSpectrumIntervalInvalid                        = 1006032,

    /// The set camera zoom factor is out of range.
    ZegoErrorCodeDeviceZoomFactorInvalid                                   = 1006040,

    /// Device internal error.
    ZegoErrorCodeDeviceInnerError                                          = 1006099,

    /// Unknown error in the preprocessing module. Please contact ZEGO technical support.
    ZegoErrorCodePreprocessPreprocessUnknownError                          = 1007001,

    /// Invalid beauty option. Please check the input parameters.
    ZegoErrorCodePreprocessBeautifyOptionInvalid                           = 1007005,

    /// The reverberation parameter is null. Please check the input parameter.
    ZegoErrorCodePreprocessReverbParamNull                                 = 1007006,

    /// The voice changer parameter is null. Please check the input parameter.
    ZegoErrorCodePreprocessVoiceChangerParamNull                           = 1007007,

    /// The room size value of the reverberation parameters is invalid. The value should be in the range of 0.0 ~ 1.0.
    ZegoErrorCodePreprocessReverbParamRoomSizeInvalid                      = 1007011,

    /// The reverberance value of the reverberation parameters is invalid. The value should be in the range of 0.0 ~ 0.5.
    ZegoErrorCodePreprocessReverbParamReverberanceInvalid                  = 1007012,

    /// The damping value of the reverberation parameters is invalid. The value should be in the range of 0.0 ~ 2.0.
    ZegoErrorCodePreprocessReverbParamDampingInvalid                       = 1007013,

    /// The dry_wet_ratio value of the reverberation parameters is invalid. The value should be greater than 0.0.
    ZegoErrorCodePreprocessReverbParamDryWetRatioInvalid                   = 1007014,

    /// The angle value of the virtual stereo parameters is invalid. The value should be in the range of 0 ~ 180.
    ZegoErrorCodePreprocessVirtualStereoAngleInvalid                       = 1007015,

    /// The voice changer param is invalid. The value should be in the range of -8.0 ~ 8.0.
    ZegoErrorCodePreprocessVoiceChangerParamInvalid                        = 1007016,

    /// The reverberation echo parameters is null. Please check the input parameter.
    ZegoErrorCodePreprocessReverbEchoParamNull                             = 1007017,

    /// The reverberation echo parameters is invalid.
    ZegoErrorCodePreprocessReverbEchoParamInvalid                          = 1007018,

    /// The MediaPlayer instance is not created.
    ZegoErrorCodeMediaPlayerNoInstance                                     = 1008001,

    /// The MediaPlayer failed to play the media. The resource file is not loaded.
    ZegoErrorCodeMediaPlayerNoFilePath                                     = 1008003,

    /// The MediaPlayer failed to load the file. The file format is not supported.
    ZegoErrorCodeMediaPlayerFileFormatError                                = 1008005,

    /// The MediaPlayer failed to load the file. The file path does not exist.
    ZegoErrorCodeMediaPlayerFilePathNotExists                              = 1008006,

    /// The MediaPlayer failed to load the file due to decoding errors.
    ZegoErrorCodeMediaPlayerFileDecodeError                                = 1008007,

    /// The MediaPlayer failed to load files. No supported audio/video stream exists.
    ZegoErrorCodeMediaPlayerFileNoSupportedStream                          = 1008008,

    /// The MediaPlayer failed to play the file due to demuxing errors.
    ZegoErrorCodeMediaPlayerDemuxError                                     = 1008010,

    /// The MediaPlayer failed to seek, possibly because the file hasn't been loaded yet.
    ZegoErrorCodeMediaPlayerSeekError                                      = 1008016,

    /// The MediaPlayer is configured with a video data format not supported by the platform (e.g., CVPixelBuffer on iOS does not support NV21).
    ZegoErrorCodeMediaPlayerPlatformFormatNotSupported                     = 1008020,

    /// The number of MediaPlayer instances exceeds the maximum number allowed. Up to 4 instances can be created.
    ZegoErrorCodeMediaPlayerExceedMaxCount                                 = 1008030,

    /// The media player failed to specify the audio track index
    ZegoErrorCodeMediaPlayerSetAudioTrackIndexError                        = 1008040,

    /// Invalid voice changing parameters set by media player
    ZegoErrorCodeMediaPlayerSetVoiceChangerParamInvalid                    = 1008041,

    /// To make `takeSnapshot` effective, you need to ensure that the video is playing and `setPlayerCanvas` has been called to display the video on the control
    ZegoErrorCodeMediaPlayerTakeSnapshotTimingError                        = 1008042,

    /// The input parameter is not within the legal value range. Please check the interface notes and input a value within the legal value range.
    ZegoErrorCodeMediaPlayerParamValueRangeIllegal                         = 1008043,

    /// MediaPlayer internal error.
    ZegoErrorCodeMediaPlayerInnerError                                     = 1008099,

    /// The input message content is empty.
    ZegoErrorCodeIMContentNull                                             = 1009001,

    /// The input message content is too long. The maximum length should be less than 1024 bytes.
    ZegoErrorCodeIMContentTooLong                                          = 1009002,

    /// The room where the message is sent is different from the room currently logged in
    ZegoErrorCodeIMInconsistentRoomId                                      = 1009005,

    /// Failed to send the message, possibly due to network problems.
    ZegoErrorCodeIMSendFailed                                              = 1009010,

    /// Failed to send broadcast message, QPS exceeds the limit, the maximum QPS is 2
    ZegoErrorCodeIMBroadcastMessageQpsOverload                             = 1009015,

    /// The file name suffix is not supported. Only .mp4/.aac/.flv are supported currently. Depending on file name suffix, SDK sets the specified recording format accordingly.
    ZegoErrorCodeRecorderFileSuffixNameFormatNotSupport                    = 1010002,

    /// Generic error of recording API, generally due to invalid input parameters.
    ZegoErrorCodeRecorderCommonLiveroomApiError                            = 1010003,

    /// The specified recorded file path is too long. The maximum length should be less than 1024 bytes.
    ZegoErrorCodeRecorderFilePathTooLong                                   = 1010011,

    /// SDK internal VE error. Please contact ZEGO technical support to solve the problem.
    ZegoErrorCodeRecorderInnerVeError                                      = 1010012,

    /// Failed to open the file. Invalid file path or no permissions to the file.
    ZegoErrorCodeRecorderOpenFileFailed                                    = 1010013,

    /// Failed to write to the file, possibly due to no write permission to the file.
    ZegoErrorCodeRecorderWriteFileError                                    = 1010014,

    /// Not enough spare capacity.
    ZegoErrorCodeRecorderNoEnoughSpareCapacity                             = 1010017,

    /// File handle exceptions.
    ZegoErrorCodeRecorderFileHandleExceptions                              = 1010018,

    /// I/O exceptions.
    ZegoErrorCodeRecorderIoExceptions                                      = 1010019,

    /// The custom video capturer is not created. Please make sure to use it only after the `onStart` callback is received.
    ZegoErrorCodeCustomVideoIOCapturerNotCreated                           = 1011001,

    /// The custom video capture module is not enabled. Please make sure it is enabled in the initialization configurations.
    ZegoErrorCodeCustomVideoIONoCustomVideoCapture                         = 1011002,

    /// Failed to enable/disable custom video capture/rendering. Please make sure to enable/disable it before the engine is started (i.e., before calling `startPreview`, `startPublishingStream` or `startPlayingStream`).
    ZegoErrorCodeCustomVideoIOEnableCustomIoFailed                         = 1011003,

    /// The custom video capturer is not created.
    ZegoErrorCodeCustomVideoIOProcessModuleNotCreated                      = 1011004,

    /// The custom video process module is not enabled. Please make sure that is called [enableCustomVideoProcessing].
    ZegoErrorCodeCustomVideoIONoCustomVideoProcessing                      = 1011005,

    /// The currently configured custom video capture format does not support this API.
    ZegoErrorCodeCustomVideoIONotSupportedFormat                           = 1011010,

    /// Custom video rendering does not support the currently set video buffer type.
    ZegoErrorCodeCustomVideoIONotSupportedBufferType                       = 1011011,

    /// Unsupported custom audio source type.
    ZegoErrorCodeCustomAudioIOUnsupportedAudioSourceType                   = 1012001,

    /// The custom audio capture feature is not enabled. Please make sure that the custom audio IO module is enabled for the specified stream publishing channel.
    ZegoErrorCodeCustomAudioIOCapturerNotCreated                           = 1012002,

    /// The custom audio rendering feature is not enabled. Please make sure that the custom audio IO module is enabled.
    ZegoErrorCodeCustomAudioIORendererNotCreated                           = 1012003,

    /// Failed to enable/disable custom audio IO. Please make sure to enable/disable it before the engine is started (i.e., before calling `startPreview`, `startPublishingStream` or `startPlayingStream`).
    ZegoErrorCodeCustomAudioIOEnableCustomAudioIoFailed                    = 1012004,

    /// The sample rate parameter is illegal, please confirm whether the sample rate parameter value allowed by the interface is legal
    ZegoErrorCodeCustomAudioIOAudioDataCallbackSampleRateNoSupport         = 1012010,

    /// The MediaDataPublisher instance is not created.
    ZegoErrorCodeMediaDataPublisherNoInstance                              = 1013000,

    /// File error, failed to open
    ZegoErrorCodeMediaDataPublisherFileParseError                          = 1013001,

    /// File path error
    ZegoErrorCodeMediaDataPublisherFilePathError                           = 1013002,

    /// File decoding exception
    ZegoErrorCodeMediaDataPublisherFileCodecError                          = 1013003,

    /// Timestamp error (the later frame timestamp is smaller than the previous frame timestamp)
    ZegoErrorCodeMediaDataPublisherTimestampGoBackError                    = 1013004,

    /// The AudioEffectPlayer instance is not created.
    ZegoErrorCodeAudioEffectPlayerNoInstance                               = 1014000,

    /// loadResource failed
    ZegoErrorCodeAudioEffectPlayerLoadFailed                               = 1014001,

    /// play audio effect failed
    ZegoErrorCodeAudioEffectPlayerPlayFailed                               = 1014002,

    /// seekTo failed
    ZegoErrorCodeAudioEffectPlayerSeekFailed                               = 1014003,

    /// The number of AudioEffectPlayer instances exceeds the maximum number allowed.
    ZegoErrorCodeAudioEffectPlayerExceedMaxCount                           = 1014004,

    /// Network connectivity test failed.
    ZegoErrorCodeUtilitiesNetworkConnectivityTestFailed                    = 1015001,

    /// Network speed test connection failure.
    ZegoErrorCodeUtilitiesNetworkToolConnectServerFailed                   = 1015002,

    /// RTP timeout, please check whether the network is normal.
    ZegoErrorCodeUtilitiesNetworkToolRtpTimeoutError                       = 1015003,

    /// engine denied to continue testing network.
    ZegoErrorCodeUtilitiesNetworkToolEngineDenied                          = 1015004,

    /// Actively stop network test when starting to publish the stream.
    ZegoErrorCodeUtilitiesNetworkToolStoppedByPublishingStream             = 1015005,

    /// Actively stop network test when starting to play the stream.
    ZegoErrorCodeUtilitiesNetworkToolStoppedByPlayingStream                = 1015006,

    /// Network test internal error.
    ZegoErrorCodeUtilitiesNetworkToolInnerError                            = 1015009,

    /// The set system performance monitoring interval is out of range.
    ZegoErrorCodeUtilitiesPerformanceMonitorIntervalInvalid                = 1015031,


};

#endif /* ZegoExpressErrorCode_h */
