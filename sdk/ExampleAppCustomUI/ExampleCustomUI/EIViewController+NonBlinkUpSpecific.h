//
//  EIViewController+NonBlinkUpSpecific.h
//  ExampleCustomUI
//
//  Created by Brett Park on 2016-06-02.
//
//

#import <Foundation/Foundation.h>
#import "EIViewController.h"
@interface EIViewController (NonBlinkUpSpecific)
- (void)registerKeyboardListners:(BOOL)enable;
- (void)keyboardWillHide:(NSNotification *)n;
- (void)keyboardWillShow:(NSNotification *)n;
@end
