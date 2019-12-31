//
//  Person.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/18.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "KVOPerson.h"

@implementation KVOPerson
static KVOPerson *object=nil;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object = [KVOPerson new];
    });
    return object;
}

//- (void)walk{
//    
//}

//- (void)setName:(NSString *)name{
//    [self willChangeValueForKey:@"name"];
//    _name = name;
//    [self didChangeValueForKey:@"name"];
//}
//
//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
////    if([key isEqualToString:@"name"]){
////        return YES;
////    }
//    return NO;
//}
@end
