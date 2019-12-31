////
////  RACLoginViewController.m
////  fxDemo
////
////  Created by 樊星 on 2019/6/19.
////  Copyright © 2019 樊星. All rights reserved.
////
//
//#import "RACLoginViewController.h"
//#import "LoginVM.h"
//
//@interface RACLoginViewController ()
//@property (nonatomic, strong) LoginVM *loginVM;
//
//@end
//
//@implementation RACLoginViewController
//
//-(LoginVM *)loginVM{
//    if(!_loginVM) _loginVM = [LoginVM new];
//    return _loginVM;
//}
//
//-(RACSubject *)delegateSignal{
//    if(!_delegateSignal){
//        _delegateSignal = [RACSubject subject];
//    }
//    return _delegateSignal;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    [self blindData];
//}
//
//- (void)blindData{
//    
//    [self.loginBtn setBackgroundImage:[FXUtils imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(374, 30)] forState:UIControlStateDisabled];
//    [self.loginBtn setBackgroundImage:[FXUtils imageWithColor:[UIColor blueColor] size:CGSizeMake(374, 30)] forState:UIControlStateNormal];
//    
//    RAC(self.loginVM, username)     = self.name.rac_textSignal;
//    RAC(self.loginVM, password)     = self.pwd.rac_textSignal;
//    RAC(self.loginVM, mail)         = self.mail.rac_textSignal;
//    
//    self.loginBtn.rac_command = self.loginVM.passwordLoginCommand;
//    
//    [[self.loginBtn.rac_command executionSignals] subscribeNext:^(RACSignal<id> * _Nullable x) {
//        
//    } error:^(NSError * _Nullable error) {
//        
//    } completed:^{
//        
//    }];
//    
//    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        // 通知代理
//        // 判断代理信号是否有值
//        if (self.delegateSignal) {
//            // 有值，才需要通知
//            for (int i = 0; i < 5000; i++) {
//                [self.delegateSignal sendNext:[NSString stringWithFormat:@"%d", i]];
//            }
////            [self.delegateSignal sendNext:@"1"];
//        }
//    }];
//}
//@end
