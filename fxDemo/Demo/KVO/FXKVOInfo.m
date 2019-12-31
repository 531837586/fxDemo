//
//  FXKVOInfo.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/27.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "FXKVOInfo.h"

@implementation FXKVOInfo
//- (instancetype)initWithObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(FXKeyValueObservingOptions)options{
//    if(self = [super init]) {
//        self.observer = observer;
//        self.keyPath = keyPath;
//        self.options = options;
//    }
//    return self;
//}

- (instancetype)initWithObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(FXKeyValueObservingOptions)options handBlock:(FXKVOBlock)handBlock{
     if(self = [super init]) {
        self.observer = observer;
        self.keyPath = keyPath;
        self.options = options;
        self.handBlock = handBlock;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"FXKVOInfo 走了");
}
@end
