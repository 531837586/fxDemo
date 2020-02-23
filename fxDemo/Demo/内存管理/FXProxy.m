//
//  FXProxy.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/23.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "FXProxy.h"
#import "CrashStackTool.h"

@interface FXProxy()
@property (nonatomic, weak) id object;
@end

@implementation FXProxy

+ (instancetype)proxyWithTransformObject:(id)object{
    FXProxy *proxy = [FXProxy alloc];
    proxy.object = object;
    return proxy;
}

- (BOOL)resolveInstanceMethod:(SEL)sel{
    
    if(self.object){
        return [self.object resolveInstanceMethod:sel];
    }else{
        return [CrashStackTool resolveInstanceMethod:@selector(uploadCreashStack)];
    }
}

// sel - imp -
// 消息转发 self.object
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    
    if (self.object) {
        return [self.object methodSignatureForSelector:sel];
    }else{
//        return [self methodSignatureForSelector:@selector(uploadCreashStack)];
        return [CrashStackTool methodSignatureForSelector:@selector(uploadCreashStack)];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    if (self.object) {
         [invocation invokeWithTarget:self.object];
     }else{
         // add imp - 动态创建 - imp
         // imp 常规 -- pop
         // 收集奔溃信息
         NSLog(@"麻烦上传 stack");
         [CrashStackTool uploadCreashStack];
     }
}

- (void)uploadCreashStack{
    
}
 
@end
