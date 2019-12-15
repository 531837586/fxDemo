//
//  UIView+Frame.h
//  KKGameSDK
//
//  Created by 樊星 on 2019/7/26.
//  Copyright © 2019 樊星. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end

NS_ASSUME_NONNULL_END
