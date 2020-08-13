//
//  ViewController.swift
//  ExampleAppSwift
//
//  Created by BrettPark on 2014-09-08.
//  Copyright © 2020 Twilio. All rights reserved.
//

import UIKit
import BlinkUp

class ViewController: UIViewController {
  let apiKey: String = //YOUR API KEY HERE
  
  var disableRotation:Bool = false //Prevent rotation during flashing
  
  override var shouldAutorotate : Bool {
    return BUHelper.shouldAutorotate()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NSLog("Using version \(BlinkUpVersionString) : \(BlinkUpVersionNumber) of the SDK");
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func showStandardInterface(_ sender: AnyObject) {
    let blinkUpController = BUBasicController(apiKey: apiKey)
    
    blinkUpController.presentInterfaceAnimated(true, resignActive: { (resignActiveResponse) -> () in
      BUHelper.fixRotation(for: self)
      switch resignActiveResponse {
      case .willNotRespond:
        print("We are back in control, and the user did not try to Connect to an impee")
      case .willRespond:
        print("We should wait for a response from the Impee in the deviceResponse block")
      case .userCancelled:
        print("The user cancelled")
      case .error(let error):
        print("Something bad happened: %@", error.debugDescription);
      }
    }, deviceResponse: { (deviceResponse) -> () in
      switch deviceResponse {
      case .didNotConnect:
        print("The device never responded back to the server")
      case .error(let error):
        print("An error occured listening for the device: %@", error.debugDescription)
      case .connected(let impeeData):
        print("We are connected to the device \(impeeData)")
      }
    })
  }
  
  
  @IBAction func flashWithWifi(_ sender: AnyObject) {
    let wifiConfig = BUWifiConfig(ssid: "MyWireless", password: "MyPassword")
    
    showRetrieveTokenAlert()
    let _ = BUConfigId(apiKey: apiKey) { (response) -> () in
      self.hideRetrieveTokenAlert()
      switch (response) {
      case BUConfigId.ConfigIdResponse.error(let e):
        print("A problem occured %@", e.localizedDescription)
      case BUConfigId.ConfigIdResponse.activated(activeConfig: let activeConfig):
        print("Config Retrieved")
        self.startFlashWithConfigId(activeConfig, network: wifiConfig)
      }
    }
  }
  
  func startFlashWithConfigId(_ configId:BUConfigId, network:BUNetworkConfig) {
    let flashController = BUFlashController()
    flashController.preFlashCountdownTime = 6
    flashController.presentFlashWithNetworkConfig(network, configId: configId, animated: true, resignActive: self.flashCompleted)
  }
  
  func flashCompleted(_ flashResponse: BUFlashController.FlashResponse) {
    BUHelper.fixRotation(for: self)
    switch(flashResponse) {
    case BUFlashController.FlashResponse.error(let e):
      print("Flash failed: %@", e.localizedDescription)
    case BUFlashController.FlashResponse.completedWithoutPoller:
      print("Flash Completed and a poller was NOT created")
    case BUFlashController.FlashResponse.completedWithPoller(let poller):
      print("Flash Completed and a poller was created")
     pollerWasCreated(poller)
    }
  }
  
  func pollerWasCreated(_ poller:BUDevicePoller) {
    poller.pollTimeout = 45
    print("Starting poll with timeout", poller.pollTimeout)
    poller.startPollingWithHandler { (response) -> () in
      switch(response) {
      case BUDevicePoller.PollerResponse.error(let e):
        print("Poller had error: %@", e.localizedDescription)
      case BUDevicePoller.PollerResponse.timedOut:
        print("Poller timed out because the device did not response")
      case BUDevicePoller.PollerResponse.responded(let deviceInfo):
        print("Poller completed with deviceId: %@", deviceInfo.deviceId!)
      }
    }
  }
  
  
  @IBAction func flashWithWPS(_ sender: AnyObject) {
    let wpsConfig = BUWPSConfig(wpsPin: nil)
    showRetrieveTokenAlert()
    let _ = BUConfigId(apiKey: apiKey) { (response) -> () in
      self.hideRetrieveTokenAlert()
      switch (response) {
      case BUConfigId.ConfigIdResponse.error(let e):
        print("A problem occured %@", e.localizedDescription)
      case BUConfigId.ConfigIdResponse.activated(activeConfig: let activeConfig):
        print("Config Retrieved")
        self.startFlashWithConfigId(activeConfig, network: wpsConfig)
      }
    }
  }
  
  @IBAction func clearImpee(_ sender: AnyObject) {
    let flashController = BUFlashController()
    flashController.preFlashCountdownTime = 2
    flashController.presentFlashWithNetworkConfig(BUNetworkConfig.clear(), configId: Optional.none, animated: true, resignActive: flashCompleted)
  }
  
  @IBAction func nonBlinkUpTokenRetrieval (_ sender: AnyObject) {
    showRetrieveTokenAlert()
    let _ = BUConfigId(apiKey: apiKey) { (response) -> () in
      self.hideRetrieveTokenAlert()
      switch (response) {
      case BUConfigId.ConfigIdResponse.error(let e):
        print("A problem occured %@", e.localizedDescription)
      case BUConfigId.ConfigIdResponse.activated(activeConfig: let activeConfig):
        print("Config Retrieved %@", activeConfig.token)
      }
    }
  }
  
  @IBAction func flashEthernetWithStaticAndProxy(_ sender: AnyObject) {
    let ethernetConfig = BUEthernetConfig()
    if let staticAddressing = BUStaticAddressing(ip: "192.168.0.101", netmask: "255.255.255.0", gateway: "192.168.0.1", dns1: "192.168.0.1") {
      ethernetConfig.addressing = staticAddressing
    } else {
      print("Invalid parameter for Static Addressing")
    }
    
    if let proxy = BUNetworkProxy(server: "netproxy.local", port: 80, username: nil, password: nil) {
      ethernetConfig.proxy = proxy
    } else {
      print("Invalid parameter for Proxy")
    }
    
    showRetrieveTokenAlert()
    let _ = BUConfigId(apiKey: apiKey) { (response) -> () in
      self.hideRetrieveTokenAlert()
      switch (response) {
      case BUConfigId.ConfigIdResponse.error(let e):
        print("A problem occured %@", e.localizedDescription)
      case BUConfigId.ConfigIdResponse.activated(activeConfig: let activeConfig):
        print("Config Retrieved")
        self.startFlashWithConfigId(activeConfig, network: ethernetConfig)
      }
    }
  }
  
  func showRetrieveTokenAlert () {
    let alert = UIAlertController(title: nil, message: "Retrieving Token", preferredStyle: .alert)
    
    alert.view.tintColor = UIColor.black
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.style = UIActivityIndicatorView.Style.gray
    loadingIndicator.startAnimating();
    
    alert.view.addSubview(loadingIndicator)
    present(alert, animated: true, completion: nil)
  }
  
  func hideRetrieveTokenAlert () {
    dismiss(animated: false, completion: nil)
  }
}
