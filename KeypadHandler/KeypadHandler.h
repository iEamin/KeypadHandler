//
//  KeypadHandler.h
//  KeypadHandler
//
//  Created by Md. Eamin Rahman on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KeypadHandler : NSObject <UITextFieldDelegate> {
    UIViewController *uiViewController;
    CGFloat animatedDistance;
}

@property(nonatomic,retain) IBOutlet UIViewController *uiViewController;

-(IBAction) backgroundTap:(id) sender;

-(id)initWithViewController:(UIViewController *)uiVC;
//-(void)addViewController:(UIViewController *)uiVC;

//+(void)attachWithViewController:(UIViewController *)uiViewController;

@end
