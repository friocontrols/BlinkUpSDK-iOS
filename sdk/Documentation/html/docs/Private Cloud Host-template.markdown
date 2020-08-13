In order to use a Private impCloud™ Host with the SDK, the hostname and SSL pinning information need to be provided. The SDK is configured with this information by using the [BUSDK](BUSDK) class during application launch in the Application Delegate.

## Host Configuration ##

An example of setting the host without SSL pinning (for initial development / testing only) is as follows:

_Objective-C_

```
[BUSDK configureWithPrivateCloudHost:@"privateImpCloudHostDomain.com" pinningDescriptions:@[]];
```

_Swift_

```
BUSDK.configure(withPrivateCloudHost: "privateImpCloudHostDomain.com", pinningDescriptions: [])
```


## Host Configuration With SSL Pinning (Recommended) ##

SSL Pinning increases security when communication with the Private impCloud Host. When configured, the SDK will validate that the server’s anchoring certificate (the root) has a proper hostname and SPKI data. This process is followed in order to provide an extra layer of security by preventing man-in-the-middle attacks and the use of SSL proxies.

Additional details on creating pinning descriptions can be found in the documentation for [BUPinningDescription](BUPinningDescription).

_Objective-C_

```
// Amazon Root Certificate Authority 1
BUPinningSPKIData *amazonRootCa1 = [[BUPinningSPKIData alloc] initWithHexString:@"<CA_1_HEX_STRING>" algorithms:BUPublicKeyAlgorithmRsa2048];
// Amazon Root Certificate Authority 2
BUPinningSPKIData *amazonRootCa2 = [[BUPinningSPKIData alloc] initWithHexString:@"<CA_2_HEX_STRING>" algorithms:BUPublicKeyAlgorithmRsa4096];

// Allow the host to use a certificate signed by Amazon Root 1 or 2
BUPinningDescription *pinningDescription = [[BUPinningDescription alloc] initWithHostname:@"privateImpCloudHostDomain.com"];
pinningDescription.pins = @[amazonRootCa1, amazonRootCa2];

// Configure the application to use the Private impCloud Host and ensure the certificate is signed by Amazon Root 1 or 2
[BUSDK configureWithPrivateCloudHost:@"privateImpCloudHostDomain.com" pinningDescriptions:@[pinningDescription]];
```

_Swift_

```
// Amazon Root Certificate Authority 1
let amazonRootCa1 = BUPinningSPKIData(hexString: "<CA_1_HEX_STRING>", algorithms: .rsa2048)
// Amazon Root Certificate Authority 2
let amazonRootCa2 = BUPinningSPKIData(hexString: "<CA_2_HEX_STRING>", algorithms: .rsa4096)

// Allow the host to use a certificate signed by Amazon Root 1 or 2
let pinningDescription = BUPinningDescription(hostname: "privateImpCloudHostDomain.com")
pinningDescription.pins = [amazonRootCa1, amazonRootCa2]

// Configure the application to use the private cloud host and ensure the certificate is signed by Amazon Root 1 or 2
BUSDK.configure(withPrivateCloudHost: "privateImpCloudHostDomain.com", pinningDescriptions: [pinningDescription])
```
