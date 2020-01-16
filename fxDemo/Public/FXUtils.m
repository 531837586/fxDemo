
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

+ (NSString *)getPlaceStr{
    return @"2020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD42020-01-08 23:32:35.453016+0800 fxDemo[48460:6798099] !@#2020-01-08 23:32:35.453164+0800 fxDemo[48460:6798099] kCFRunLoopDefaultMode2020-01-08 23:32:43.106691+0800 fxDemo[48460:6798218] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x600000e4dba0> F8BB1C28-BAE8-11D6-9C31-00039315CD4";
}
@end
