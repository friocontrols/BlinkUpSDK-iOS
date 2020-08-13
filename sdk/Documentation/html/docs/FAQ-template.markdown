* [What is the difference between basic and custom BlinkUp?](#1)
* [How does BlinkUp actually work?](#3)
* [Why can’t I see logs for a device configured using the SDK?](#6)
* [Why does it take so long to get an agent URL?](#5)
* [What is a Plan ID?](#7)
* [What is a Device ID?](#10)
* [Why does the agent URL keep changing?](#8)
* [What if I just want the same agent URL for this device, no matter what?](#9)
* [How do I make sure the same user always gets the same agent URL for a device, across multiple BlinkUps?](#11)
* [How do I set the planId?](#12)

--------------------------------------------------------
<p id="1">&nbsp;</p>
## What is the difference between basic and custom BlinkUp?

The [basic Blinkup](Basic-BlinkUp.html) allows the SDK to handle the entire BlinkUp process. It presents a simple UI which will allow the user to select which network they wish to connect to then transfer that choice to the device. You have the option to adjust much of the text throughout the process via the [`.strings` file](Text-Customization.html) included with the SDK. The *ExampleApp* project template shows the basic BlinkUp in operation.

If you feel you want more control over the look and feel of the BlinkUp process, you can do a [custom Blinkup](Custom-BlinkUp.html) by using the individual BlinkUp components themselves. More information on this process can be found in the *ExampleAppCustomUI* project template.

--------------------------------------------------------
<p id="3">&nbsp;</p>
## How does BlinkUp actually work?

These are the logical steps to perform a BlinkUp:

1. Retrieve network information from the user.
2. Gather an Enrolment Token (and Plan ID if not already held by the app) from the impCloud&trade;.
3. Transmit the network information, Enrolment Token and Plan ID to the device by flashing the screen.
4. The device receives the information and tries to connect first to the wireless network and then to the impCloud.
5. The device sends the Enrolment Token to the impCloud.
6. The SDK polls the impCloud to see if the device been authorized to access impCloud services.

--------------------------------------------------------
<p id="6">&nbsp;</p>
## Why can’t I see logs for a device configured using the SDK?

When a device is configured using the SDK, it becomes associated with your production account rather than your developer account. This is why you are not able to see its logs in the IDE, which only shows development devices.

There are two ways to view your logs during production testing:

1. (Best Option) Handle logging internally by sending HTTP messages from the agent, rather than using the impOS API method [server.log()](https://electricimp.com/docs/api/server/log/).

2. If you are still prototyping your device, use this temporary workaround: your developer account has a Plan ID associated with it. If you set the Plan ID in your app to be the same as the one associated with your developer account, the device will show up in the IDE. The Plan ID for your developer account can be obtained by emailing [support@electricimp.com](mailto:support@electricimp.com) and requesting it. In your app, set the Plan ID when initializing the [BUBasicController](BUBasicController) or [BUConfigId](BUConfigId) objects. **Be sure to remove your developer account Plan ID before releasing the application, otherwise users’ BlinkUp attempts will fail.**

--------------------------------------------------------
<p id="5">&nbsp;</p>
## Why does it take so long to get an agent URL?

A URL is returned to the app so that it can access the configured device’s agent at that URL. If an issue occurs during the BlinkUp process, the agent URL may never be returned. In this case, the app will continue to poll untill the timeout period has elapsed and then call the completion block with its *timedOut* property set to `true`. The BlinkUp itself may fail for a number of reasons, including too much ambient light between the phone or tablet and the device; incorrect WiFi settings; and a failure to connect to the impCloud. You can change the default timeout by setting the property [pollTimeout on the devicePoller object]([BUDevicePoller pollTimeout]), but be careful not to set too short a timeout until you know the cause of your connection failures.

--------------------------------------------------------
<p id="7">&nbsp;</p>
## What is a Plan ID?

A Plan ID is a unique identifier generated when a specific user configures a device. You should store this Plan ID and reference it to identify that user, specifically if the user re-configures their device in future. If an existing user re-configures their device and you retrieve a new Plan ID for them, a new agent will be created to manage the device’s Internet connectivity. Data associated with the agent established when the device was first configured, such as device settings and preferences, will be lost.

--------------------------------------------------------
<a name="10">&nbsp;</a>
## What is a Device ID?

A Device ID identifies a specific imp-enabled device. It is used identify which devices are connected to your developer account, as well as what application firmware a device should receive (its assigned model). You can view a development device’s Device ID in the IDE; production devices’ Device IDs can be gathered during the factory flow. The Device ID of a physical device never changes.

--------------------------------------------------------
<p id="8">&nbsp;</p>
## Why does the agent URL keep changing?

An agent URL is derived from a device’s Device ID and the user’s Plan ID, and generated when the user first configures the device. If the same device is configured with the same Plan ID, the agent URL will be consistent. If either the Device ID or the Plan ID changes, a new agent URL will be generated and the previous agent URL associated with the Device ID will be invalidated.

If you wish to manually set the Plan ID (ie. not generate a new one during initial configuration) the Plan ID must have been previously generated by the Electric Imp server. However, the Plan ID is intended to be unique per user. If you have a single user (George, for example), you should use the Plan ID generated for George every time he re-configures that device. It is the customer’s job to keep track of association between Plan ID and users.

If you need to keep track of different devices, the Device ID should be used. You could also maintain a database of all generated agent URLs for a device.

--------------------------------------------------------
<a name="9">&nbsp;</a>
## What if I just want the same agent URL for this device, no matter what?

This is not recommended. The reason we use Plan IDs is to ensure proper security. For example, a garage door opener that was controlled by an application that relied on a static agent URL for communication and control would allow previous owners of the device to continue to control the door, because they have the agent URL.

Though you can get a static agent URL by passing in a constant Plan ID, this is not recommended beyond development use. Please spend some time architecting your use and management of agent URLs in your app and on your server. By developing a proper plan for the agent URL before launch you will avoid many security problems in the future.

--------------------------------------------------------
<a name="11">&nbsp;</a>
## How do I make sure the same user always gets the same agent URL for a device, across multiple BlinkUps?

If a user has never configured a device:

1. Generate a user ID for the user and store it on your own servers.
2. When the user first performs a BlinkUp operation, the app should wait for the [BUDevicePoller](BUDevicePoller) to return with the [BUDeviceInfo](BUDeviceInfo).
3. Store the Plan ID obtained from the [BUDeviceInfo](BUDeviceInfo) on your server or within the app and associate it with the user ID.

If a user has previously used BlinkUp to configure their device, you will have a Plan ID already associated with the user (this information is stored by you on your server on within the app):

1. Pass in the stored Plan ID during the initialization of a [BUBasicController](BUBasicController) or [BUConfigId](BUConfigId).
2. Perform the BlinkUp.
3. If the BlinkUp is successful (and the same device is used) you will get the same agent URL.

--------------------------------------------------------
<a name="12">&nbsp;</a>
## How do I set the Plan ID?

If you are using the [basic Blinkup](Basic-BlinkUp.html) process, use this initialization method: *BUBasicController initWithApiKey:planId:*

If you are using a [custom Blinkup](Custom-BlinkUp.html) process, use this initialization method: *BUConfigId initWithApiKey:planId:completionHandler:*
