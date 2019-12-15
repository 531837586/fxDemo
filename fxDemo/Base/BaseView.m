//
//  BaseView.m
//  fxDemo
//
//  Created by 樊星 on 2019/5/31.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self configSubView];
    }
    return self;
}

-(instancetype) initWithNibFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
        self.frame = frame;
    }
    return self;
}

-(void)configSubView{}
@end
