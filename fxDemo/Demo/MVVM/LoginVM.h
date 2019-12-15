//
//  LoginVM.h
//  fxDemo
//
//  Created by 樊星 on 2019/6/19.
//  Copyright © 2019 樊星. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginVM : NSObject

// 账号
@property (nonatomic, strong) NSString *username;

// 密码
@property (nonatomic, strong) NSString *password;

//邮箱
@property (nonatomic, strong) NSString *mail;

//账号密码登录
@property (nonatomic, strong, readwrite) RACCommand *passwordLoginCommand;

@end

NS_ASSUME_NONNULL_END
