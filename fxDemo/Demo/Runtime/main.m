//
//  main.m
//  fxDemo
//
//  Created by 樊星 on 2019/3/6.
//  Copyright © 2019 樊星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RuntimePerson.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "RuntimeStudent.h"

//extern void instrumentObjcMessageSends(BOOL);
extern void instrumentObjcMessageSends(BOOL);

extern void instrumentObjcMessageSends(BOOL);



//int main(int argc, const char * argv[]) {

int main(int argc, char * argv[]) { 
    @autoreleasepool {
//        instrumentObjcMessageSends(YES);
//        [RuntimePerson  walk];
//        instrumentObjcMessageSends(NO);

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


//void run(){
//    NSLog(@"%s", __func__);
//}

//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        // OC 对象 -- 本质 -- 结构体
//        // clang
//        RuntimePerson *person = [RuntimePerson new];
//        RuntimeStudent *student = [RuntimeStudent new];
//        // LGPerson *p = ((Runtime *(*)(id, SEL))(void *)objc_msgSend)
//        // ((id)objc_getClass("RuntimePerson"), sel_registerName("new"));
//        // objc_msgSend ?
//        // 方法的本质 --- 发送消息
//        // 消息的组成
//        // ((void (*)(id, SEL))(void *)objc_msgSend)((id)p, sel_registerName("run"));
//        // void *)objc_msgSend)(id)p 消息接受这
//        // sel_registerName("run") 方法编号 --- name
//        // imp 函数实现的指针 -- sel -> imp ?
//        // 下层通讯  方法 -- 对象 类
//        // 父类发送消息
//        instrumentObjcMessageSends(YES);
//        [person run];
//        instrumentObjcMessageSends(NO);
////        ()objc_msgSend(person, sel_registreName("run"));
//
////          Method setterM = class_getInstanceMethod([person class], setterSEL);
////        ((id (*)(id, SEL ))objc_msgSend)(person, NSSelectorFromString(@"run")); //向对象发送消息（对象方法）
//
////        ((id (*)(id, SEL ))objc_msgSend)(objc_getClass("RuntimePerson"), NSSelectorFromString(@"walk")); //向类发送消息（类方法）
//
////        struct objc_super mySuper;
////        mySuper.receiver = student;
////        mySuper.super_class = class_getSuperclass([student class]);
////        ((id (*)(id, SEL ))objc_msgSendSuper)((__bridge id)(&mySuper), @selector(run)); //向父类发送对象消息（对象方法）
////
////        struct objc_super myClassSuper;
////        myClassSuper.receiver = [student class];
////        myClassSuper.super_class = class_getSuperclass(object_getClass([student class]));
////        ((id (*)(id, SEL ))objc_msgSendSuper)((__bridge id)(&myClassSuper), @selector(walk));
////        //向父类发送类消息（类方法）
//
////        UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
//}
