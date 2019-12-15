
//
//  FXUtils.m
//  fxDemo
//
//  Created by 樊星 on 2019/4/15.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "FXUtils.h"

@implementation FXUtils

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
