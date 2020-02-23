//
//  UnitTestVC.h
//  fxDemo
//
//  Created by 樊星 on 2020/2/11.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UnitTestVC : BaseViewController

- (BOOL)login:(NSString *)account password:(NSString *)password;

- (void)loadManyDatas;

- (void)requestData:(void(^)(id data))dataBlock;
@end

NS_ASSUME_NONNULL_END
