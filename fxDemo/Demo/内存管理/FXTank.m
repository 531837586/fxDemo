//
//  FXTank.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/17.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "FXTank.h"

//定义下面的意义，倒数第一位代表向前，倒数第二位代表向后，一个变量就可以表示前后左右，不用再重新定义变量。
#define FXDirectionFrontMask (1 << 0) //代表1左移1位 0000 0001
#define FXDirectionBackMask (1 << 1) //表示1左移1位 0000 0010

@interface FXTank(){
    
//    //联合体
//    union {
//        char bits;
//        //位域
//        struct {
//            char front : 1;
//            char back  : 1;
//            char left  : 1;
//            char right : 1;
//        };
//        
//    } _direction;
}
@end

@implementation FXTank

//- (instancetype)init {
//    self = [super init];
//    if (self) {
////        _direction.bits = 0b00000000; //二进制
//    }
//    return self;
//}
//
//- (void)setFront:(BOOL)isFront {
//    if(isFront){
////        _direction.bits |= FXDirectionFrontMask;
//    } else {
////        _direction.bits |= ~FXDirectionBackMask;
//    }
//}
//
//- (BOOL)isFront {
//    return _direction.bits;
//}
//
//- (void)setBack:(BOOL)isBack {
//    _direction.back = isBack;
//}
//
//- (BOOL)isBack {
//    return _direction.back;
//}

- (void)dealloc{
    NSLog(@"FXTank 析构函数");
}
@end
