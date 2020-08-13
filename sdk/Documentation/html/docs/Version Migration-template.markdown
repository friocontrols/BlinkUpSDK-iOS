# Migration Guide #

This document can be used to help upgrade your project from a previous version of BlinkUp.

## Upgrading to 20.0.0 ##

- The combination of XCode 11 and iOS 13 resulted in a change to the default view controller presentation logic by Apple. When compiling with XCode 11, BlinkUp SDK version 20.0.0 or higher must be used. If you have not yet upgraded to XCode 11, SDK 19.9.0 (now deprecated) should be used until you can make the upgrade.

## Upgrading 19.8.1 to 19.8.2 ##

- The class *BUSDKFeatures* has been renamed to *BUSDK*
- The class methods that were available in *BUSDKFeatures* can now be set using one of the [BUSDK configure]` methods.

## Upgrading 19.7.0 to 19.7.1 ##

- The property *anchorCertCN* in *BUSDKFeatures* and been changed to return arrays and has been renamed *anchorCertCNs*
- The class method `[BUSDKFeatures setPrivateCloudHost:anchorCertCN:]` has been renamed `[BUSDKFeatures setPrivateCloudHost:anchorCertCNs:]` and now accepts an array of anchor certificates common names.

## Upgrading 19.4.0 to 19.6.0 ##

- Ensure that your application has “Requires full screen” set to true for the application Target -> General setting.
- The view controller that presents the BlinkUp, the RootViewController, and any container controllers (such as *UINavigationController*, *UISplitViewController*, etc) should implement the *shouldAutorotate* method and return the value acquired from `[BUHelper shouldAutorotate]`. If the interface is rotated while the BlinkUp interface is presented the status bar and or presenting interface may become out of sync with the device orientation. To counteract this issue, the presenting view controller can call the *BUHelper* method *fixRotationForViewController:* after the flash process has completed.
- During the flash process the status bar may or may not appear. If the application’s info.plist has “View controller-based status bar appearance” set to `YES`, the status bar will not be visible, otherwise it will use the preference of your application.
- Remove references to `[BUFlashController hideStatusBarAfterFlash]`

## Upgrading 19.2.0 to 19.4.0 ##

- If you previously used the customized version of the SDK, please consult with support for the new documentation on using custom SDK features.

## Upgrading 19.1.1 to 19.2.0 ##

- Change any references of *BlinkUpErrorMIMETypeInvalid* to *BlinkUpErrorServerResponseFailed*
- Update the BlinkUp.bundle in your application by overwriting the old bundle in your app
- If you have customized the error messages using a .strings file, update any references of *BadMimeType* to *ServerRespondedWithError*

## Upgrading 18.2 to 19.0 ##

Version 19 of the SDK is quite different from 18. The API is now no longer delegate-based but block-based. The old BlinkUpController class has been broken into several smaller operation-specific classes. Developers who were previously using the *standard* BlinkUp method can now use the *basic* BlinkUp method via the [BUBasicController](BUBasicController). If you use the advanced BlinkUp methods, you will have to invest more time in learning about the new workflow.

It is also important to note that errors will no longer be automatically propagated to the user interface via an alert view. It is now your responsibility to catch any errors and inform the user of the issue. The error messages can be customized in the same way as SDK 18 via [`.strings`](Text-Customization.html) properties.

## Upgrading 18.0 to 18.2 ##

### Error codes ###

Error codes were changed and preference was given to enumerations in `BUErrors.h`. The error domain has all errors changed to the value provided in the string *BlinkUpErrorDomain*.

The following codes have been changed:

* 1387915570 -> BlinkUpErrorNetworkError
* 1465029864 -> BlinkUpErrorMIMETypeInvalid
* 16913060 -> BlinkUpErrorStatusUpdateTimedOut
* 263060095 -> This error has been removed
* 263760095 -> BlinkUpErrorPasswordAlreadySaved
* 3359695 -> BlinkUpErrorSetupTokenInvalid
* 3359696 -> BlinkUpErrorPlanIDInvalid
* 3359697 -> This error has been removed
* 3359698 -> BlinkUpErrorFlashPacketInvalid
* 3447470 -> BlinkUpErrorSetupTokenRetrievalFailed
* 3447471 -> BlinkUpErrorPlanIDRetrievalFailed
* 648572891 -> BlinkUpErrorObjCFlagNotSet
* 774633765 -> BlinkUpErrorPasswordSaveFailed
* 827992382 -> BlinkUpErrorBundleNotCopied
* 854070108 -> BlinkUpErrorSetupTokenInvalid
* 859744 -> BlinkUpErrorSetupTokenInvalid
* 859745 -> BlinkUpErrorPlanIDInvalid
* 959744 -> BlinkUpErrorSetupTokenInvalid
* 959745 -> BlinkUpErrorPlanIDInvalid
* 859747 -> BlinkUpErrorSSIDNotSet

### BlinkUpController initialization

The *init* method has been replaced by the *initWithAPI* method.

### *presentWifiSettingsWithDelegate:APIKey:animated:* ###

* Modified to *presentStandardInterfaceAnimated:*
* The *APIKey* property has been removed and should be set when the *BlinkUpController* is initialized
* The *Delegate* property has been removed and should be set when the *BlinkUpController* is initialized

### *acquireSetupTokenWithAPIKey:completionHandler:* ###

The *APIKey* property has been removed and is not set when the *BlinkUpController* is initialized

### *presentFlashWithDelegate:wifiConfig:APIKey:animated:* ###

* Modified to *presentFlashWithWifiConfig:animated:*
* The *APIKey* property has been removed and should be set when the BlinkUpController is initialized
* The *Delegate* property has been removed and should be set when the BlinkUpController is initialized

### *presentFlashWithDelegate:wpsConfig:APIKey:animated:* ###

* Modified to *presentFlashWithWpsConfig:animated:*
* The *APIKey* property has been removed and should be set when the *BlinkUpController* is initialized
* The *Delegate* property has been removed and should be set when the *BlinkUpController* is initialized

### *presentClearDeviceFlashWithDelegate:animated:* ###

* Modified to *presentClearDeviceFlashAnimated:*
* The *Delegate* property has been removed and should be set when the *BlinkUpController* is initialized

## Upgrading from 17.5.x to 18.0 ##

### To Convert to the embedded framework ###

* Remove `BlinkUp.framework` from your project
* Copy `BlinkUp.embeddedframework` into your project. This will copy the framework and the resources bundle into your project
* In your project’s build settings (or application target) add `-ObjC` to `other linker flags` if it does not already exist

### Localization ###

If you are using custom text, it should be moved from inside your application into a file named `BlinkUpSDK.strings`. The name of the string to customize will be the name of the property that you used previously, however, you will have to capitalize the first character.

#### String parameters ####

Dynamic strings can be added to your custom text at runtime by using string formatting. Please see [Text Customization](Text-Customization.html) fore more information.

### Method removal *presentWifi:planId:* ###

This method was removed. If you previously used it, please set the Plan ID via the *planId* property of the BlinkUpController before calling the *present...* method:

```
- (NSError *)presentWifiSettingsWithDelegate:(NSObject <BlinkUpDelegate> *)delegate
                                    APIKey:(NSString *)apiKey
                                    planId:(NSString *)planId
                                animated:(BOOL)animated;
```

### Removal of Deprecated methods ###

The following methods and properties were phased out and have been discontinued. Please update to the newer methods and properties.

```
// A convenience method to resend the most recent BlinkUp.  Does nothing if no recent flash
// This method has lots of ambiguity built in (please remove it from your UI flow)
//  and instead present the standard UI again.

- (void)resendLastBlinkUp __deprecated;


//This method has moved to the BlinkUpWifiSettings class

+ (NSString *) currentWifiSSID __deprecated;

// The property name was misspelled. Please use the new property interstitialImage

@property (nonatomic, strong) UIImage *interstialImage __deprecated;

//This method has been replaced with presentFlashWithDelegate:wifiConfig:APIKey:animated:(BOOL)animated;

- (NSError *)presentFlashWithDelegate:(NSObject <BlinkUpDelegate> *)delegate
            SSID:(NSString *)ssid
            password:(NSString *)password
            APIKey:(NSString *)apiKey
            animated:(BOOL)animated __deprecated;

//This method has been replaced with presentFlashWithDelegate:wpsConfig:APIKey:animated:(BOOL)animated;

- (NSError *)presentFlashWithDelegate:(NSObject <BlinkUpDelegate> *)delegate
            WPSPin:(NSString *)pin
            APIKey:(NSString *)apiKey
            animated:(BOOL)animated __deprecated;
```