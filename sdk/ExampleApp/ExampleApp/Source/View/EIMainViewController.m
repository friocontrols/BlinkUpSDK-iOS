/******************************************************************************
 * - Created 2015/01/27 by Brett Park
 * - Copyright Twilio 2020. All rights reserved.
 *
 */

#import "EIMainViewController.h"

@implementation EIMainViewController


//*****************************************************************************
#pragma mark -
#pragma mark ** IBActions **

- (IBAction)goAction:(id)sender;
{
  NSString *apiKey = //YOUR API KEY HERE;
    BUBasicController *blinkUpController = [[BUBasicController alloc]initWithApiKey:apiKey];

//  id activity = [NSProcessInfo.processInfo    reason:@"BlinkUp Is Ocurring"];
//If using a previously created planId
//  BUBasicController *blinkUpController = [[BUBasicController alloc]initWithApiKey:apiKey planId:@"asdf"];

  // If dynamic text needs to be injected into the BlinkUp SDK is can be done using
  // stringParams. In the corresponding .strings file, use a placeholder such as %@ for the
  // location that the dynamic text will be used. Then be sure to set the corresponding string
  // parameters with an array of the values that will be filled in
//	blinkUpController.networkSelectController.stringParams.globalFooter = @[@"Dynamic footer text"];

//  blinkUpController.flashController.interstitialImage = [UIImage imageNamed:@"inter.png"];

//    Optionally set the agent url timeout to 20 seconds
//    blinkUpController.devicePoller.pollTimeout = 20;

//    Optionally set the size of the preflash countdown timer
//    blinkUpController.flashController.preFlashCountdownTime = 10;

//    Optionally disable the ability to show passwords on the wifi details screen
//    blinkUpController.networkSelectController.disableWifiDetailShowPassword = YES;
  [blinkUpController presentInterfaceAnimated:YES resignActive: ^(BOOL willRespond, BOOL userDidCancel, NSError *error) {
    [BUHelper fixRotationForViewController:self];
    LOG_METHOD;
    LOG_BOOL(willRespond);
    LOG_BOOL(userDidCancel);
    LOG_OBJECT(error);
  } devicePollingDidComplete: ^(BUDeviceInfo *deviceInfo, BOOL timedOut, NSError *error) {
    LOG_METHOD;
    LOG_OBJECT(deviceInfo.verificationDate);
    LOG_OBJECT(deviceInfo.agentURL);
    LOG_OBJECT(deviceInfo.deviceId);
    LOG_OBJECT(deviceInfo.planId)
    LOG_OBJECT(error);
  }];
}

-(BOOL) shouldAutorotate {
  return [BUHelper shouldAutorotate];
}

@end
