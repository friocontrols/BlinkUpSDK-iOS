//
//  BUPinningSPKIData.h
//  BlinkUp
//
//  Created by Brett Park on 2018-01-28.
//  Copyright © 2020 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BUPublicKeyAlgorithm.h"

/**
 Information about the SPKI data for pinning
 
 Some providers use a Hex format while others use a Base64 encoded string. An initialization method exists for both
 */
@interface BUPinningSPKIData : NSObject

/**
 @brief Create the SPKI pin data from a Hex string
 
 @param pin The pin in Hex format
 @param pubKeyAlg An array of BUPublicKeyAlgorithm values
 @return The SPKI pin data
 */
- (instancetype _Nonnull )initWithHexString:(NSString *_Nonnull) pin algorithms: (BUPublicKeyAlgorithm) pubKeyAlg;

/**
 @brief Create the SPKI pin data from a Base64 string
 
 @param pin The pin in Base64 format
 @param pubKeyAlg An array of BUPublicKeyAlgorithm values
 @return The SPKI pin data
 */
- (instancetype _Nonnull )initWithBase64:(NSString *_Nonnull) pin algorithms: (BUPublicKeyAlgorithm) pubKeyAlg;

/**
 @brief The pin in either Base64 or Hex string format
 */
@property (nonnull, nonatomic, strong) NSString * pin;

/**
 @brief Bool indicating if the pin is in Base64 format
 */
@property (assign) BOOL isBase64;

/**
 @brief Bool indicating if the pin is in Hex format
 */
@property (assign) BOOL isHexString;

/**
 @brief The supported Public Key Algorithm(s) for the certificate
 */
@property (assign) BUPublicKeyAlgorithm supportedAlgorithms;

/**
 @brief The pin as a data object (translate both Base64 and Hex)

 @return The pin as an NSData instance
 */
-(NSData *_Nonnull) pinAsData;
@end
