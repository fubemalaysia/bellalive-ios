//
//  ZegoExpressEngine+Room.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (Room)

/// Logs in to a room. You must log in to a room before publishing or playing streams.
///
/// Please do not fill in sensitive user information in this interface, including but not limited to mobile phone number, ID number, passport number, real name, etc.
/// Different users who log in to the same room can get room related notifications in the same room (eg [onRoomUserUpdate], [onRoomStreamUpdate], etc.), and users in one room cannot receive room signaling notifications in another room.
/// Messages sent in one room (e.g. [setStreamExtraInfo], [sendBroadcastMessage], [sendBarrageMessage], [sendCustomCommand], etc.) cannot be received callback ((eg [onRoomStreamExtraInfoUpdate], [onIMRecvBroadcastMessage], [onIMRecvBarrageMessage], [onIMRecvCustomCommand], etc) in other rooms. Currently, SDK does not provide the ability to send messages across rooms. Developers can integrate the SDK of third-party IM to achieve.
/// SDK supports startPlayingStream audio and video streams from different rooms under the same appID, that is, startPlayingStream audio and video streams across rooms. Since ZegoExpressEngine's room related callback notifications are based on the same room, when developers want to startPlayingStream streams across rooms, developers need to maintain related messages and signaling notifications by themselves.
/// When the user starts to log in to the room, the room is successfully logged in, or the room fails to log in, the [onRoomStateUpdate] callback will be triggered to notify the developer of the status of the current user connected to the room.
/// If the network is temporarily interrupted due to network quality reasons, the SDK will automatically reconnect internally. You can get the current connection status of the local room by listening to the [onRoomStateUpdate] callback method, and other users in the same room will receive [onRoomUserUpdate] callback notification.
/// It is strongly recommended that userID corresponds to the user ID of the business APP, that is, a userID and a real user are fixed and unique, and should not be passed to the SDK in a random userID. Because the unique and fixed userID allows ZEGO technicians to quickly locate online problems.
/// After the first login failure due to network reasons or the room is disconnected, the default time of SDK reconnection is 20min.
/// For restrictions on the use of this function, please refer to https://doc-en.zego.im/article/7611  or contact ZEGO technical support.
///
/// @param roomID Room ID, a string of up to 128 bytes in length. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'
/// @param user User object instance, configure userID, userName. Note that the userID needs to be globally unique with the same appID, otherwise the user who logs in later will kick out the user who logged in first.
- (void)loginRoom:(NSString *)roomID user:(ZegoUser *)user;

/// Logs in to a room with advanced room configurations. You must log in to a room before publishing or playing streams.
///
/// Please do not fill in sensitive user information in this interface, including but not limited to mobile phone number, ID number, passport number, real name, etc.
/// To prevent the app from being impersonated by a malicious user, you can add authentication before logging in to the room, that is, the [token] parameter in the ZegoRoomConfig object passed in by the [config] parameter.
/// Different users who log in to the same room can get room related notifications in the same room (eg [onRoomUserUpdate], [onRoomStreamUpdate], etc.), and users in one room cannot receive room signaling notifications in another room.
/// Messages sent in one room (e.g. [setStreamExtraInfo], [sendBroadcastMessage], [sendBarrageMessage], [sendCustomCommand], etc.) cannot be received callback ((eg [onRoomStreamExtraInfoUpdate], [onIMRecvBroadcastMessage], [onIMRecvBarrageMessage], [onIMRecvCustomCommand], etc) in other rooms. Currently, SDK does not provide the ability to send messages across rooms. Developers can integrate the SDK of third-party IM to achieve.
/// SDK supports startPlayingStream audio and video streams from different rooms under the same appID, that is, startPlayingStream audio and video streams across rooms. Since ZegoExpressEngine's room related callback notifications are based on the same room, when developers want to startPlayingStream streams across rooms, developers need to maintain related messages and signaling notifications by themselves.
/// When the user starts to log in to the room, the room is successfully logged in, or the room fails to log in, the [onRoomStateUpdate] callback will be triggered to notify the developer of the status of the current user connected to the room.
/// If the network is temporarily interrupted due to network quality reasons, the SDK will automatically reconnect internally. You can get the current connection status of the local room by listening to the [onRoomStateUpdate] callback method, and other users in the same room will receive [onRoomUserUpdate] callback notification.
/// It is strongly recommended that userID corresponds to the user ID of the business APP, that is, a userID and a real user are fixed and unique, and should not be passed to the SDK in a random userID. Because the unique and fixed userID allows ZEGO technicians to quickly locate online problems.
/// After the first login failure due to network reasons or the room is disconnected, the default time of SDK reconnection is 20min.
/// For restrictions on the use of this function, please refer to https://doc-en.zego.im/article/7611  or contact ZEGO technical support.
///
/// @param roomID Room ID, a string of up to 128 bytes in length. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'
/// @param user User object instance, configure userID, userName. Note that the userID needs to be globally unique with the same appID, otherwise the user who logs in later will kick out the user who logged in first.
/// @param config Advanced room configuration
- (void)loginRoom:(NSString *)roomID user:(ZegoUser *)user config:(ZegoRoomConfig *)config;

/// Logs in multi room.
///
/// You must log in the main room with [loginRoom] before invoke this function to logging in to multi room.
/// Currently supports logging into 1 main room and 1 multi room at the same time.
/// When logging out, you must log out of the multi room before logging out of the main room.
/// User can only publish the stream in the main room, but can play the stream in the main room and multi room at the same time, and can receive the signaling and callback in each room.
/// The advantage of multi room is that you can login another room without leaving the current room, receive signaling and callback from another room, and play streams from another room.
/// To prevent the app from being impersonated by a malicious user, you can add authentication before logging in to the room, that is, the [token] parameter in the ZegoRoomConfig object passed in by the [config] parameter.
/// Different users who log in to the same room can get room related notifications in the same room (eg [onRoomUserUpdate], [onRoomStreamUpdate], etc.), and users in one room cannot receive room signaling notifications in another room.
/// Messages sent in one room (e.g. [setStreamExtraInfo], [sendBroadcastMessage], [sendBarrageMessage], [sendCustomCommand], etc.) cannot be received callback ((eg [onRoomStreamExtraInfoUpdate], [onIMRecvBroadcastMessage], [onIMRecvBarrageMessage], [onIMRecvCustomCommand], etc) in other rooms. Currently, SDK does not provide the ability to send messages across rooms. Developers can integrate the SDK of third-party IM to achieve.
/// SDK supports startPlayingStream audio and video streams from different rooms under the same appID, that is, startPlayingStream audio and video streams across rooms. Since ZegoExpressEngine's room related callback notifications are based on the same room, when developers want to startPlayingStream streams across rooms, developers need to maintain related messages and signaling notifications by themselves.
/// If the network is temporarily interrupted due to network quality reasons, the SDK will automatically reconnect internally. You can get the current connection status of the local room by listening to the [onRoomStateUpdate] callback method, and other users in the same room will receive [onRoomUserUpdate] callback notification.
/// It is strongly recommended that userID corresponds to the user ID of the business APP, that is, a userID and a real user are fixed and unique, and should not be passed to the SDK in a random userID. Because the unique and fixed userID allows ZEGO technicians to quickly locate online problems.
///
/// @param roomID Room ID, a string of up to 128 bytes in length. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'
/// @param config Advanced room configuration
- (void)loginMultiRoom:(NSString *)roomID config:(nullable ZegoRoomConfig *)config;

/// Logs out of a room.
///
/// Exiting the room will stop all publishing and playing streams for user, and inner audio and video engine will stop, and then SDK will auto stop local preview UI. If you want to keep the preview ability when switching rooms, please use the [switchRoom] method.
/// After calling this function, you will receive [onRoomStateUpdate] callback notification successfully exits the room, while other users in the same room will receive the [onRoomUserUpdate] callback notification(On the premise of enabling isUserStatusNotify configuration).'
///
/// @param roomID Room ID, a string of up to 128 bytes in length. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'
- (void)logoutRoom:(NSString *)roomID;

/// Switch the room.
///
/// After successfully login room, if you need to quickly switch to the next room, you can call this function.
/// Calling this function is faster and easier to use than calling [logoutRoom] and then [loginRoom].
/// When this function is called, all streams currently publishing or playing will stop (but the local preview will not stop).
///
/// @param fromRoomID Current roomID
/// @param toRoomID The next roomID
- (void)switchRoom:(NSString *)fromRoomID toRoomID:(NSString *)toRoomID;

/// Switch the room with advanced room configurations.
///
/// After successfully login room, if you need to quickly switch to the next room, you can call this function.
/// Calling this function is faster and easier to use than calling [logoutRoom] and then [loginRoom].
/// When this function is called, all streams currently publishing or playing will stop (but the local preview will not stop).
/// To prevent the app from being impersonated by a malicious user, you can add authentication before logging in to the room, that is, the [token] parameter in the ZegoRoomConfig object passed in by the [config] parameter. This parameter configuration affects the room to be switched over.
///
/// @param fromRoomID Current roomID
/// @param toRoomID The next roomID
/// @param config Advanced room configuration
- (void)switchRoom:(NSString *)fromRoomID toRoomID:(NSString *)toRoomID config:(ZegoRoomConfig *)config;

/// Renew token
///
/// After the developer receives [onRoomTokenWillExpire], they can use this API to update the token to ensure that the subsequent RTC functions are normal
///
/// @param token The token that needs to be renew
/// @param roomID Room ID.
- (void)renewToken:(NSString *)token roomID:(NSString *)roomID;

/// Set room extra information.
///
/// After the user in the room calls this function to set the extra info of the room, other users in the same room will be notified through the [onRoomExtraInfoUpdate] callback function.
/// For restrictions on the use of this function, please refer to https://doc-en.zego.im/article/7611 or contact ZEGO technical support.
///
/// @param value value if the extra info.
/// @param key key of the extra info.
/// @param roomID Room ID.
/// @param callback Callback for setting room extra information
- (void)setRoomExtraInfo:(NSString *)value forKey:(NSString *)key roomID:(NSString *)roomID callback:(nullable ZegoRoomSetRoomExtraInfoCallback)callback;

@end

NS_ASSUME_NONNULL_END
