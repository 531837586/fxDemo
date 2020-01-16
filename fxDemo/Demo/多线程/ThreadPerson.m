//
//  ThreadPerson.m
//  fxDemo
//
//  Created by 樊星 on 2020/1/14.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "ThreadPerson.h"

@implementation ThreadPerson
- (void)study:(id)time{
    for (int i = 0; i<[time intValue]; i++) {
        NSLog(@"%@ 开始学习了 %d分钟",[NSThread currentThread],i);
    }
}
@end
