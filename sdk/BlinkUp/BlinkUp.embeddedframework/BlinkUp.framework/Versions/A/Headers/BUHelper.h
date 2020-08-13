//
//  BUHelper.h
//  BlinkUp
//
//  Created by Brett Park on 2016-10-13.
//  Copyright © 2020 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Helper methods when performing BlinkUp
 */
@interface BUHelper : NSObject

/**
 @brief During BlinkUp, the rotation of the application and the status bar may become
 out of sync with the device orientation. In order to fix the orientation and status
 bar, this method can be called in an attempt to correct both. It works by quickly 
 presenting an empty view controller with a clear background on the view controller
 passed in. It is then immediately dismissed which causes the presenting view controller
 to be redrawn in the correct orientation. It is important that this may cause the
 presenting view controller's `viewDidAppear` and other methods to be called. This method
 works best if called after `shouldAutorotate` has been set to `true` (if it was altered for
 BlinkUp).

 @param presentingViewController The view that is out of rotation or has the status bar
            in the incorrect orientation
 */
+(void) fixRotationForViewController:(UIViewController *_Nonnull) presentingViewController;



/**
 @brief This method can be used in the view controller, navigation controller, root view controller
 or other container view controllers to determine if BlinkUp should allow or prevent autorotation.
 It is recommended that you override the `shouldAutorotate` function of all view controllers that are in
 charge of rotation when a BlinkUp occurs.

 @return `true` if the interface should rotate, `false` if a flash is occurring
 */
+(BOOL) shouldAutorotate;



/**
 @brief Hardware model of the iOS Device

 @return A String representation of the hardware device
 */
+(nonnull NSString *) hardwareModel;


/**
 @brief Hardware OS of the iOS Device

 @return String representing the OS version
 */
+(nonnull NSString *) hardwareOS;


/**
 @brief Unique identifier for this user / device
 
 Defaults to device's `identifierForVendor`

 @return String with a unique identifier
 */
+(nonnull NSString *) userIdentifier;


/**
 @brief Override the user identifier (can be set to the user's email)

 @param identifier Identifier for the user
 */
+(void) setUserIdentifier:(NSString * _Nonnull) identifier;
@end
