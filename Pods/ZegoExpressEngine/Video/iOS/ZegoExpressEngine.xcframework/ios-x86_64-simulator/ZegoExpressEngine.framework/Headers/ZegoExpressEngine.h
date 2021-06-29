//
//  Version: 2.8.0.1749_stable_video
//
//  ZegoExpressEngine.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEventHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine : NSObject

/// Creates a singleton instance of ZegoExpressEngine.
///
/// The engine needs to be created and initialized before calling other functions. The SDK only supports the creation of one instance of ZegoExpressEngine. Multiple calls to this function return the same object.
///
/// @param appID Application ID issued by ZEGO for developers, please apply from the ZEGO Admin Console https://console-express.zego.im The value ranges from 0 to 4294967295.
/// @param appSign Application signature for each AppID, please apply from the ZEGO Admin Console. Application signature is a 64 character string. Each character has a range of '0' ~ '9', 'a' ~ 'z'.
/// @param isTestEnv Choose to use a test environment or a formal commercial environment, the formal environment needs to submit work order configuration in the ZEGO management console. The test environment is for test development, with a limit of 10 rooms and 50 users. Official environment App is officially launched. ZEGO will provide corresponding server resources according to the configuration records submitted by the developer in the management console. The test environment and the official environment are two sets of environments and cannot be interconnected.
/// @param scenario The application scenario. Developers can choose one of ZegoScenario based on the scenario of the app they are developing, and the engine will preset a more general setting for specific scenarios based on the set scenario. After setting specific scenarios, developers can still call specific functions to set specific parameters if they have customized parameter settings.
/// @param eventHandler Event notification callback. [nil] means not receiving any callback notifications.It can also be managed later via [setEventHandler]
/// @return Engine singleton instance.
+ (ZegoExpressEngine *)createEngineWithAppID:(unsigned int)appID appSign:(NSString *)appSign isTestEnv:(BOOL)isTestEnv scenario:(ZegoScenario)scenario eventHandler:(nullable id<ZegoEventHandler>)eventHandler;

/// Destroys the singleton instance of ZegoExpressEngine asynchronously.
///
/// Used to release resources used by ZegoExpressEngine.
///
/// @param callback Notification callback for destroy engine completion. Developers can listen to this callback to ensure that device hardware resources are released. This callback is only used to notify the completion of the release of internal resources of the engine. Developers cannot release resources related to the engine within this callback. If the developer only uses SDK to implement audio and video functions, this parameter can be passed [nil].
+ (void)destroyEngine:(nullable ZegoDestroyCompletionCallback)callback;

/// Returns the singleton instance of ZegoExpressEngine.
///
/// If the engine has not been created or has been destroyed, an unusable engine object will be returned.
///
/// @return Engine singleton instance
+ (ZegoExpressEngine *)sharedEngine;

/// Set advanced engine configuration.
///
/// Developers need to call this function to set advanced function configuration when they need advanced functions of the engine.
///
/// @param config Advanced engine configuration
+ (void)setEngineConfig:(ZegoEngineConfig *)config;

/// Set log configuration.
///
/// When developers need to customize the log file size and path, they need to call this function to complete the configuration.It must be set before calling [createEngine] to take effect. If it is set after [createEngine], it will take effect at the next [createEngine] after [destroyEngine].Once this interface is called, the old way of setting log size and path through [setEngineConfig] will be invalid before destroyEngine, that is, during the entire life cycle of the engine.It is recommended that once you use this method, you always only use this method to complete the requirements for setting the log path and size.
///
/// @param config log configuration
+ (void)setLogConfig:(ZegoLogConfig *)config;

/// Gets the SDK's version number.
///
/// When the SDK is running, the developer finds that it does not match the expected situation and submits the problem and related logs to the ZEGO technical staff for locating. The ZEGO technical staff may need the information of the engine version to assist in locating the problem.
/// Developers can also collect this information as the version information of the engine used by the app, so that the SDK corresponding to each version of the app on the line.
///
/// @return SDK version
+ (NSString *)getVersion;

/// Set the setting of the execution result of the calling method. After setting, you can get the detailed information of the result of each execution of the ZEGO SDK method
///
/// @param callback Method execution result callback
+ (void)setApiCalledCallback:(nullable id<ZegoApiCalledEventHandler>)callback;

/// Sets up the event notification callbacks that need to be handled. If the eventHandler is set to [nil], all the callbacks set previously will be cleared.
///
/// Invoke this function will OVERWRITE the handler set in [createEngine] or the handler set by the last call to this method.
///
/// @param eventHandler Event notification callback. Developers should override callback related methods to focus on specific notifications based on their own business scenarios. The main callback methods of SDK are in [IZegoEventHandler].
- (void)setEventHandler:(nullable id<ZegoEventHandler>)eventHandler;

/// Uploads logs to the ZEGO server.
///
/// By default, SDK creates and prints log files in the app's default directory. Each log file defaults to a maximum of 5MB. Three log files are written over and over in a circular fashion. When calling this function, SDK will auto package and upload the log files to the ZEGO server.
/// Developers can provide a business “feedback” channel in the app. When users feedback problems, they can call this function to upload the local log information of SDK to help locate user problems.
/// The function is valid for the entire life cycle of the SDK.
- (void)uploadLog;

/// Uploads logs to the ZEGO server.
///
/// By default, SDK creates and prints log files in the app's default directory. Each log file defaults to a maximum of 5MB. Three log files are written over and over in a circular fashion. When calling this function, SDK will auto package and upload the log files to the ZEGO server.
/// Developers can provide a business “feedback” channel in the app. When users feedback problems, they can call this function to upload the local log information of SDK to help locate user problems.
/// The function is valid for the entire life cycle of the SDK.
///
/// @param callback Log upload result callback
- (void)uploadLog:(nullable ZegoUploadLogResultCallback)callback;

/// Turns on/off verbose debugging and sets up the log language.
///
/// The debug switch is set to on and the language is English by default.
///
/// @deprecated This method has been deprecated after version 2.3.0, please use the [setEngineConfig] function to set the advanced configuration property advancedConfig to achieve the original function.
/// @param enable Detailed debugging information switch
/// @param language Debugging information language
- (void)setDebugVerbose:(BOOL)enable language:(ZegoLanguage)language DEPRECATED_ATTRIBUTE;

/// Call the RTC experimental API
///
/// ZEGO provides some technical previews or special customization functions in RTC business through this API. If you need to get the use of the function or the details, please consult ZEGO technical support
///
/// @param params You need to pass in a parameter in the form of a JSON string
/// @return Returns an argument in the format of a JSON string
- (NSString *)callExperimentalAPI:(NSString *)params;

/// This function is unavailable.
///
/// Please use [+createEngineWithAppID:appSign:isTestEnv:scenario:eventHandler:] instead
+ (instancetype)new NS_UNAVAILABLE;

/// This function is unavailable.
///
/// Please use [+createEngineWithAppID:appSign:isTestEnv:scenario:eventHandler:] instead
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

#import "ZegoExpressEngine+CustomAudioIO.h"
#import "ZegoExpressEngine+Device.h"
#import "ZegoExpressEngine+IM.h"
#import "ZegoExpressEngine+MediaPlayer.h"
#import "ZegoExpressEngine+AudioEffectPlayer.h"
#import "ZegoExpressEngine+Mixer.h"
#import "ZegoExpressEngine+Player.h"
#import "ZegoExpressEngine+Preprocess.h"
#import "ZegoExpressEngine+Publisher.h"
#import "ZegoExpressEngine+Record.h"
#import "ZegoExpressEngine+Room.h"
#import "ZegoExpressEngine+Utilities.h"
#if ZEGO_EXPRESS_VIDEO_SDK
#import "ZegoExpressEngine+CustomVideoIO.h"
#import "ZegoExpressEngine+ReplayKit.h"
#endif
