/******************************************************************************
 * - Created 2013/11/27 by Brett Park
 * - Copyright Twilio 2020. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import <BlinkUp/BlinkUp.h>

@interface EIViewController : UIViewController <UITextViewDelegate>

#pragma mark ** Properties **
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) IBOutlet UITextField *ssidField;
@property (nonatomic, weak) IBOutlet UITextField *passwordField;
@property (nonatomic, weak) IBOutlet UITextField *wpsField;

@property (nonatomic, weak) IBOutlet UIButton *flashSSID;
@property (nonatomic, weak) IBOutlet UIButton *flashWPS;
@property (nonatomic, weak) IBOutlet UIButton *flashClearConfig;

@property (weak, nonatomic) IBOutlet UIVisualEffectView *staticOverlay;
@property (weak, nonatomic) IBOutlet UISwitch *useStaticSwitch;
@property (nonatomic, weak) IBOutlet UITextField *staticIP;
@property (nonatomic, weak) IBOutlet UITextField *staticNetmask;
@property (nonatomic, weak) IBOutlet UITextField *staticGateway;
@property (nonatomic, weak) IBOutlet UITextField *staticDNS1;
@property (nonatomic, weak) IBOutlet UITextField *staticDNS2;


@property (weak, nonatomic) IBOutlet UIVisualEffectView *proxyOverlay;
@property (weak, nonatomic) IBOutlet UISwitch *useProxySwitch;
@property (nonatomic, weak) IBOutlet UITextField *proxyHost;
@property (nonatomic, weak) IBOutlet UITextField *proxyPort;
@property (nonatomic, weak) IBOutlet UITextField *proxyUsername;
@property (nonatomic, weak) IBOutlet UITextField *proxyPassword;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;
@property (nonatomic, assign) BOOL keyboardIsShown;

#pragma mark ** IBActions **

- (IBAction)flashSSID:(id)sender;
- (IBAction)flashWPS:(id)sender;
- (IBAction)flashClearConfig:(id)sender;
- (IBAction)flashEthernet:(id)sender;

@end
