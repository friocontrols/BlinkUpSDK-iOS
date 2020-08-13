//
//  BUPublicKeyAlgorithm.h
//  BlinkUp
//
//  Created by Brett Park on 2018-01-28.
//  Copyright © 2020 Twilio, Inc. All rights reserved.
//

#ifndef BUPublicKeyAlgorithm_h
#define BUPublicKeyAlgorithm_h

#import <Foundation/Foundation.h>


/**
 Possible options for SSL Pinning Certificate Algorithms

 - BUPublicKeyAlgorithmNone: No Encryption (not a valid option)
 - BUPublicKeyAlgorithmRsa2048: RSA 2048
 - BUPublicKeyAlgorithmRsa4096: RSA 4096
 - BUPublicKeyAlgorithmEcDsaSecp256r1: EC DSA SECP 256 r1
 - BUPublicKeyAlgorithmEcDsaSecp384r1: EC DSA SECP 384 r1
 */
typedef NS_OPTIONS(NSUInteger, BUPublicKeyAlgorithm)
{
    /// No Encryption (not a valid option)
    BUPublicKeyAlgorithmNone = 0,
    /// RSA 2048
    BUPublicKeyAlgorithmRsa2048 = 1 << 0,
    /// RSA 4096
    BUPublicKeyAlgorithmRsa4096 = 1 << 1,
    /// EC DSA SECP 256 r1
    BUPublicKeyAlgorithmEcDsaSecp256r1 = 1 << 2,
    /// EC DSA SECP 384 r1
    BUPublicKeyAlgorithmEcDsaSecp384r1 = 1 << 3
};

#endif
