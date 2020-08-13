Almost all of the text that is displayed to the user during the BlinkUp process can be customized, by adding your own `.strings` files. There are two files which you can add to your project: `BlinkUpSDK.strings` and `BlinkUpError.strings`. It is recommended that you copy the files from `BlinkUpSDK/BlinkUp/Resources` into your project as a starting template. The various screens of the controller are shown below, with the name of the customizable strings that can be set as properties. If you do not want to customize a specific string, you can comment it out and the default BlinkUp string will be used.

The `.strings` files may also be localized. If your are unfamiliar with localization for iOS, please read Apple’s developer documentation. Each BlinkUp interface will first look in your app’s resources for strings in the appropriate table (`BlinkUpSDK` or `BlinkUpErrors`) and will attempt to use that value. This is the same behaviour that occurs when calling `NSLocalizedStringFromTable` in iOS. If a string is not found, the BlinkUp interface will choose the most appropriate localized string, defaulting to English if no localization is found.

### Localization Selection
* If your app provides a non-localized version of a string, it will be used in all cases.
* If your app provides a localized version of a string in the same localization as the user, the localized string will be used.
* If your app provides a localized version of a string which is not in the same localization as the user, it will fall back to a BlinkUp localized version if it exists, otherwise a default English-language BlinkUp version of the text will be used.

## Dynamic text customization
If your customized text is static (it does not change between launches of the app), you should alter the `.strings` files as indicated above. If, however, you want the text to change in response to dynamic events in your application, for example to reflect a user name or location, you can add dynamic text by using string format parameters in your localized `.strings` file. The string parameter arrays are located in the [BUNetworkSelectController stringParams](BUNetworkSelectController), [BUFlashController stringParams](BUFlashController) or [BUErrorStringParameters](BUErrorStringParameters).

For example, if you wish to add the username to the global footer text, you could change your English `BlinkUpSDK.strings` to contain:

`"GlobalFooter" = "%@ is logged in";`

and, for example, a French localized string file to contain:

`"GlobalFooter" = "nom d'utilisateur %@";`

Within the application, you then would set the string parameter array for the global footer:

```
// blinkController is a instance of BUBasicController
// username is an NSString representing the users username

blinkController.networkSelectController.stringParams.globalFooter = @[username];
```

It is also possible to use multiple parameters (with a max of 10), and to change the order in which they appear. For example, if you wanted a dynamic PreflashText:

`"PreflashText" = "Get ready to BlinkUp device number %@ of %@!";`

your code would look like:

`blinkController.networkSelectController.stringParams.preflashText = @[@"3", @"5"];`

In a different localization, if the order of the 3 and 5 should be different, you can identify a non-default paramater ordering like this:

`"PreflashText" = "This should be 5 %2$@ and this should be 3 %1$@""`

# The Main BlinkUp Screen

<div style="text-align:center"><img src="InstallImages/main_screen.jpg" /></div>

The `GlobalFooter` text is read in from the localization file. The `globalFooterFormatParameter` property of the [BUBasicController](BUBasicController) can be set in order to allow dynamic addition to the text in code. The `GlobalFooter` string should be formatted in the same manner as a call to `stringWithformat`. It is recomended that you use the footer to show the state of the app for the user (such as the device they are about to configure, or their username). An example string is `"GlobalFooter" = "Logged in:%@";`

# The WiFi Screen

<div style="text-align:center"><img src="InstallImages/wifi_screen.jpg" /></div>

# The WPS Screen

<div style="text-align:center"><img src="InstallImages/wps_screen.jpg" /></div>

# The Pre-Flash Interstitial Screen

The interstitial image should be 280x380 pixels @1x, 560x760 pixels @2x (retina), and 840x1140 pixels @3x (iPhone 6 and above).

<div style="text-align:center"><img src="InstallImages/interstitial_screen.jpg" /></div>

# The Flash Screen

<div style="text-align:center"><img src="InstallImages/flash_screen.jpg" /></div>
