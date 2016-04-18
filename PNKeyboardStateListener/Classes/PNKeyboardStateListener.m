//
//  PNKeyboardStateListener.m
//  Pods
//
//  Created by Giuseppe Nucifora on 18/04/16.
//
//

#import "PNKeyboardStateListener.h"

@implementation PNKeyboardStateListener

static PNKeyboardStateListener *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}

- (BOOL)isVisible
{
    return _keyboardVisible;
}

- (void)didShow
{
    _keyboardVisible = YES;
}

- (void)didHide
{
    _keyboardVisible = NO;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[PNKeyboardStateListener alloc] init];
}

- (id)mutableCopy
{
    return [[PNKeyboardStateListener alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    if (self) {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(didShow) name:UIKeyboardDidShowNotification object:nil];
        [center addObserver:self selector:@selector(didHide) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void) dismissKeyboard {
    if (_keyboardVisible) {
        
        UITextField *tmp = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [[self currentView] addSubview:tmp];
        [tmp becomeFirstResponder];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.25];
        [tmp resignFirstResponder];
        [UIView commitAnimations];
        [tmp removeFromSuperview];
        tmp = nil;
    }
}

- (UIView *) currentView {
    UIWindow *window = [self _topAppWindow];
    
    // add the notification to the screen
    return window.subviews.lastObject;
}

- (UIWindow *)_topAppWindow {
    return ([UIApplication sharedApplication].keyWindow) ?: [[UIApplication sharedApplication].windows lastObject];
}

@end
