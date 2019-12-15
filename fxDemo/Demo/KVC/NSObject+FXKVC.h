//
//  NSObject+FXKVC.h
//  fxDemo
//
//  Created by 樊星 on 2019/12/13.
//  Copyright © 2019 樊星. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FXKVC)

- (void)fx_setValue:(nullable id)value forKey:(NSString *)key;

- (nullable id)fx_valueForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
