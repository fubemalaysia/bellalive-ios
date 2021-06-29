//
//  ZegoExpressEngine+IM.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (IM)

/// Sends a Broadcast Message.
///
/// The sending frequency of broadcast messages in the same room cannot be higher than 10 messages/s.
/// A certain number of users in the same room who entered the room earlier can receive this callback. The message is reliable. It is generally used when the number of people in the live room is less than a certain number. The specific number is determined by the configuration of the ZEGO server.
/// For restrictions on the use of this function, please refer to https://doc-en.zego.im/article/7611 or contact ZEGO technical support.
///
/// @param message Message content, no longer than 1024 bytes
/// @param roomID Room ID, a string of up to 128 bytes in length. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'
/// @param callback Send broadcast message result callback
- (void)sendBroadcastMessage:(NSString *)message roomID:(NSString *)roomID callback:(nullable ZegoIMSendBroadcastMessageCallback)callback;

/// Sends a Barrage Message (bullet screen) to all users in the same room, without guaranteeing the delivery.
///
/// The frequency of sending barrage messages in the same room cannot be higher than 20 messages/s.
/// The message is unreliable. When the frequency of sending barrage messages in the entire room is greater than 20 messages/s, the recipient may not receive the message. It is generally used in scenarios where there is a large number of messages sent and received in the room and the reliability of the messages is not required, such as live broadcast barrage.
/// For restrictions on the use of this function, please refer to https://doc-en.zego.im/article/7611 or contact ZEGO technical support.
///
/// @param message Message content, no longer than 1024 bytes
/// @param roomID Room ID, a string of up to 128 bytes in length. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'
/// @param callback Send barrage message result callback
- (void)sendBarrageMessage:(NSString *)message roomID:(NSString *)roomID callback:(nullable ZegoIMSendBarrageMessageCallback)callback;

/// Sends a Custom Command to the specified users in the same room.
///
/// Please do not fill in sensitive user information in this interface, including but not limited to mobile phone number, ID number, passport number, real name, etc.
/// The frequency of custom messages sent to a single user in the same room cannot be higher than 200 messages/s, and the frequency of custom messages sent to multiple users cannot be higher than 10 messages/s.
/// The point-to-point signaling type in the same room is generally used for remote control signaling or for sending messages between users. The messages are reliable.
/// For restrictions on the use of this function, please refer to https://doc-en.zego.im/article/7611 or contact ZEGO technical support.
///
/// @param command Custom command content, no longer than 1024 bytes
/// @param toUserList The users who will receive the command
/// @param roomID Room ID, a string of up to 128 bytes in length. Only support numbers, English characters and '~', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '=', '-', '`', ';', '’', ',', '.', '<', '>', '/', '\'
/// @param callback Send command result callback
- (void)sendCustomCommand:(NSString *)command toUserList:(nullable NSArray<ZegoUser *> *)toUserList roomID:(NSString *)roomID callback:(nullable ZegoIMSendCustomCommandCallback)callback;

@end

NS_ASSUME_NONNULL_END
