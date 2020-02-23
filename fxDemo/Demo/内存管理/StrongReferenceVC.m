//
//  StrongReferenceVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/21.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "StrongReferenceVC.h"
#import "FXTimerWapper.h"
#import "FXProxy.h"

static int num = 0;

@interface StrongReferenceVC ()
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) FXTimerWapper *timerWapper;
@property (nonatomic, strong) FXProxy       *proxy;

@end

@implementation StrongReferenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireHome) userInfo:nil repeats:YES];
//    self.timerWapper = [[FXTimerWapper alloc] fx_initWIthTimeInterval:1 target:self selector:@selector(fireHome) userInfo:nil repeats:YES];
    
//    [self testTimerBlock];
    
    [self testProxy];
}

- (void)testProxy{
    self.proxy = [FXProxy proxyWithTransformObject:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.proxy selector:@selector(fireHome) userInfo:nil repeats:YES];
}

- (void)testTimerBlock{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"hello word");
    }];
}

- (void)fireHome{
    num++;
    NSLog(@"hello word - %d",num);
}

- (void)didMoveToParentViewController:(UIViewController *)parent{
//    if (parent == nil) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)dealloc{
//    [self.timer invalidate];
//    self.timer = nil;
//    [self.timerWapper fx_invalidate];
    self.proxy = nil;
    NSLog(@"%s", __func__);
}



@end
