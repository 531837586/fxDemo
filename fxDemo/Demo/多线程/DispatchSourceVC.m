//
//  DispatchSourceVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/1/16.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "DispatchSourceVC.h"

@interface DispatchSourceVC ()

@end

@implementation DispatchSourceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    dispatch - 宏
//    编译非常难看
//    名字特长
//    os
//    嵌套比较深
    
//    问题的形式进行
    
//    [self demoQueueCreat];
    [self dis_semaphoreSource];
 
}

- (void)dis_groupSource{
//    _dispatch_object_alloc
//    dispatch_group_create();
//    -1
//    dispatch_group_enter("a");
//    +1
//    dispatch_group_leave("a");
//
//    dispatch_group_notify(NULL, NULL, NULL);
}

- (void)dis_semaphoreSource{
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(1);
    
//    相当于线程通过数-1为0，阻塞，直到通过数部位0。
    dispatch_wait(sem, DISPATCH_TIME_FOREVER);
    
    NSLog(@"&*&*&**&");
//    相当于线程通过数+1
    dispatch_semaphore_signal(sem);
     
}

- (void)dispatch_onceSource{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

- (void)functionSource{
    
    // 源码分析 -- dispatch_sync 同步函数
    // 同步并发
    // 同步串行
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        
    });
    
//    异步并发 -- 特殊 -- 创建线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
}

- (void)demoQueueCreat{
    
//    1. 队列是如何产生的
//    2. 串行 VS 并发
    //OS_dispatch_queue_concurrent -- 宏定义拼接
    dispatch_queue_t queue = dispatch_queue_create("com.fanxing.cn", NULL);
    NSLog(@"%@", queue);
    dispatch_queue_t queue1 = dispatch_queue_create("com.fanxign1.cn", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"%@", queue1);
 
    
    dispatch_queue_t queueMain = dispatch_get_main_queue();
    NSLog(@"%@", queueMain);
    dispatch_queue_t queuegloble = dispatch_get_global_queue(0, 0);
    NSLog(@"%@", queuegloble);
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
