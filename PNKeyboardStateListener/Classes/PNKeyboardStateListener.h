//
//  PNKeyboardStateListener.h
//  Pods
//
//  Created by Giuseppe Nucifora on 18/04/16.
//
//

#import <Foundation/Foundation.h>

@interface PNKeyboardStateListener : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (PNKeyboardStateListener*)sharedInstance;

@property (nonatomic, readonly) BOOL keyboardVisible;

- (void) dismissKeyboard;

@end
