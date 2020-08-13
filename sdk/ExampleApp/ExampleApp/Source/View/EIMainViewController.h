/******************************************************************************
 * - Created 2013/11/27 by Brett Park
 * - Copyright Twilio 2020. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>
#import <BlinkUp/BlinkUp.h>

@interface EIMainViewController : UIViewController

#pragma mark ** Properties **

@property (nonatomic, weak) IBOutlet UIButton *goButton;
@property (nonatomic, weak) IBOutlet UISwitch *customizeSwitch;
@property (nonatomic, assign) BOOL disableRotation;
#pragma mark ** IBActions **

- (IBAction)goAction:(id)sender;

@end
