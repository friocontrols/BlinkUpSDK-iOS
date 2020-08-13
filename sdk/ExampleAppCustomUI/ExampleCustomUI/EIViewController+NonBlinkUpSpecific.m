//
//  EIViewController+NonBlinkUpSpecific.m
//  ExampleCustomUI
//
//  Created by Brett Park on 2016-06-02.
//
//

#import "EIViewController+NonBlinkUpSpecific.h"

@implementation EIViewController (NonBlinkUpSpecific)

//*****************************************************************************
#pragma mark -
#pragma mark ** View LifeCycle **

- (void)updateInterfaceElements {
  if (self.ssidField.text.length < 1) {
    self.ssidField.text = [BUNetworkManager currentWifiSSID];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateInterfaceElements];
  [self registerKeyboardListners:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [self registerKeyboardListners:NO];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  //Dump verion number to console
  NSLog(@"Using version %@ : %f of the SDK", BlinkUpVersionString, BlinkUpVersionNumber);
  
  //When the application enters the foreground, make sure the app is up to date (IE: Current Wifi SSID)
  [[NSNotificationCenter defaultCenter]addObserver:self
  selector:@selector(updateInterfaceElements)
  name:UIApplicationWillEnterForegroundNotification object:nil];
}

/**************************************************************
   UI Functions moving
**************************************************************/

- (IBAction)proxyChanged:(UISwitch *)sender {
  if (sender.on) {
    self.proxyOverlay.userInteractionEnabled = NO;
    self.proxyOverlay.alpha = 0.0;
    [self.view endEditing:YES];
  } else {
    self.proxyOverlay.userInteractionEnabled = YES;
    self.proxyOverlay.alpha = 0.9;
    [self.view endEditing:YES];
  }
}

- (IBAction)staticAddressingChanged:(UISwitch *)sender {
  if (sender.on) {
    self.staticOverlay.userInteractionEnabled = NO;
    self.staticOverlay.alpha = 0.0;
    [self.view endEditing:YES];
  } else {
    self.staticOverlay.userInteractionEnabled = YES;
    self.staticOverlay.alpha = 0.9;
    [self.view endEditing:YES];
  }
}

/**************************************************************
   Keyboard moving
**************************************************************/

- (void)registerKeyboardListners:(BOOL)enable {
  if (enable) {
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter]addObserver:self
    selector:@selector(keyboardWillShow:)
    name:UIKeyboardWillShowNotification
    object:self.view.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter]addObserver:self
    selector:@selector(keyboardWillHide:)
    name:UIKeyboardWillHideNotification
    object:self.view.window];
    self.keyboardIsShown = NO;
  } else {
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter]removeObserver:self
    name:UIKeyboardWillShowNotification
    object:nil];

    [[NSNotificationCenter defaultCenter]removeObserver:self
    name:UIKeyboardWillHideNotification
    object:nil];
  }
}

- (void)keyboardWillHide:(NSNotification *)n {
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationBeginsFromCurrentState:YES];

  self.scrollViewBottomConstraint.constant = 0;
  [self.view layoutIfNeeded];
  [UIView commitAnimations];

  self.keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n {
  if (self.keyboardIsShown) {
    return;
  }

  NSDictionary *userInfo = n.userInfo;

  // get the size of the keyboard
  CGSize keyboardSize = [userInfo[UIKeyboardFrameBeginUserInfoKey]CGRectValue].size;

  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationBeginsFromCurrentState:YES];

  self.scrollViewBottomConstraint.constant = keyboardSize.height;
  [self.view layoutIfNeeded];
  [UIView commitAnimations];
  self.keyboardIsShown = YES;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
  [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [self.view endEditing:YES];
  return YES;
}

@end
