//
//  UIView+onClick.h
//  KKTribe
//
//  Created by 樊星 on 2019/4/17.
//  Copyright © 2019 杭州鼎代. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (onClick)
- (void)onClick:(void(^)(id obj))tapAction;//点击
- (void)longPress:(void(^)(id obj))tapAction;//长按
@end


