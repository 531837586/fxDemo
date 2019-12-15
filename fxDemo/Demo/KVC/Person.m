//
//  Person.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/11.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "Person.h"

@implementation Person
#pragma mark - set相关
- (void)setName:(NSString *)name{
    NSLog(@"%s",__func__);
}
- (void)_setName:(NSString *)name{
    NSLog(@"%s",__func__);
}
- (void)setIsName:(NSString *)isName{
    NSLog(@"%s",__func__);
}

#pragma mark - get相关
- (NSString *)getName{
    NSLog(@"%s",__func__);
    return NSStringFromSelector(_cmd);
}
- (NSString *)name{
    NSLog(@"%s",__func__);
    return NSStringFromSelector(_cmd);
}
- (NSString *)isName{
    NSLog(@"%s",__func__);
    return NSStringFromSelector(_cmd);
}
- (NSString *)_name{
    NSLog(@"%s",__func__);
    return NSStringFromSelector(_cmd);
}

#pragma mark - 关闭或开启实例变量赋值
//是否开启间接访问变量
+ (BOOL)accessInstanceVariablesDirectly{
    return YES;
}

- (void)insertObject:(id)object inArrayAtIndex:(NSUInteger)index {
    NSLog(@"%ld", index);
}
- (void)removeObjectFromArrayAtIndex:(NSUInteger)index {
    NSLog(@"%ld", index);
}

//数组valueForKey会调用的方法
// 个数
- (NSUInteger)countOfFxArray {
    return [self.array count];
}

//// 获取值
- (id) objectInFxArrayAtIndex:(NSUInteger)index {
    return [NSString stringWithFormat:@"fxArray %lu", index];
}

// 是否包含这个成员对象
- (id)memberOfFxArray:(id)object {
    return [self.array containsObject:object] ? object : nil;
}

// 迭代器
- (id)enumeratorOfFxArray {
    // objectEnumerator
    return [self.array reverseObjectEnumerator];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"description"];
}

@end
