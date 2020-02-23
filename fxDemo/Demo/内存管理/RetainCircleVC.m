//
//  RetainCircleVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/21.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "RetainCircleVC.h"
#import "GVObject.h"

typedef void(^FXBlock)(void);
typedef void(^FXBlockVC)(RetainCircleVC *);

@interface RetainCircleVC ()
@property (nonatomic, copy) NSString *nameStr;
@property (nonatomic, copy) FXBlock block;
@property (nonatomic, copy) FXBlockVC blockVC;
@end

@implementation RetainCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self retainCircle];
//    [self retainCircle2];
//    [self retainCircle3];
    [self retainCircle4Leaks];
    
//    self.nameStr  = @"fanxing";
//    self.block = ^{
//        NSLog(@"%@",self.nameStr);
//    };
}

- (void)retainCircle4Leaks{
    // 创建两个对象a和b
     GVObject *a = [GVObject new];
     GVObject *b = [GVObject new];
     
     // 互相引用对方
     a.obj = b;
     b.obj = a;
}

- (void)retainCircle3{
    self.nameStr = @"fanxing";
    self.blockVC = ^(RetainCircleVC *vc) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@", vc.nameStr);
        });
    };
    self.blockVC(self);
}

- (void)retainCircle2{
    self.nameStr = @"fanxing";
//    self -> block -> self
    __block RetainCircleVC *vc = self;
    self.block = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@", vc.nameStr);
            vc = nil;
        });
    };
    self.block();
}

- (void)retainCircle{
    self.nameStr = @"fanxing";
    __weak typeof(self) weakSelf = self;
    self.block = ^{
//        __strong typeof (weakSelf) strongself = weakSelf;
//        __strong typeof(self) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             NSLog(@"%@", weakSelf.nameStr);
        });
    };
    self.block();
}

- (void)dealloc{
//    [super dealloc];
    NSLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    RetainCircleVC *vc = [RetainCircleVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
