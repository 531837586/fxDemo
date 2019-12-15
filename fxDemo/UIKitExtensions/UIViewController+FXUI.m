//
//  UIViewController+FXUI.m
//  fxDemo
//
//  Created by 樊星 on 2019/4/16.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "UIViewController+FXUI.h"
#import <objc/runtime.h>

@implementation UIViewController (FXUI)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(description),
            
            @selector(viewDidLoad),
            @selector(viewWillAppear:),
            @selector(viewDidAppear:),
            @selector(viewWillDisappear:),
            @selector(viewDidDisappear:),
            
            @selector(viewWillTransitionToSize:withTransitionCoordinator:)
        };
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); index++) {
//            SEL originalSelector = selectors[index];
//            SEL swizzledSelector = NSSelectorFromString([@"qmuivc_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
//            method_exchangeImplementations(<#Method  _Nonnull m1#>, <#Method  _Nonnull m2#>)([self class], originalSelector, swizzledSelector);
        }
        
        // 修复 iOS 11 scrollView 无法自动适配不透明的 tabBar，导致底部 inset 错误的问题
        // https://github.com/Tencent/QMUI_iOS/issues/218
//        if (@available(iOS 11, *)) {
//            ExchangeImplementations([UIViewController class], @selector(initWithNibName:bundle:), @selector(qmuivc_initWithNibName:bundle:));
//        }
    });
}

@end
