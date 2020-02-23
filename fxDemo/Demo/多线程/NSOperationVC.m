//
//  NSOperationVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/1/17.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "NSOperationVC.h"

@interface NSOperationVC ()
@property (nonatomic, strong) NSOperationQueue *queue;
@end


@implementation NSOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self demo];
//    [self demo1];
//    [self demo2];
//    [self demo3];
//    [self demo4];
//    [self demo6];
//    [self demo7];
//    [self demo8];
    [self demo9];
}

/**
关于operationQueue的挂起,继续,取消
*/
- (void)demo9{
    
    UILabel *pauseLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    pauseLabel.text = @"暂停";
    [self.view addSubview:pauseLabel];
    [pauseLabel onClick:^(id obj) {
        if(self.queue.operationCount == 0){
            NSLog(@"当前没有操作，没有必要挂起和继续");
            return;
        }
        //一个细节 正在执行的操作无法挂起
        if(self.queue.suspended){
            NSLog(@"当前是挂起状态，准备继续");
        }else{
            NSLog(@"当前为执行状态，准备挂起");
        }
        self.queue.suspended = !self.queue.isSuspended;
    }];
    
    UILabel *pauseLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(200, 100, 100, 50)];
    pauseLabel1.text = @"取消";
    [self.view addSubview:pauseLabel1];
    [pauseLabel1 onClick:^(id obj) {
        
         NSLog(@"点击取消");
        // 执行结果发现,正在执行的操作无法取消,因为这要回想到之前的NSThread
        // 只有在内部判断才能取消完毕
        // 取消操作之后,再点继续,发现没有调度的任务没了
        //取消的是队列里面的任务，已经执行的任务是在线程里面的，已经在执行的任务，所以无法挂起或者取消，只能取消或者挂起队列里面还没有执行的任务
        [self.queue cancelAllOperations];
    }];
    
    self.queue = [[NSOperationQueue alloc] init];
    self.queue.name = @"fanxing";
    self.queue.maxConcurrentOperationCount = 2;
    
    for (int i = 0; i < 20; i++) {
        [self.queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:1.0];
            NSLog(@"%@------%d", [NSThread currentThread], i);
        }];
    }
}

//依赖关系
- (void)demo8{
    
    self.queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *bo1 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"请求token");
    }];
    
    NSBlockOperation *bo2 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"拿着token,请求数据1");
    }];
    
    NSBlockOperation *bo3 = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"拿着数据1,请求数据2");
    }];
    
    //因为异步，不好控制，我们借助依赖
    [bo2 addDependency:bo1];
    [bo3 addDependency:bo2];
    
    //注意这里一定不要构成循环依赖：不会报错，但是所有操作不会执行
//    [bo1 addDependency:bo3];
    //waitUntilFinished 阻塞线程
    [self.queue addOperations:@[bo1, bo2, bo3] waitUntilFinished:YES];
    
    NSLog(@"执行完毕？可以干其他事情了");
}

- (void)demo7{
    self.queue = [[NSOperationQueue alloc] init];
    self.queue.name = @"fanxing";
    self.queue.maxConcurrentOperationCount = 2;
    for (int i = 0; i<10; i++) {
        [self.queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"%d-%@",i,[NSThread currentThread]);
        }];
    };
}

/**
 线程通讯
 */
- (void)demo6{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.name = @"fanxing";
    [queue addOperationWithBlock:^{
        NSLog(@"%@ = %@", [NSOperationQueue currentQueue], [NSThread currentThread]);
        //模拟网络请求
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //在主队列做操作
            NSLog(@"%@ -- %@", [NSOperationQueue currentQueue], [NSThread currentThread]);
        }];
    }];
}

/**
 可执行代码块
 */
- (void)demo5{
    //创建操作
    NSBlockOperation *ob = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    //添加执行代码块
    [ob addExecutionBlock:^{
        NSLog(@"这是一个执行代码块 - %@", [NSThread currentThread]);
    }];
     
    // 执行代码块 在新的线程  创建的操作在当前线程
    //[ob start];
    
    //利用队列,两个都在新的线程中
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue addOperation:ob];
    
}

/**
 优先级,只会让CPU有更高的几率调用,不是说设置高就一定全部先完成
 */
- (void)demo4{
     
    NSBlockOperation *bo1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"第一个操作 %d --- %@", i, [NSThread currentThread]);
        }
    }];
    //设置优先级 - 最高
    bo1.qualityOfService = NSQualityOfServiceUserInteractive;
    
    //创建第二个操作
    NSBlockOperation *bo2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"第二个操作 %d --- %@", i, [NSThread currentThread]);
        }
    }];
    //设置优先级 - 最低
    bo2.qualityOfService = NSQualityOfServiceBackground;
    
    //2: 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //3: 添加到队列
    [queue addOperation:bo1];
    [queue addOperation:bo2];
}

/**
 测试操作与队列的执行效果:异步并发
 */
- (void)demo3{
    
    //这里是异步并发
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    for (int i = 0; i < 20; i++) {
        [queue addOperationWithBlock:^{
            NSLog(@"%@---%d", [NSThread currentThread], i);
        }];
    }
}

/**
 blockOperation 初体验
 */
- (void)demo2{
 
    //1:创建blockOperation
    NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
    //1.1 设置监听
    bo.completionBlock = ^{
        NSLog(@"完成了!!!");
    };
    //2:创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //3:添加到队列
    [queue addOperation:bo];
    
}

- (void)demo1{
    //处理事务
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(handleInvocation:) object:@"fanxing"];
    [op start];
}


- (void)demo{
    
    //NSOperation
    //是一个抽象类，需要子类(NSInvocationOperation)不实现
 
    //处理事务
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(handleInvocation:) object:@"fanxing"];
    
    //创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //操作加入队列
    [queue addOperation:op];
    //如果指定了队列执行，又调用start，就会崩溃
//    [op start];
}

- (void)handleInvocation:(id)op{
    NSLog(@"%@ --- %@", op, [NSThread currentThread]);
}

@end
