//
//  KVOStudent.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/18.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "KVOStudent.h"

@implementation KVOStudent
//- (void)setName:(NSString *)name{
////    [self willChangeValueForKey:@"name"];
////    _name = name;
////    [self didChangeValueForKey:@"name"];
//}

- (void)walk{
    
}

+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key{
    
    NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"progress"]) {
        NSArray *affectingKeys = @[@"total", @"download"];
        keyPaths = [keyPaths setByAddingObjectsFromArray:affectingKeys];
    }
    return keyPaths;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//    if([key isEqualToString:@"name"]){
//        return YES;
//    }
    return YES;
}
@end
