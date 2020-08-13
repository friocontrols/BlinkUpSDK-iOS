Using the basic BlinkUp process is the quickest way to get your BlinkUp SDK-enabled app up and running. A standard interface and flow is provided to the user, and the complexity of your code is minimized. Some basic interface elements, such as [textual content](Text-Customization.html), can be altered, but the overall UI style is fixed.

The basic BlinkUp interface does not provide access to the more advanced features of the BlinkUp process, such as Ethernet networking support, and the ability to enter static network configurations or proxy connections. To make use of these features, you will need to use the SDK’s [customization system](Custom-BlinkUp.html) to integrate BlinkUp into your own UI.

## BUBasicController

The [BUBasicController](BUBasicController) class is used to simplify the implemention of the BlinkUp process. It is a wrapper around the individual components that are needed for BlinkUp. More information about the components and the workflow is provided on the [main documentation](../index.html) page. A working example can be found in the *ExampleApp* project included with the SDK.

The following code shows how you can implement the basic BlinkUp UI using [BUBasicController](BUBasicController).

```
// 1. Import the header for BlinkUp at the top of your header file

#import <BlinkUp/BlinkUp.h>

// 2. Insert the API key you obtained from Electric Imp

NSString *apiKey = @"YOUR_API_KEY_FROM_ELECTRIC_IMP";

// 3. Create a new instance of a BUBasicController using your API key

BUBasicController *blinkUpController = [[BUBasicController alloc] initWithApiKey:apiKey];

// 4. Begin the BlinkUp process

[blinkUpController presentInterfaceAnimated:YES
  resignActive: ^(BOOL willRespond, BOOL userDidCancel, NSError *error) {
  //  5. At this point your interface is back in control
  //  6. Be sure to check for an error and inform the user
  //  7. If userDidCancel is true, no action was performed.
  //  8. If willRespond is true, the devicePollingDidComplete block will be called at some point in the future,
  //     until then you might want to show a "waiting for device" screen.
}
  devicePollingDidComplete: ^(BUDeviceInfo *deviceInfo, BOOL timedOut, NSError *error) {
  //  9. At this point the BlinkUp process is complete
  // 10. Be sure to check for an error and inform the user
  // 11. If timedOut is true, the device did not connect to the server withing the
  //     pollTimeout period
  // 12. If the device did connect, the information will be in the deviceInfo object
}];
```
