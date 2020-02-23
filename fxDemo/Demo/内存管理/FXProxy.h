//
//  FXProxy.h
//  fxDemo
//
//  Created by 樊星 on 2020/2/23.
//  Copyright © 2020 樊星. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXProxy : NSProxy
+ (instancetype)proxyWithTransformObject:(id)object;
@end

NS_ASSUME_NONNULL_END
