//
//  KVOStudent.h
//  fxDemo
//
//  Created by 樊星 on 2019/12/18.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "KVOPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface KVOStudent : KVOPerson{
    @public
    NSString *age;
//    NSString *name;
}
@property (nonatomic, strong)   NSString *name;
@property (nonatomic, assign) int progress;
@property (nonatomic, assign) int total;
@property (nonatomic, assign) int download;
@property (nonatomic, strong) NSMutableArray *dataArray;

-(void)walk;
@end

NS_ASSUME_NONNULL_END
