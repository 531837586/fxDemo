//
//  UIViewController+FXLeaks.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/23.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "UIViewController+FXLeaks.h"
#import "NSObject+FXLeaks.h"

@implementation UIViewController (FXLeaks)

const void* const kFXHasBeenPoppedKey = &kFXHasBeenPoppedKey;

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self fx_hookOrigInstanceMenthod:@selector(viewWillAppear:) newInstanceMenthod:@selector(fx_viewWillAppear:)];
        [self fx_hookOrigInstanceMenthod:@selector(viewDidDisappear:) newInstanceMenthod:@selector(fx_viewDidDisappear:)];
    });
}

// 页面进来 - key no
// 页面出去 - key - YES - lg_willDealloc 告诉析构 - dealloc
- (void)fx_viewWillAppear:(BOOL)animated{
    [self fx_viewWillAppear:animated];
    
    objc_setAssociatedObject(self, kFXHasBeenPoppedKey, @(NO), OBJC_ASSOCIATION_RETAIN);
}

- (void)fx_viewDidDisappear:(BOOL)animated{
    [self fx_viewDidDisappear:animated];
    
    if ([objc_getAssociatedObject(self, kFXHasBeenPoppedKey) boolValue]) {
        [self fx_willDealloc];
    }
}


@end
