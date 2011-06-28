//
//  KeypadHandlerViewController.h
//  KeypadHandler
//
//  Created by Md. Eamin Rahman on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeypadHandler.h"

@interface KeypadHandlerViewController : UIViewController <UITextFieldDelegate> {
    UITextField *textField;
    CGFloat animatedDistance;
    KeypadHandler *keypadHandler;
}

@property(nonatomic,retain) IBOutlet UITextField *textField;

@end
