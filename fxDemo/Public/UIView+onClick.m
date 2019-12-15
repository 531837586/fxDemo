//
//  UIView+onClick.m
//  KKTribe
//
//  Created by 樊星 on 2019/4/17.
//  Copyright © 2019 杭州鼎代. All rights reserved.
//

#import "UIView+onClick.h"

@implementation UIView (onClick)

- (void)setClickedAction:(void (^)(id))clickedAction{
    objc_setAssociatedObject(self, @"onClick", clickedAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id))clickedAction{
    return objc_getAssociatedObject(self, @"onClick");
}

- (void)onClick:(void(^)(id obj))tapAction{
    self.clickedAction = tapAction;
    // hy:先判断当前是否有交互事件，如果没有的话。。。所有gesture的交互事件都会被添加进gestureRecognizers中
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        // hy:添加单击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
}

- (void)tap{
    if (self.clickedAction) {
        self.clickedAction(self);
    }
}

@end
