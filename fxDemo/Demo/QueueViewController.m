//
//  QueueViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/5/31.
//  Copyright © 2019 樊星. All rights reserved.
//
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#import "QueueViewController.h"
#import "LogView.h"

@interface QueueViewController ()

@end

@implementation QueueViewController{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubView];
}

-(void)configSubView{
    
    CGFloat itemWidth  = SCREEN_WIDTH;
    CGFloat itemHeight = 50;
    CGFloat itemY      = 10+STATUS_AND_NAV_BAR_HEIGHT;
    CGFloat itemMargin = 0;
    
    UILabel *text1Label = [[UILabel alloc] initWithFrame:CGRectMake(itemMargin, itemY, itemWidth, itemHeight)];
    text1Label.numberOfLines = 0;
    text1Label.backgroundColor = COLOR_RANDOM;
    text1Label.text = @"串行队列：按照指派的顺序来执行任务，前一个执行完下一个才能执行";
    [self.view addSubview:text1Label];
    [text1Label onClick:^(id obj) {
        [self test1];
    }];
    
    itemY += 50;
    UILabel *text2Label = [[UILabel alloc] initWithFrame:CGRectMake(itemMargin, itemY, itemWidth, itemHeight)];
    text2Label.numberOfLines = 0;
    text2Label.backgroundColor = COLOR_RANDOM;
    text2Label.text = @"并行队列：能够同时执行一个或多个任务，执行任务的顺序并不一定";
    [self.view addSubview:text2Label];
    [text2Label onClick:^(id obj) {
//        for (int i = 10000; i > 0; i--) {
            [self test2];
//        }
    }];
    
    LogView *logView = [[LogView alloc] initWithFrame:CGRectMake(0, 500, SCREEN_WIDTH, SCREEN_HEIGHT-500)];
    [self.view addSubview:logView];
}

-(void)test2{
    dispatch_queue_t globalQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_async(globalQueue, ^{
        NSLog(@"任务1"); //任务一
    });
    dispatch_async(globalQueue, ^{
        NSLog(@"任务2"); //任务二
    });
    dispatch_async(globalQueue, ^{
        NSLog(@"任务3"); //任务三
    });
}

-(void)test1{
    dispatch_queue_t serialQueue=dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        NSLog(@"任务1"); //任务一
    });
    dispatch_async(serialQueue, ^{
        NSLog(@"任务2"); //任务二
    });
    dispatch_async(serialQueue, ^{
        NSLog(@"任务3"); //任务三
    });
}
@end
