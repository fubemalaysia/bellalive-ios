//
//  ZegoExpressEngine+Utilities.h
//  ZegoExpressEngine
//
//  Copyright © 2019 Zego. All rights reserved.
//

#import "ZegoExpressEngine.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZegoExpressEngine (Utilities)

/// Starts system performance status monitoring. Support setting the listening interval.
///
/// After starting monitoring, you can receive system performance status via [onPerformanceStatusUpdate] callback.
/// [onPerformanceStatusUpdate] callback notification period is the value set by the parameter.
///
/// @param millisecond Monitoring time period of the audio spectrum, in milliseconds, has a value range of [1000, 10000]. Default is 2000 ms.
- (void)startPerformanceMonitor:(unsigned int)millisecond;

/// Stops system performance status monitoring.
///
/// After the monitoring is stopped, the callback of the system performance status will be stopped.
- (void)stopPerformanceMonitor;

/// start network probe.
///
/// Some local network problems may cause audio and video calls to fail. Using this function to probe the network protocols, assist in locating and solving related network problems.
/// The SDK internally detects http, tcp, and udp in sequence. If the probe fails in the middle, the subsequent detection will not continue. Therefore, when reading the values ​​in the probe result, please pay attention to check if the value is nil.
/// The SDK will not perform multiple network probe at the same time, that is, if the network probe is in progress, the SDK will not work if you call this method repeatedly.
/// Network probe may take a long time. Developers can call [stopNetworkProbe] to stop network probe as needed.
///
/// @param config network probe config
/// @param callback Network probe result callback.
- (void)startNetworkProbe:(ZegoNetworkProbeConfig *)config callback:(nullable ZegoNetworkProbeResultCallback)callback;

/// stop network probe.
- (void)stopNetworkProbe;

/// Start network speed test.
///
/// This function cannot be called together with [startPublishingStream], otherwise the network probe will automatically stop.
/// Developers can listen to the [onNetworkSpeedTestQualityUpdate] callback to get the speed test result, which will be called back every 3 seconds.
/// If an error occurs during the speed measurement process, [onNetworkSpeedTestError] callback will be triggered.
/// If this function is repeatedly called multiple times, the last invoke's configuration will be used.
///
/// @param config Network speed test configuration.
- (void)startNetworkSpeedTest:(ZegoNetworkSpeedTestConfig *)config;

/// Stop network speed test.
///
/// After stopping the speed test, [onNetworkSpeedTestQualityUpdate] will no longer call back.
- (void)stopNetworkSpeedTest;

@end

NS_ASSUME_NONNULL_END
