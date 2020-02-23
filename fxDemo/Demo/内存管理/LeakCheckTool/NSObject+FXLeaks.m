//
//  NSObject+FXLeaks.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/23.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "NSObject+FXLeaks.h"

@implementation NSObject (FXLeaks)

- (void)fx_willDealloc{
    
    __weak id weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong id strongSelf = weakSelf;
        NSLog(@"来了");
        [strongSelf assertNotDealloc];
    });
}

- (void)assertNotDealloc{
    
    NSLog(@"Leaks %@", NSStringFromClass([self class]));
//    UIAlertController *alertVC = [[UIAlertController alloc] init];
//    alertVC.title = @"内存泄露";
//    alertVC.message = NSStringFromClass([self class]);
}

/**
 对象方法交换

 @param oriSEL 原始方法
 @param swizzledSEL 新交换方法
 @return 交换结果
 */
+ (BOOL)fx_hookOrigInstanceMenthod:(SEL)oriSEL newInstanceMenthod:(SEL)swizzledSEL{
    Class cls = self;
    Method oriMethod = class_getInstanceMethod(cls, oriSEL);
    Method swiMethod = class_getInstanceMethod(cls, swizzledSEL);
    
    if (!swiMethod) {
        return NO;
    }
    if (!oriMethod) {
        class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
        method_setImplementation(swiMethod, imp_implementationWithBlock(^(id self, SEL _cmd){ }));
    }
    
    BOOL didAddMethod = class_addMethod(cls, oriSEL, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }else{
        method_exchangeImplementations(oriMethod, swiMethod);
    }
    return YES;
}
@end
