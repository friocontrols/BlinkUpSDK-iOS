If the [Basic BlinkUp](Basic-BlinkUp.html) process doesn’t meet your needs, you can customize the experience for your users. Customization involves using the various individual BlinkUp components directly. An overview of the process can be found on the [main documentation](../index.html) page. Some of the concepts discussed here can be seen in the *ExampleCustomUI* example provided in the SDK bundle.

The customized BlinkUp process will involve each of the following stages:

1. [Network Selection](#network)
2. [Configuration ID](#configId)
3. [Flashing](#flashing)
4. [Polling](#polling)

<p id="network">&nbsp;</p>
## Network Selection

During the BlinkUp process, your application will need a way to gather network credentials for the imp-based device you are configuring. The class you use to perform this action is called [BUNetworkSelectController](BUNetworkSelectController). It will present the user with a list of known WiFi networks, as well as options to use WPS (WiFi Protected Setup) for configuration and to clear the configuration currently on the device. Due to limitiations of iOS, the interface will only show the name of the network the phone is currently connected to and any networks that the user has connected to and saved in the past. If you do not wish to use the standard network selection interface, you can [build your own](#networkCustom) with help from the [BUNetworkManager](BUNetworkManager).

### Standard Network Selection

The following code snippet shows how you can present a standard network selection UI:

```
// 1. Create a new instance of a BUNetworkSelectController

BUNetworkSelectController *networkSelect = [[BUNetworkSelectController alloc] init];

// 2. Present the interface to the user

[networkSelect presentInterfaceAnimated:NO completionHandler:^(BUNetworkConfig *networkConfig, BOOL userDidCancel) {
  // 3. At this point your interface is back in control
  // 4. If userDidCancel is true, no network or action was selected
  // 5. If the user selected a network or action, the networkConfig object will
  //    have the result and can be pass into a flash controller, or the properties
  //    can be read directly after checking type (BUWifiConfig, BUWPSConfig, BUEthernetConfig, or BUNetworkConfig)
}];
```

<p id="networkCustom">&nbsp;</p>
### Custom Network Selection

The [BUNetworkManager](BUNetworkManager) can be used to do most of the heavy lifting for managing the user’s previous WiFi networks, if you prefer to build your own user interface. WiFi and WPS settings are passed to the SDK via [BUWifiConfig](BUWifiConfig) and [BUWPSConfig](BUWPSConfig).

If your connected product is based on the imp005 module and you intend it to connect by Ethernet only, there is no need to present a network selection screen and you can simply provide a [BUEthernetConfig](BUEthernetConfig) object &mdash; or pass in a [BUEthernetConfig](BUEthernetConfig) object if the user has chosen that means of connectivity in response to a request from your app.

Most importantly, these objects have the ability to be saved to storage across launches.

**Note** The imp005 does not currently support WiFi configuration by WPS pin code.

The following code snippet shows how you can access network data:

```
// 1. Retrieve a list of the iPhone's current WiFi network and all saved networks
//    All objects are of type BUWifiConfig and the first object is the current network

NSArray *wifiConfigs = [BUNetworkManager allWifiConfigs];

// 2. Present your own interface to the user
//    some awesome interface you develop

// 3. After your interface is complete create a BUNetworkConfig (or sublass) to
//    use for flashing the device

BUNetworkConfig *clearConfig = [BUNetworkConfig clearNetworkConfig];
BUWifiConfig *wifiConfig = [[BUWifiConfig alloc] initWithSSID:@"networkname" password:@"pass123"];
BUWPSConfig *wpsConfig = [[BUWPSConfig alloc] initWithWPSPin:@"0430"];
BUEthernetConfig *ethernetConfig = [[BUEthernetConfig alloc] init];
```

---
<p id="configId">&nbsp;</p>
## Configuration ID

However you perform BlinkUp, you will need a [BUConfigId](BUConfigId) object. This is a combination of a one-time Enrollment Token and a Plan ID that is used to identify the device being configured to the impCloud&trade;. In order to generate a configuration ID, the impCloud must be contacted. When you create a [BUConfigId](BUConfigId) object with your API key, the object will asynchronously get a new [BUConfigId](BUConfigId) object that can be used to proceed with the BlinkUp. If the new [BUConfigId](BUConfigId) object is not retrieved, the BlinkUp process cannot continue.

* More information about the Plan ID can be found in the [FAQ](FAQ.html).
* If you are performing an external configuration (ie. non-flash), consult the [imp API documentation](https://electricimp.com/docs/api/imp/setenroltokens) to learn how to transfer the configuration.

The following code snippet shows how you to generate the configuration ID:

```
// 1. Create a new BUConfigId using your API key.
//    Upon creation it will attempt to connect to the Eletric Imp Cloud and
//    retrieve a new configuration ID (stored in a BUConfigId object)

BUConfigId *configId = [[BUConfigId alloc] initWithApiKey:[self getAPIKey] completionHandler:^(BUConfigId *configId, NSError *error) {
  // 2. Be sure to check for an error and inform the user
  // 3. Use the now active configId to perform a flash or external configuration
}];
```

---
<p id="flashing">&nbsp;</p>
## Flashing

Flashing is the process of sending the network details and configuration ID from the phone or tablet to the imp-based device. The same process is used to clear the device’s existing network configuration, though in this instance a configuration ID object is not required. If the network configuration comprises either WiFi SSID and password credentials, a WPS PIN, or an Ethernet configuration, then a [BUDevicePoller](BUDevicePoller) will be returned.

The following code snippet shows how to present the flash screen:

```
// 1. Create a new instance of a flash controller

BUFlashController *flashController = [[BUFlashController alloc] init];

// 2. Start the flashing process using the configId object (see 'Configuration ID', above)
//    Upon completion the resignActive block will be called

[flashController presentFlashWithNetworkConfig:wifiConfig configId:configId animated:YES resignActive:^(BOOL willRespond, BUDevicePoller *devicePoller, NSError *error) {
  // 3. Be sure to check for an error and inform the user
  // 4. If willRespond is true, a devicePoller will be created to retrieve deviceInfo
  // 5. Use the devicePoller to retrieve information about the device
}];
```

---
<p id="Polling">&nbsp;</p>
## Polling

Polling is the process of querying the impCloud for information about the device that was just configured and should now be contacting the impCloud directly to gain authorization to connect. The [BUDevicePoller](BUDevicePoller) object will actively check to see if the device has connected. Polling does not start automatically.

The following code snippet shows how to poll the impCloud:

```
// 1. The devicePoller is normally created by the BUFlashController (but it can be
//    created manually if using an external configuration method)

BUDevicePoller *devicePoller = devicePollerFromFlashControllerResignActiveBlock;

[devicePoller startPollingWithCompletionHandler:^(BUDeviceInfo *deviceInfo, BOOL timedOut, NSError *error) {
  // 3. Be sure to check for an error and inform the user
  // 4. If timedOut is true the device did not connect within the pollTimeout period
  // 5. If deviceInfo is not nil, it will contain information of the device that was configured
}];
```
