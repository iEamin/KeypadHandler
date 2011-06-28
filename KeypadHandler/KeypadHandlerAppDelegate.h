//
//  KeypadHandlerAppDelegate.h
//  KeypadHandler
//
//  Created by Md. Eamin Rahman on 6/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeypadHandlerViewController;

@interface KeypadHandlerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet KeypadHandlerViewController *viewController;

@end
