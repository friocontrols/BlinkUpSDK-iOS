//
//  BUDHCPAddressing.h
//  BlinkUp
//
//  Created by Brett Park on 2016-05-24.
//  Copyright © 2020 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BlinkUp/BlinkUp.h>

/*!
 *  Informs the imp to use DHCP addresses
 *
 *  There are currently no properties to set for this class
 */
@interface BUDHCPAddressing : BUNetworkAddressing

/**
 @brief Use DHCP to acquire IP information

 @return Initialized object
 */
- (instancetype)init;
@end


