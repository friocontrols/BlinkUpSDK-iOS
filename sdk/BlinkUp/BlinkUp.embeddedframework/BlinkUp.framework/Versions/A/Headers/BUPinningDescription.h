//
//  BUPinningDescription.h
//  BlinkUp
//
//  Created by Brett Park on 2018-01-28.
//  Copyright © 2020 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BUPinningSPKIData;

/**
 @brief The pinning description describes valid SPKI data for a hostname and its subdomains.
 
 Ensure to configure the pins after initialization.
 */
NS_ASSUME_NONNULL_BEGIN
@interface BUPinningDescription : NSObject


/**
 @brief A pinning description for a host

 After initialization the SSL pins should be manually set
 
 @param hostname Hostname of the server certificate
 @return Pinning Description without pins
 */
-(instancetype) initWithHostname:(NSString *) hostname;

/**
 @brief **Do not use**

 @return Not Valid
 */
-(instancetype) init NS_UNAVAILABLE;

/**
 @brief The valid pins for the host
 */
@property (nonatomic,readwrite,strong) NSArray<BUPinningSPKIData *> * pins;

/**
 @brief The hostname of the server you are connecting to
 */
@property (nonatomic,readwrite,strong) NSString * hostname;

/**
 @brief Any subdomains you also want the pin to apply to. A "*" can be used as a wildcard
 */
@property (nonatomic,readwrite,strong) NSArray<NSString *> * subdomains;

/**
 @brief The default pinning descriptions for electricimp.com

 @return The default pinnings to use
 */
+(NSArray<BUPinningDescription *> *) electricImpDefaults;
@end
NS_ASSUME_NONNULL_END
