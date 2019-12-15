//
//  Person.h
//  fxDemo
//
//  Created by 樊星 on 2019/12/11.
//  Copyright © 2019 樊星. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject {
    NSString *name;
    NSString *_name;
    NSString *_isName;
    NSString *isName;
//    NSMutableArray *array;
}
@property (nonatomic, copy)   NSString *subject;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, copy)   NSMutableArray *array;
@end

NS_ASSUME_NONNULL_END
