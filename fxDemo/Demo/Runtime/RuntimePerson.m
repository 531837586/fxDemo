//
//  RuntimePerson.m
//  fxDemo
//
//  Created by 樊星 on 2020/1/1.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "RuntimePerson.h"
#import <objc/runtime.h>
#import "RuntimeDog.h"

@implementation RuntimePerson

//-(void)run{
//    NSLog(@"%s", __func__);
//    NSLog(@"RuntimePerson -- %s", __func__);
//}

//+(void)walk{
//     NSLog(@"RuntimePerson -- %s", __func__);
//}

+(void)readBook {
    NSLog(@"读书");
}

+(void)helloword {
    NSLog(@"helloword");
}

#pragma mark - 动态方法解析

//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    if(sel == @selector(run)) {
//        NSLog(@"对象方法解析走这里");
//        SEL readSEL = @selector(readBook);
//        Method readM = class_getInstanceMethod(self, readSEL);
//        IMP readImp = method_getImplementation(readM);
//        const char *type = method_getTypeEncoding(readM);
//        return class_addMethod(self, sel, readImp, type);
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
//+ (BOOL)resolveClassMethod:(SEL)sel{
////    NSLog(@"来了 老弟 %s", __func__);
//
//    if(sel == @selector(walk)) {
//        NSLog(@"类方法解析走这里");
//        SEL hellowordSEL = @selector(helloword);
//        //类方法就存在我们的原类的方法列表
////        Method hellowordM1 = class_getClassMethod(self, hellowordSEL);
//        Method hellowordM = class_getInstanceMethod(object_getClass(self), hellowordSEL);
//        IMP hellowordImp = method_getImplementation(hellowordM);
//        const char *type = method_getTypeEncoding(hellowordM);
//        NSLog(@"%s", type);
//        return class_addMethod(object_getClass(self), sel, hellowordImp, type);
//    }
//    return  [super resolveClassMethod:sel];
//}

#pragma mark - 消息转发

////对象方法转发
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"%s",__func__);
    if (aSelector == @selector(run)) {
        // 转发给我们的LGStudent 对象
        return [RuntimeDog new];
    }
    return [super forwardingTargetForSelector:aSelector];
}  

//类方法转发流程
+ (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"%s", __func__);
    return [super forwardingTargetForSelector:aSelector];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSLog(@"%s",__func__);
    if (aSelector == @selector(walk)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation{
    NSLog(@"%s",__func__);
    
//    NSString *sto = @"奔跑少年";
    anInvocation.target = [RuntimePerson class];
//    [anInvocation setArgument:&sto atIndex:2];
    NSLog(@"%@",anInvocation.methodSignature);
    anInvocation.selector = @selector(readBook);
    [anInvocation invoke];
    
}

@end
