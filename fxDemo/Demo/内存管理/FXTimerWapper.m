//
//  FXTimerWapper.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/23.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "FXTimerWapper.h"

@interface FXTimerWapper()
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL aSelector;
@property (nonatomic, strong) NSTimer *timer;
@end
 
@implementation FXTimerWapper
- (instancetype)fx_initWIthTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo{
    if(self == [super init]){
        self.target = aTarget;
        self.aSelector = aSelector;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(fireHome) userInfo:userInfo repeats:YES];
    }
    return self;
}
                      
                      
- (void)fireHome{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    //让编译器出栈，恢复状态，继续编译后续的代码
    if ([self.target respondsToSelector:self.aSelector]) {
        [self.target performSelector:self.aSelector];
    }
#pragma clang diagnostic pop
    NSLog(@"wapper_fireHome");
}

- (void)fx_invalidate {
    [self.timer invalidate];
    self.timer = nil;
}

-(void)dealloc{
    NSLog(@"%s", __func__);
}

@end
