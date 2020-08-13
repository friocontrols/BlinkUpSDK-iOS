/******************************************************************************
 * - Created 2013/11/27 by Brett Park
 * - Copyright Twilio 2020. All rights reserved.
 *
 */

#import "EIViewController.h"

@implementation EIViewController

- (NSString *)getAPIKey;
{
  NSString *apiKey = //YOUR API KEY HERE;
  return apiKey;
}

-(BOOL) shouldAutorotate {
  return [BUHelper shouldAutorotate];
}

/**************************************************************
    Wifi using nested code blocks
**************************************************************/


/*!
 *  @brief  Perform a BlinkUp with a wifi configuration
 *
 *  This method shows a BlinkUp using inline anonymous blocks
 *
 */
- (IBAction)flashSSID:(id)sender {
  [self.view endEditing:YES];

  if (self.ssidField.text == nil || self.ssidField.text.length == 0) {
    [self showError:@"SSID cannot be empty" forTitle:@"WiFi Issue"];
    return;
  }

  //If using password:
  BUWifiConfig *wifiConfig = [[BUWifiConfig alloc]initWithSSID:self.ssidField.text password:self.passwordField.text];

  //If using saved ssid
  // BUWifiConfig * wifiConfig = [[BUWifiConfig alloc] initWithExistingSSID:self.ssidField.text];

  BOOL configureSuccess = [self addAddressingAndProxyToNetworkConfig:wifiConfig];
  if (!configureSuccess) {
    return;
  }

  [self showRetrieveTokenAlert];
  BUConfigId *configId = [[BUConfigId alloc]initWithApiKey:[self getAPIKey] completionHandler: ^(BUConfigId *configId, NSError *error) {
    [self hideRetrieveTokenAlert];
    if (error) {
      LOG_METHOD;
      LOG_OBJECT(error);
    } else {
      BUFlashController *flashController = [[BUFlashController alloc]init];
      [flashController presentFlashWithNetworkConfig:wifiConfig configId:configId animated:YES resignActive: ^(BOOL willRespond, BUDevicePoller *devicePoller, NSError *error) {
        [BUHelper fixRotationForViewController:self];
        if (error) {
          LOG_METHOD;
          LOG_OBJECT(error);
        }     else if (!willRespond) {
          LOG_METHOD;
          LOG_OBJECT(@"Flash was of non-wifi connection type");
        }     else{
          [devicePoller startPollingWithCompletionHandler: ^(BUDeviceInfo *deviceInfo, BOOL timedOut, NSError *error) {
            if (error) {
              LOG_METHOD;
              LOG_OBJECT(error);
            } else if (timedOut) {
              LOG_METHOD;
              LOG_OBJECT(@"The Device did not respond");
            } else {
              LOG_METHOD;
              LOG_OBJECT(deviceInfo);
            }
          }];
        }
      }];
    }
  }];

  #pragma unused(configId)
}

/**************************************************************
        WPS using non-nested code blocks
**************************************************************/

/*!
 *  @brief  Perform a BlinkUp with a WPS configuration
 *
 *  This method shows a BlinkUp using named blocks. The purpose of this is
 *  to avoid deep nesting of blocks.
 */
- (IBAction)flashWPS:(id)sender;
{
  [self.view endEditing:YES];

  BUWPSConfig *wpsConfig = [[BUWPSConfig alloc]initWithWPSPin:self.wpsField.text];

  BOOL configureSuccess = [self addAddressingAndProxyToNetworkConfig:wpsConfig];
  if (!configureSuccess) {
    return;
  }

  DevicePollingDidCompleteBlock deviceBlock = ^(BUDeviceInfo *deviceInfo, BOOL timedOut, NSError *error) {
    if (error) {
      LOG_METHOD;
      LOG_OBJECT(error);
    }else if (timedOut) {
      LOG_METHOD;
      LOG_OBJECT(@"The Device did not respond");
    }else {
      LOG_METHOD;
      LOG_OBJECT(deviceInfo);
    }
  };

  FlashResignActiveBlock flashBlock = ^(BOOL willRespond, BUDevicePoller *devicePoller, NSError *error) {
    [BUHelper fixRotationForViewController:self];
    if (error) {
      LOG_METHOD;
      LOG_OBJECT(error);
    }else if (!willRespond) {
      LOG_METHOD;
      LOG_OBJECT(@"Flash was of non-wifi connection type");
    }else {
      [devicePoller startPollingWithCompletionHandler:deviceBlock];
    }
  };

  [self showRetrieveTokenAlert];
  BUConfigIdCompletionHandler configBlock = ^(BUConfigId *configId, NSError *error) {
    [self hideRetrieveTokenAlert];
    if (error) {
      LOG_METHOD;
      LOG_OBJECT(error);
    } else {
      BUFlashController *flashController = [[BUFlashController alloc]init];
      flashController.preFlashCountdownTime = 5;
      flashController.interstitialImage = [UIImage imageNamed:@"ExampleInterstitial"];
      [flashController presentFlashWithNetworkConfig:wpsConfig configId:configId animated:YES resignActive:flashBlock];
    }
  };

  BUConfigId *configId = [[BUConfigId alloc]initWithApiKey:[self getAPIKey] completionHandler:configBlock];
  #pragma unused(configId)
}


/**************************************************************
        Perform a flash to clear the devices configuration
**************************************************************/
- (IBAction)flashClearConfig:(id)sender;
{
  [self.view endEditing:YES];

  BUFlashController *flashController = [[BUFlashController alloc]init];

  [flashController presentFlashWithNetworkConfig:[BUNetworkConfig clearNetworkConfig] configId:nil animated:YES resignActive: ^(BOOL willRespond, BUDevicePoller *devicePoller, NSError *error) {
    [BUHelper fixRotationForViewController:self];
    if (error) {
      LOG_METHOD;
      LOG_OBJECT(error);
    } else {
      LOG_METHOD;
      LOG_BOOL(willRespond);
      LOG_OBJECT(@"No poller created from a clear");
    }
  }];
}

/**************************************************************
   Perform a flash for imp005 Ethernet usage
**************************************************************/
- (IBAction)flashEthernet:(id)sender {
  [self.view endEditing:YES];

  BUEthernetConfig *ethernetConfig = [[BUEthernetConfig alloc]init];
  BOOL configureSuccess = [self addAddressingAndProxyToNetworkConfig:ethernetConfig];
  if (!configureSuccess) {
    return;
  }

  [self showRetrieveTokenAlert];
  // This section is the same as WiFiConfig
  BUConfigId *configId = [[BUConfigId alloc]initWithApiKey:[self getAPIKey] completionHandler: ^(BUConfigId *configId, NSError *error) {
    [self hideRetrieveTokenAlert];
    if (error) {
      LOG_METHOD;
      LOG_OBJECT(error);
    } else {
      BUFlashController *flashController = [[BUFlashController alloc]init];
      [flashController presentFlashWithNetworkConfig:ethernetConfig configId:configId animated:YES resignActive: ^(BOOL willRespond, BUDevicePoller *devicePoller, NSError *error) {
        [BUHelper fixRotationForViewController:self];
        if (error) {
          LOG_METHOD;
          LOG_OBJECT(error);
        } else if (!willRespond) {
          LOG_METHOD;
          LOG_OBJECT(@"Flash was of non-connection type");
        }     else{
          [devicePoller startPollingWithCompletionHandler: ^(BUDeviceInfo *deviceInfo, BOOL timedOut, NSError *error) {
            if (error) {
              LOG_METHOD;
              LOG_OBJECT(error);
            }         else if (timedOut) {
              LOG_METHOD;
              LOG_OBJECT(@"The Device did not respond");
            }         else{
              LOG_METHOD;
              LOG_OBJECT(deviceInfo);
            }
          }];
        }
      }];
    }
  }];

#pragma unused(configId)
}

/**************************************************************
   Static Addressing and Proxy
**************************************************************/

/*!
 *  @brief Create a static addressing object
 *
 *  @return Static Addressing or nil on error
 */
- (BUStaticAddressing *)staticAddressingFromUI {
  NSString *ip = self.staticIP.text;
  NSString *netmask = self.staticNetmask.text;
  NSString *gateway = self.staticGateway.text;
  NSString *dns1 = self.staticDNS1.text;
  NSString *optionalDns2 = self.staticDNS2.text;

  //If some of the fields were not valid nil will be returned. Each of the text fields should be validated before creating the static addressing object
  NSString *errorField = nil;
  if (![BUNetworkManager isValidIpAddress:ip]) {
    errorField = @"IP";
  } else if (![BUNetworkManager isValidIpAddress:netmask]) {
    errorField = @"Netmask";
  } else if (![BUNetworkManager isValidIpAddress:gateway]) {
    errorField = @"Gateway";
  } else if (![BUNetworkManager isValidIpAddress:dns1]) {
    errorField = @"DNS 1";
  } else if (optionalDns2.length > 0 && ![BUNetworkManager isValidIpAddress:optionalDns2]) {
    errorField = @"DNS 2";
  }
  
  if (errorField) {
    NSString *errorMessage = [NSString stringWithFormat:@"The %@ field is not a valid IP address", errorField];
    [self showError:errorMessage forTitle:@"Static Addressing Issue"];
    return nil;
  }
  
  // Create the Static Addressing object
  // This initializer is failable and may return nil if the strings are not valid IP Addresses.
  BUStaticAddressing *staticAddressing = [[BUStaticAddressing alloc]initWithIp:ip netmask:netmask gateway:gateway dns1:dns1 dns2:optionalDns2];
  
  // If an object was created return it
  if (staticAddressing) {
    return staticAddressing;
  } else {
    return nil;
  }
}

/*!
 *  @brief Create a proxy object
 *
 *  @return Proxy or nil on error
 */
- (BUNetworkProxy *)proxyFromUI {
  NSString *hostOrIp = self.proxyHost.text;
  NSString *portAsString = self.proxyPort.text;
  NSString *optionalUsername = self.proxyUsername.text;
  NSString *optionalPassword = self.proxyPassword.text;

  NSInteger portAsInteger = portAsString.intValue;
  if (portAsInteger < 1 || portAsInteger > 65535) {
    [self showError:@"Port is invalid" forTitle:@"Proxy Issue"];
    return nil;
  }

  // Create the Proxy object
  BUNetworkProxy *proxy = [[BUNetworkProxy alloc]initWithServer:hostOrIp port:portAsInteger username:optionalUsername password:optionalPassword];

  // If an object was created return it
  if (proxy) {
    return proxy;
  } else {
    //If some of the fields were not valid nil will be returned. Each of the text fields should be validated before creating the static addressing object
    NSString *badField = nil;
    if (hostOrIp.length < 1) {
      badField = @"Hostname or IP";
    } else {
      badField = @"Unknown";
    }

    NSString *errorMessage = [NSString stringWithFormat:@"The %@ field is not valid", badField];
    [self showError:errorMessage forTitle:@"Proxy Issue"];
    return nil;
  }
}

/*!
 *  @brief Add Addressing and Proxy if enabled
 *
 *  @param networkConfig Network Configuration to alter
 *
 *  @return False on error, True otherwise
 */
- (BOOL)addAddressingAndProxyToNetworkConfig:(BUNetworkConfig *)networkConfig {
  // Configure static addressing if enabled
  if (self.useStaticSwitch.isOn) {
    BUStaticAddressing *staticAddressing = [self staticAddressingFromUI];
    if (staticAddressing != nil) {
      networkConfig.addressing = staticAddressing;
    } else {
      return false;
    }
  }

  // Configure proxy if enabled
  if (self.useProxySwitch.isOn) {
    BUNetworkProxy *proxy = [self proxyFromUI];
    if (proxy != nil) {
      networkConfig.proxy = proxy;
    } else {
      return false;
    }
  }

  return true;
}

/**************************************************************
   Other methods
**************************************************************/

#pragma mark -
#pragma mark ** Unused Usefull methods **

//This method generates an array containing ssids as strings.
// If a current network is available it will be listed first (and will not be duplicated if saved)
// An "Other Network" option is added for manual entry
- (NSArray *)ssidArrayForTableView {
  NSMutableArray *ssids = [NSMutableArray arrayWithCapacity:6];

  NSArray *wifiConfigs = [BUNetworkManager allWifiConfigs];

  for (BUWifiConfig *wifiConfig in wifiConfigs) {
    [ssids addObject:wifiConfig.ssid];
  }

  //Add a "other" network for custom entry
  [ssids addObject:@"Other Network"];

  return [ssids copy];
}

- (void)showError:(NSString *)error forTitle:(NSString *)title {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:error preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
    handler:^(UIAlertAction *action) {}];
  [alert addAction:defaultAction];
  [self presentViewController:alert animated:YES completion:nil];
}


-(void) showRetrieveTokenAlert {
  UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:@"Retrieving Token" preferredStyle:UIAlertControllerStyleAlert];
  
  alertController.view.tintColor = [UIColor blackColor];
  UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
  indicatorView.hidesWhenStopped = YES;
  indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
  [indicatorView startAnimating];
  
  [alertController.view addSubview:indicatorView];
  [self presentViewController:alertController animated:YES completion:nil];
}

-(void) hideRetrieveTokenAlert {
  [self dismissViewControllerAnimated:false completion: nil];
}


@end
