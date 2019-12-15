//
//  GCDViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/2.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testDemo1];
}

- (void)testDemo{
    
    dispatch_queue_t serialQueue = dispatch_queue_create("my.serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serialQueue, ^{
        NSLog(@"1");
        NSLog(@"1%@", [NSThread currentThread]);
    });
    NSLog(@"2");
    dispatch_sync(serialQueue, ^{
        NSLog(@"3");
        NSLog(@"3%@", [NSThread currentThread]);
    });
    NSLog(@"4");
}

- (void)testDemo1{
    
    __block int a = 0;
    while (a<10) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            a+=1;
            NSLog(@"realA:%d", a);
        });
    }
//    NSLog(@"%d", a);
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
