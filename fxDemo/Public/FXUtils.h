//
//  FXUtils.h
//  fxDemo
//
//  Created by 樊星 on 2019/4/15.
//  Copyright © 2019 樊星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXUtils : NSObject
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (NSString *)getPlaceStr;
@end

NS_ASSUME_NONNULL_END
