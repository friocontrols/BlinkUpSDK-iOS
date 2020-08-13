//
//  BUSDK.h
//  BlinkUp
//
//  Created by Brett Park on 2015-10-27.
//  Copyright © 2020 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BUPinningDescription;

/*!
 *  Configure the SDK for use
 *
 *  The application should call one of the `configure` methods during application launch.
 *  The most appropriate location is `application:didFinishLaunchingWithOptions:`
 *  Only a single configure method should be called per launch.
 *  Setting parameters affect the SDK application wide.
 */
NS_ASSUME_NONNULL_BEGIN
@interface BUSDK : NSObject

/*!
 *  @brief Configure the BlinkUp SDK for standard usage
 *
 *  **Note** This method should be called during app initialization
 *      and must be be set before making any other BlinkUp calls
 *
 */
+ (void)configure;

/*!
 *  @brief Configure the BlinkUp SDK to use a Private impCloud host and optional SSL Pinning
 *
 *  If your device is connecting to a Private impCloud, you can set the hostname of
 *  your Private impCloud.
 *
 *  In order to prevent MITM attacks and the use of ssl-proxies, it is strongly recommended
 *  that you configure the pinning descriptions for the host.
 *
 *  **Note** This method should be called during app initialization
 *      and must be be set before making any other BlinkUp calls
 *
 *  @param privateCloudHost Server host to connect to such as `api.electricimp.com`
 *  @param sslPinningDescriptions SSL Pinning Description. Pass in an empty array for no pinning
 */
+ (void)configureWithPrivateCloudHost:(NSString *)privateCloudHost pinningDescriptions:(NSArray<BUPinningDescription *> *) sslPinningDescriptions;

/*!
 *  @brief Configure the BlinkUp SDK to use a Private impCloud host and optional SSL Pinning with additional features.
 *
 *  If your device is connecting to a Private impCloud, you can set the hostname of
 *  your Private impCloud.
 *
 *  In order to prevent MITM attacks and the use of ssl-proxies, it is strongly recommended
 *  that you configure the pinning descriptions for the host.
 *
 *  If you require extra features when using the SDK, you can enable them here
 *  with the feature codes provided by Electric Imp. The feature codes are
 *  specific to your API Key. During initial configuration, it is good practice
 *  to examine the return list to ensure all the features you will change are
 *  enabled.
 *
 *  **Note** This method should be called during app initialization
 *      and must be be set before making any other BlinkUp calls
 *
 *  @param privateCloudHost Server host to connect to such as `api.electricimp.com`
 *  @param sslPinningDescriptions SSL Pinning Description. Pass in an empty array for no pinning
 *  @param featureCodes All of the features codes that should be enabled
 *  @param apiKey       The API Key assigned to you from Electric Imp
 *
 *  @return The list of feature names that were enabled
 */
+ (NSArray <NSString *> *)configureWithPrivateCloudHost:(NSString *)privateCloudHost pinningDescriptions:(NSArray<BUPinningDescription *> *) sslPinningDescriptions featureCodes:(NSArray  <NSString *> *)featureCodes apiKey:(NSString *)apiKey;

/*!
 *  @brief Configure the BlinkUp SDK and enabled extra feature SDK wide
 *
 *  If you require extra features when using the SDK, you can enable them here
 *  with the feature codes provided by Electric Imp. The feature codes are
 *  specific to your API Key. During initial configuration, it is good practice
 *  to examine the return list to ensure all the features you will change are
 *  enabled.
 *
 *  @param featureCodes All of the features codes that should be enabled
 *  @param apiKey       The API Key assigned to you from Electric Imp
 *
 *  @return The list of feature names that were enabled
 */
+ (NSArray <NSString *> *)configureWithFeatureCodes:(NSArray  <NSString *> *)featureCodes apiKey:(NSString *)apiKey;

/*!
 *  @brief Reset the SDK to use defaults. This should only be needed during testing
 */
+ (void)resetToDefaults;

/*!
 *  @brief Check if a feature has been enabled
 *
 *  @param featureName Name of the feature to check
 *
 *  @return `true` if the feature is enabled
 */
+ (BOOL)isFeatureEnabled:(NSString *)featureName;

#pragma mark - Private Cloud Feature

/*!
 *  @brief  The hostname of the Private impCloud
 *
 *  This value is used as the hostname when retrieving plans, tokens and
 *  BlinkUp results. Nil is returned by default, which indicates that
 *  the SDK should use the default Electric Imp URL.
 *
 *  Note: This feature must be be set before making any other BlinkUp calls
 *
 *  @return Nil if not set or the override base URL string
 */
+ (NSString *_Nullable)privateCloudHost;

/*!
 *  @brief  SSL Pinning Descriptions for server communication
 *
 *  When connecting to the server, the API will validate that the anchoring
 *  certificate (the root) has a proper hostname and SPKI data.
 *  The SSL Pinning is done in order to provide an extra layer of security.
 *  If the value is nil, pinning will be turned off.
 *
 *  **Note** This feature must be be set before making any other BlinkUp calls
 *
 *  @return Nil or empty if any cert is allowed, or the value that must match the certificate
 */
+ (NSArray<BUPinningDescription *> *_Nullable) sslPinningDescriptions;

/*!
 *  @brief Allow debug logs to be generated (may contain sensitive information).
 *
 *  Note: This should not be enabled for release builds
 *
 *  @param debugLogging Bool indicating if debugLogging should be enabled
 */
+ (void) setDebugLogging: (BOOL) debugLogging;

/*!
 *  Check if the debug logging is enabled
 *
 *  @return State of debug Logging
 */
+ (BOOL) debugLogging;


@end
NS_ASSUME_NONNULL_END
