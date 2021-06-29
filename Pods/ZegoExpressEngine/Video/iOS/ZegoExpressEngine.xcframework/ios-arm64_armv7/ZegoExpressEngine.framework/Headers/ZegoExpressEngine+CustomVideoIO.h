//
//  ZegoExpressEngine+CustomVideoIO.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (CustomVideoIO)

/// Enables or disables custom video rendering.
///
/// It must be set before the engine starts, that is, before calling [startPreview], [startPublishingStream], [startPlayingStream]; and the configuration can be modified after the engine is stopped， that is after calling [logoutRoom].
/// When the developer starts custom rendering, by calling [setCustomVideoRenderHandler], you can set to receive local and remote video frame data for custom rendering
/// The custom video rendering function can be used with the custom video capture function at the same time, but when both are enabled at the same time, the local capture frame callback of the custom video rendering will no longer be triggered, and the developer should directly in the custom video capture source Get the captured video frame directly.
///
/// @param enable enable or disable
/// @param config custom video render config
- (void)enableCustomVideoRender:(BOOL)enable config:(nullable ZegoCustomVideoRenderConfig *)config;

/// Sets up the event callback handler for custom video rendering.
///
/// Custom video render, developers are responsible for rendering video data to UI components. This feature is generally used by developers who use third-party beauty features or use third-party rendering frameworks.
/// When you use the advanced features of ZegoExpressEngine's custom video render, you need to call this function to set a callback object for developers to transfer video data.
/// When you call the start preview [startPreview], start publishing stream [startPublishingStream], or start playing stream [startPlayingStream], the callback function that transfer video data to you will be triggered.
/// You can render video images according to the callback of SDK transfering video data.
///
/// @param handler Custom video render handler
- (void)setCustomVideoRenderHandler:(nullable id<ZegoCustomVideoRenderHandler>)handler;

/// Enables or disables custom video capture.
///
/// It must be set before the engine starts, that is, before calling [startPreview], [startPublishingStream]; and the configuration can be modified after the engine is stopped, that is, after calling [logoutRoom].
/// When the developer starts the custom capture, it can be set to receive notification of the start and stop of the custom capture by calling [setCustomVideoCaptureHandler].
///
/// @param enable enable or disable
/// @param config custom video capture config
- (void)enableCustomVideoCapture:(BOOL)enable config:(nullable ZegoCustomVideoCaptureConfig *)config;

/// Enables or disables custom video capture (for the specified channel).
///
/// It must be set before the engine starts, that is, before calling [startPreview], [startPublishingStream]; and the configuration can be modified after the engine is stopped, that is, after calling [logoutRoom].
/// When the developer starts the custom capture, it can be set to receive notification of the start and stop of the custom capture by calling [setCustomVideoCaptureHandler].
///
/// @param enable enable or disable
/// @param config custom video capture config
/// @param channel publish channel
- (void)enableCustomVideoCapture:(BOOL)enable config:(nullable ZegoCustomVideoCaptureConfig *)config channel:(ZegoPublishChannel)channel;

/// Sets the event callback handler for custom video capture.
///
/// Custom video capture, that is, the developer is responsible for collecting video data and sending the collected video data to SDK for video data encoding and publishing to the ZEGO RTC server. This feature is generally used by developers who use third-party beauty features or record game screen living.
/// When you use the advanced features of ZegoExpressEngine's custom video capture, you need to call this function to set SDK to notify that you can start sending video data to ZegoExpressEngine.
/// When you calls startPreview and startPublishingStream, a callback function that notifies you to start sending video data will be triggered. When you stop preview [stopPreview] and stop publishing stream [stopPublishingStream], it will trigger a callback function that notify that you can stop sending video data.
/// Because when using custom video capture, SDK will no longer start the camera to capture video data. You need to collect video data from video sources by yourself.
/// Custom video capture can be used with custom video rendering.
///
/// @param handler Custom video capture handler
- (void)setCustomVideoCaptureHandler:(nullable id<ZegoCustomVideoCaptureHandler>)handler;

/// Sends the video frames (Texture Data) produced by custom video capture to the SDK.
///
/// This function need to be start called after the [onStart] callback notification and to be stop called call after the [onStop] callback notification.
///
/// @param textureID texture ID
/// @param size Video frame width and height
/// @param timestamp Timestamp of this video frame
- (void)sendCustomVideoCaptureTextureData:(GLuint)textureID size:(CGSize)size timestamp:(CMTime)timestamp;

/// Sends the video frames (Texture Data) produced by custom video capture to the SDK (for the specified channel).
///
/// This function need to be start called after the [onStart] callback notification and to be stop called call after the [onStop] callback notification.
///
/// @param textureID texture ID
/// @param size Video frame width and height
/// @param timestamp Timestamp of this video frame
/// @param channel Publishing stream channel
- (void)sendCustomVideoCaptureTextureData:(GLuint)textureID size:(CGSize)size timestamp:(CMTime)timestamp channel:(ZegoPublishChannel)channel;

/// Sends the video frames (CVPixelBuffer) produced by custom video capture to the SDK.
///
/// This function need to be start called after the [onStart] callback notification and to be stop called call after the [onStop] callback notification.
///
/// @param buffer Video frame data to send to the SDK
/// @param timestamp Timestamp of this video frame
- (void)sendCustomVideoCapturePixelBuffer:(CVPixelBufferRef)buffer timestamp:(CMTime)timestamp;

/// Sends the video frames (CVPixelBuffer) produced by custom video capture to the SDK (for the specified channel).
///
/// This function need to be start called after the [onStart] callback notification and to be stop called call after the [onStop] callback notification.
///
/// @param buffer Video frame data to send to the SDK
/// @param timestamp Timestamp of this video frame
/// @param channel Publishing stream channel
- (void)sendCustomVideoCapturePixelBuffer:(CVPixelBufferRef)buffer timestamp:(CMTime)timestamp channel:(ZegoPublishChannel)channel;

/// Sends the video frames (Encoded Data) produced by custom video capture to the SDK.
///
/// This function need to be start called after the [onStart] callback notification and to be stop called call after the [onStop] callback notification.
///
/// @param data video encoded frame data
/// @param params video encoded frame param
/// @param timestamp video frame reference time, UNIX timestamp.
- (void)sendCustomVideoCaptureEncodedData:(NSData *)data params:(ZegoVideoEncodedFrameParam *)params timestamp:(CMTime)timestamp;

/// Sends the video frames (Encoded Data) produced by custom video capture to the SDK (for the specified channel).
///
/// This function need to be start called after the [onStart] callback notification and to be stop called call after the [onStop] callback notification.
///
/// @param data video frame encoded data
/// @param params video frame param
/// @param timestamp video frame reference time, UNIX timestamp.
/// @param channel Publishing stream channel
- (void)sendCustomVideoCaptureEncodedData:(NSData *)data params:(ZegoVideoEncodedFrameParam *)params timestamp:(CMTime)timestamp channel:(ZegoPublishChannel)channel;

/// Sets the video fill mode of custom video capture.
///
/// @param mode View mode
- (void)setCustomVideoCaptureFillMode:(ZegoViewMode)mode;

/// Sets the video fill mode of custom video capture (for the specified channel).
///
/// @param mode View mode
/// @param channel Publishing stream channel
- (void)setCustomVideoCaptureFillMode:(ZegoViewMode)mode channel:(ZegoPublishChannel)channel;

/// Sets the video flip mode of custom video capture (for the specified channel). This function takes effect only if the custom video buffer type is Texture2D.
///
/// @param mode Flip mode
- (void)setCustomVideoCaptureFlipMode:(ZegoVideoFlipMode)mode;

/// Sets the video flip mode of custom video capture (for the specified channel). This function takes effect only if the custom video buffer type is Texture2D.
///
/// @param mode Flip mode
/// @param channel Publishing stream channel
- (void)setCustomVideoCaptureFlipMode:(ZegoVideoFlipMode)mode channel:(ZegoPublishChannel)channel;

/// Enables or disables custom video processing.
///
/// When developers to open before the custom processing, by calling [setCustomVideoCaptureHandler] can be set up to receive a custom video processing of the video data
/// Precondition： Call [CreateEngine] to initialize the Zego SDK
/// Call timing： must be set before calling [startPreview], [startPublishingStream]; The configuration cannot be changed again until the [logoutRoom] is called, otherwise the call will not take effect
/// Supported version： 2.2.0
///
/// @param enable enable or disable. disable by default
/// @param config custom video processing configuration. If nil is passed, the platform default value is used.
- (void)enableCustomVideoProcessing:(BOOL)enable config:(nullable ZegoCustomVideoProcessConfig *)config;

/// Sets up the event callback handler for custom video processing.
///
/// Set a custom video processing callback to obtain the original video data
/// Precondition：Call [createEngine] to initialize Zego SDK
/// Call timing：Call before [startPreview] and [startPublishingStream], otherwise it may cause too slow time to get video data
/// Supported version：2.2.0
///
/// @param handler Custom video process handler
- (void)setCustomVideoProcessHandler:(nullable id<ZegoCustomVideoProcessHandler>)handler;

/// Send the [CVPixelBuffer] type video data after the custom video processing to the SDK (for the specified channel).
///
/// This interface takes effect when [enableCustomVideoProcessing] is called to enable custom video processing and the bufferType of config is passed in [ZEGO_VIDEO_BUFFER_TYPE_CVPIXELBUFFER]
/// Precondition：Call [createEngine] to initialize Zego SDK
/// Call timing：It must be called in the [onCapturedUnprocessedCVPixelBuffer] callback
/// Supported version：2.2.0
///
/// @param buffer CVPixelBuffer type video frame data to be sent to the SDK
/// @param timestamp Timestamp of this video frame
- (void)sendCustomVideoProcessedCVPixelBuffer:(CVPixelBufferRef)buffer timestamp:(CMTime)timestamp;

/// Send the [CVPixelBuffer] type video data after the custom video processing to the SDK (for the specified channel).
///
/// This interface takes effect when [enableCustomVideoProcessing] is called to enable custom video processing and the bufferType of config is passed in [ZEGO_VIDEO_BUFFER_TYPE_CVPIXELBUFFER]
/// Precondition：Call [createEngine] to initialize Zego SDK
/// Call timing：It must be called in the [onCapturedUnprocessedCVPixelBuffer] callback
/// Supported version：2.2.0
///
/// @param buffer CVPixelBuffer type video frame data to be sent to the SDK
/// @param timestamp Timestamp of this video frame
/// @param channel Publishing stream channel
- (void)sendCustomVideoProcessedCVPixelBuffer:(CVPixelBufferRef)buffer timestamp:(CMTime)timestamp channel:(ZegoPublishChannel)channel;

@end

NS_ASSUME_NONNULL_END
