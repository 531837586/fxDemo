//
//  NSObject+FXLeaks.h
//  fxDemo
//
//  Created by 樊星 on 2020/2/23.
//  Copyright © 2020 樊星. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FXLeaks)
+ (BOOL)fx_hookOrigInstanceMenthod:(SEL)oriSEL newInstanceMenthod:(SEL)swizzledSEL;
- (void)fx_willDealloc;
@end

NS_ASSUME_NONNULL_END
