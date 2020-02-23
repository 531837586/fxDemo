//
//  UINavigationController+FXLeaks.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/23.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "UINavigationController+FXLeaks.h"
#import "NSObject+FXLeaks.h"

extern const void* const kFXHasBeenPoppedKey;

@implementation UINavigationController (FXLeaks)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self fx_hookOrigInstanceMenthod:@selector(popViewControllerAnimated:) newInstanceMenthod:@selector(fx_popViewControllerAnimated:)];
    });
}

- (UIViewController *)fx_popViewControllerAnimated:(BOOL)animated{
    UIViewController *popView = [self fx_popViewControllerAnimated:animated];
    objc_setAssociatedObject(popView, kFXHasBeenPoppedKey, @(YES), OBJC_ASSOCIATION_RETAIN);
    return popView;
}
@end
