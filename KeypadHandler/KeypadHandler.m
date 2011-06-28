//
//  KeypadHandler.m
//  KeypadHandler
//
//  Created by Md. Eamin Rahman on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KeypadHandler.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;


@implementation KeypadHandler

@synthesize uiViewController;

-(id)initWithViewController:(UIViewController *)uiVC
{
    if (self) {
        self.uiViewController = uiVC;
        
        for (UIView *v in self.uiViewController.view.subviews) {
            if ([v isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField*)v;
                textField.delegate = self;
            }
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(backgroundTap:)];
        
        [self.uiViewController.view addGestureRecognizer:tap];
        [tap release];
    }
    
    return self;
}

- (void)dealloc
{
    [uiViewController release];
    [super dealloc];
}

//+(void)attachWithViewController:(UIViewController *)uiViewController
//{
//    
//    KeypadHandler *keypadHandler = [KeypadHandler alloc];
//    [keypadHandler addViewController:uiViewController];
//
//    for (UIView *v in uiViewController.view.subviews) {
//        if ([v isKindOfClass:[UITextField class]]) {
//            UITextField *textField = (UITextField*)v;
//            textField.delegate = keypadHandler;
//        }
//    }
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:keypadHandler
//                                                                          action:@selector(backgroundTap:)];
//    
//    [keypadHandler.uiViewController.view addGestureRecognizer:tap];
//    [tap release];
//
////    
////    [uiView addSubview:keypadHandler];
////    [keypadHandler addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchUpInside];
//    
////    [keypadHandler release];
//    
//}
//
//-(void)addViewController:(UIViewController *)uiVC
//{
//    self.uiViewController = uiVC;
//}

#pragma mark UITextFieldDelegate Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect textFieldRect =
    [self.uiViewController.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.uiViewController.view.window convertRect:self.uiViewController.view.bounds fromView:self.uiViewController.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.uiViewController.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.uiViewController.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    CGRect viewFrame = self.uiViewController.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.uiViewController.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
	 
-(IBAction) backgroundTap:(id) sender{
//    [[UIApplication sharedApplication] becomeFirstResponder];
//    [[UIApplication sharedApplication] resignFirstResponder];

    for (UIView *v in self.uiViewController.view.subviews) {
        if ([v isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)v;
            if ([textField isFirstResponder])
            {
                [textField resignFirstResponder];
                return;
            }
        }
    }
}

@end
