### iOS SDK v20.0.1 ###

- Change: Electric Imp is now part of Twilio.

### iOS SDK v20.0.0 ###

- **IMPORTANT** Change: Built with Xcode 11
    - **Will not work with Xcode 10** during an archive unless bitcode is turned off
- Change: BlinkUp is forced to display full screen in iOS 13
- Change: *BUNetworkManager.currentWifiSSID()* will return `nil` instead of `Wi-Fi` on iOS 13
- Feature: Support for Dark Mode in *BUBasicController*
- Bugfix: Fixed non-active *BUConfigId* when using *BUBasicController* on slow network connections

### iOS SDK v19.9.0 ###

- Change: The delay after BlinkUp completion has been reduced from approximately 1 seconds to 50ms.
- Change: Underlying endpoints have moved to V5

### iOS SDK v19.8.2 ###

- Change: *BUSDK.configure()* should now be called in the Application Delegate
- Feature: Private cloud host and SSL pinning can now be set via the SDK without needing a feature code (via *BUSDK.configure()* parameters).

### iOS SDK v19.8.1 ###

- Bufix: App may crash on rare occasions with an array out of bounds error

### iOS SDK v19.8.0 ###

- **IMPORTANT** 19.8.0 is a required updated. Older versions will not be able to connect to the impCloud.
- Change: Added support for additional SSL certificates
- Change: Improved the reliability of BlinkUp
- Bugfix: Connection failures would occur when root certificates where manually trusted

### iOS SDK v19.7.0 ###

- Bugfix: Improved the reliability of BlinkUp on iOS 10 and iOS 11 (prevent short BlinkUp events)
- Change: Examples programs updated to XCode 9 and Swift 4

### iOS SDK v19.6.0 ###

- **IMPORTANT** Rotating an iOS device during BlinkUp can reduce the odds of success. It is strongly recommended that you ensure that the application has "Requires full screen" set to `true` for the application Target -> General setting. The view controller that presents BlinkUp should also disable autorotation on its own interface during the BlinkUp process by returning `false` from the *shouldAutorotate* method.
- Bugfix: Fixed an issue where BlinkUp flash may not be presented in iOS 10
- Bugfix: Improved the reliability of BlinkUp on iOS 9.3.x and iOS 10
- Feature: Metal is now used instead of OpenGL on eligible devices
- Removal: B*UFlashController.hideStatusBarAfterFlash* is no longer used. The status bar will be updated by the OS based on the *prefersStatusBarHidden* method of your view controller

### iOS SDK v19.5.1 ###

- Bugfix: Remove warnings about "...pcm: No such file or directory"

### iOS SDK v19.5.0 ###

- Feature: Allow static network addressing for capable impOS
- Feature: Allow network proxy for capable impOS
- Feature: Allow programmatic SDK version retrieval using *BlinkUpVersionString* and/or *BlinkUpVersionNumber*

### iOS SDK v19.4.0b1 ###

- Change: If you had been using the customized version of the SDK, please consult the migration guide

### iOS SDK v19.3.1 ###

- Bugfix: The keyboard will be dismissed when transition to the BlinkUp flash
- Change: Change spelling of "Response" to "Response" in swift helper files

### iOS SDK v19.3.0 ###

- Change: Interstitial and Pre-Flash Countdown can now be shown in landscape
- Bugfix: Fix crash when showing Notification Center during BlinkUp
- Bugfix: Network window may be visible after flash on iOS 9.1 devices

### iOS SDK v19.2.1 ###

- Bugfix: Fix Xcode 7 warning when finding Dsym
- Bugfix: Force Bitcode to enabled
- Bugfix: Fix issue with Network Selection window being displayed several times

### iOS SDK v19.2.0 ###

- Note: It is recommended to set "Requires full screen" in your applications "Deployment Info"
- Feature: Enable Bitcode
- Change: Remove support for iOS 5
- Bugfix: Ensure the screen does not go idle during BlinkUp
- Bugfix: Update BlinkUp.bundle to new iTunes Store rules
- Change: Error BlinkUpErrorMIMETypeInvalid changed to BlinkUpErrorServerResponseFailed
- Change: .Strings value for `BadMimeType` changed to `ServerRepondedWithError`

### iOS SDK v19.1.1 ###

- Feature: Added disableAudioSessionChange property to the flash controller
- Feature: The BlinkUp audio is now mixed with existing audio

### iOS SDK v19.1.0 ###

- Feature: Enhanced Swift support in header files (non-null, nullable)
- Feature: Swift extensions for enumeration based closure parameters

### iOS SDK v19.0.0 ###

- Change: Large changes to the API to be block/closure based
- Feature: New flash screen

### iOS SDK v18.2.1 ###

- Bugfix: BlinkUp works correct when accessibility option color invert it turned on.
- Feature: Allow screen brightness to be changed for flashing.
- Feature: Improved support for iPhone 6/6+
- Change: Default screen brightness during flash set to 0.8
- Bugfix: Allow UTF8 characters in SSID and Password
- Change: Additional API endpoint security

### iOS SDK v18.2.0 ###

- Feature: The SDK can be used for configuring a device using an external (non-BlinkUp) method
- Feature: Allow settings of *preflashcountdown* from 3-10 seconds
- Change: Changed Error codes and domain. Please consult the [Version Migration Document](Version-Migration.html)
- Bugfix: Fix issue that may cause app to crash if flash is interrupted
- Bugfix: Fix issue where app may crash if visible view controller is retrieved immediately after flash

### iOS SDK v18.1.0 ###

- Feature: Allow settings of *preflashcountdown* from 3-5 seconds

### iOS SDK v18.0.2 ###

- Feature: Allow user to view wifi password while entering it
- Bug Fix: Fixed issue when using -all_load

### iOS SDK v18.0.1 ###

- Feature: 64-bit support

### iOS SDK v18.0 ###

- Feature: Support for localization / customization of BlinkUp text through .string files (please read the [Text Customization document](Text-Customization.html)
- Feature: A new property called *stringParams* on BlinkUpController that allows for dynamic addition to formatted strings in localized .string files
- Feature: [Version Migration](Version-Migration.html) guide for helping to upgrade between versions
- Change: Moved textual customization to localization files
- Change: Changed to an embedded framework from a standard framework
- Change: Removed deprecated functions

### iOS SDK v17.5.2 ###

- Bug Fix: Increased reliability of BlinkUp on iPhone 4 with iOS 7

### iOS SDK v17.5.1 ###

- Bug Fix: *tintColor* property of the BlinkUp is now set based on the front-most view shown before BlinkUp
- Bug Fix: status bar will now appear on the BlinkUp screen if the *hideStatusBar* property is set to `false` (default)

### iOS SDK v17.5 ###

- Feature: Added an *agentUrlTimeout* property to control timeout when retrieving the agent URL
- Change: *blinkUp:statusVerfied:agentUrl:impeeId:error* will no longer be called continuously with nil values when retrieving the agent URL

### iOS SDK v17.4.1 ###

- Feature: Added FAQ to address many common questions
- Feature: Added the ability to manually close BlinkUp in app failure cases
- Change: Built with XCode 5 and iOS 7
- Bug Fix: Resolved issue of brightness occasionally changing during BlinkUp
- Bug Fix: Resolved an issue where non-BlinkUp screens appeared frozen

### iOS SDK v17.4 ###

- Feature: The build should be iOS 7 compatible (based on preview 6)
- Feature: Added a property to set the button text on the interstitial page
- Change: Deprecated *resendLastBlinkUp* method
- Change: Changed location and size of the global footer text property
- Bug Fix: When using advanced mode in landscape, text would appear off screen
- Bug Fix: iOS 7 text alignment changes for text in table cells
- Bug Fix: Preflash text changes would persist between the creation of multiple BlinkUpController instances

### iOS SDK v17.3 ###

- Feature: Added a property for the desired status bar state
- Feature: Added the ability to customize the ‘cancel’ button on the presentation page
- Feature: Added a delegate method that is called when the BlinkUp exits via the cancel button
- Feature: Added a property for additional customization text at the bottom of each view
- Bug Fix: Minor bug fixes

### iOS SDK v17.2 ###

- Feature: Added parameter to BlinkUp delegate method to return *impeeId*

### iOS SDK v17.1.2 ###

- Bug Fix: 17.1.1 was released with a constant *planId* causing BlinkUp failure

### iOS SDK v17.1.1 ###

- Bug Fix: BlinkUp would fail occasionally

### iOS SDK v17.1 ###

- Moved *currentWifi* settings method from *BlinkUpController* to *BUNetworkManager* class
- Introduced three new classes for network configuration managements:
	- *BUNetworkManager* - used to retrieve network configuration data
	- *BUWPSConfig* - used for WPS configurations
	- *BUWifiConfig* - used for wifi configurations and saving ssid/password pairs
- Minor user interaction changes for standard BlinkUp process
- Deprecated two methods used for advanced UI flashing
- Allowed the *planId* property to be set for advanced customization

### iOS SDK v17 ###

- Fixed bug using advanced custom UI (imps would not BlinkUp)

### iOS SDK v16 ###

- Fixed spelling issue of *interstitialImage* property
- *blinkup:keyValidated:error* now called on both successful and unsuccessful key validation
- Added class method *currentWifiSSID* which returns the WiFi network the iOS device is connected to

### iOS SDK v15 ###

- New low-level API to enable custom skinned BlinkUp apps.

### iOS SDK v14 ###

- Refactor of *BlinkUpControllerDelegate* methods
- Fix memory leak
- Fix crash when interrupting BlinkUp
- Stability bug fixes

### iOS SDK v13 ###

- UI tweaks
- UI bug fixes

### iOS SDK v12 ###

- Added option to show an interstitial view before BlinkUp
- Tweaking brightness settings

### iOS SDK v11 ###

- Added properties to allow customization of most text in the UI

### iOS SDK v10 ###

- Fixed UI regression bug with SDK v9

### iOS SDK v9 ###

- Better support for weak or high latency internet connections:
	- Improved error handling
	- Longer timeouts

### iOS SDK v8 ###

- Fixed crashing bugs related to saving passwords

### iOS SDK v7 ###

- API enhancements
	- Support for canceling verification polling

### iOS SDK v6 ###

- API enhancements
	- support for resending and clearing personal data

### iOS SDK v5 ###

- API, delegate changes:
	- slight refactor of delegate callbacks
	- expose Plan ID
- Improved error handling

### iOS SDK v4 ###

- API, delegate changes:
	- Agent URL support
- iPad support

### iOS SDK v3 ###

- Initial Release
