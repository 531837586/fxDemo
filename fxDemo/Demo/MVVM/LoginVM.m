//
//  LoginVM.m
//  fxDemo
//
//  Created by 樊星 on 2019/6/19.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "LoginVM.h"

@implementation LoginVM

#pragma mark ================= 校验格式是否正确 =================

-(RACSignal *)validLoginSignal{
    return  [[RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password), RACObserve(self, mail)]
                               reduce:^(NSString *username, NSString *password, NSString *mail){
                                   return @(username.length > 0 && password.length > 0 && mail.length > 0);
                               }] distinctUntilChanged];
}

-(RACCommand *)passwordLoginCommand{
    if (_passwordLoginCommand==nil) {
        _passwordLoginCommand = [[RACCommand alloc] initWithEnabled:self.validLoginSignal signalBlock:
                                 ^RACSignal *(id input) {
                                     return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
//                                         if([JCValidation checkTelNumber:self.username]){
//                                             [[[LoginServes shareInstance] rac_login:self.username password:self.password] subscribeNext:^(JCHttpResponseModel *x) {
//                                                 [subscriber sendNext:x];
//                                             } error:^(NSError * _Nullable error){
//                                                 [subscriber sendError:error];
//                                             } completed:^{
//                                                 [subscriber sendCompleted];
//                                             }];
//                                         }else{
//                                             [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号!"];
//                                             [subscriber sendCompleted];
//                                         }
                                         [subscriber sendCompleted];
                                         return nil;
                                     }];
                                 }];
    }
    return _passwordLoginCommand;
}

@end
