To use the BlinkUp SDK, copy `BlinkUp.embeddedframework` to your project directory, drag the framework into Xcode’s organizer window, and add the `-ObjC` linker flag.

## Objective-C Framework Installation

1. Unzip `BlinkUpSDK.zip`.
2. Drag `BlinkUp.embeddedframework` from the `BlinkUpSDK/BlinkUp` directory to the project organizer in Xcode (Select `Copy items into destination group's folder`).
3. In the build settings for your project (or application target) add `-ObjC` to the `other linker flags` if it does not already exist.
4. Add the following system frameworks to your project if they aren’t linked already:

	- AVFoundation.framework
	- CoreGraphics.framework
  - Metal.framework
	- OpenGLES.framework
	- QuartzCore.framework
	- Security.Framework
	- SystemConfiguration.framework
 
## Swift Framework Installation

1. Unzip `BlinkUpSDK.zip`.
2. Drag `BlinkUp.embeddedframework` from the `BlinkUpSDK/BlinkUp` directory to the project organizer in Xcode (Select `Copy items into destination group's folder`).
3. In the build settings for your project (or application target) add `-ObjC` to the `other linker flags` if it does not already exist.
4. Copy the folder `BlinkUpSDK/BlinkUp/BlinkUpSwiftExtensions` into your project. This is optional and provides a few Swift wrapper functions for methods with many block parameters.
5. Add `import BlinkUp` to the Swift file you are implementing BlinkUp in.

### Swift Notes

The Swift BlinkUp extensions are optional, but provide enumeration based closures rather than the more verbose Objectice-C blocks. The extension functions are not found in this documentation. It is recommended to review the `.swift` files in the BlinkUpSwiftExtensions folder to view the additional functions provided.

## SDK Configuration

The SDK contains a few global configuration options. These should be configured in the `AppDelegate` `application:didFinishLaunchingWithOptions` method.

### Objective-C

```
//At the top of your application delegate import the BlinkUp Framework
#import <BlinkUp/BlinkUp.h>

// In the application:didFinishLaunchingWithOptions method insert
// If you are using a private cloud host or other SDK features 
// call the appropriate configure method
[BUSDK configure];
```

### Swift

```
//At the top of your application delegate import the BlinkUp Framework
import BlinkUp

// In the application:didFinishLaunchingWithOptions method insert
// If you are using a private cloud host or other SDK features 
// call the appropriate configure method
BUSDK.configure()
```

## Next Steps

For easy setup and a standardized interface, please read the [Basic BlinkUp](Basic-BlinkUp.html) guide.
To implement a custom user experience or more complex behaviours, please read the [Custom BlinkUp](Custom-BlinkUp.html) guide.

To accompany each of these guides, there are custom application templates (one for basic and one for custom) included in the SDK as examples of implementation. 
