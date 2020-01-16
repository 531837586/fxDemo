//
//  GCDViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/2.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) id headData;
@property (nonatomic, strong) id listData;
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation GCDViewController

- (NSMutableArray *)mArray{
    if (!_mArray) {
        _mArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _mArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testDemo1];
//    [self syncTest];
//    [self testDemo];
//    [self testDemo2];
//    [self testDemo3];
    [self testDemo4];
//    [self testDemo5];
//    [self testDemo6];
//    [self testDemo7];
}

- (void)syncTest{
    
    //把任务添加到队列 --> 函数
    //任务 _t ref c对象
    dispatch_block_t block = ^{
        NSLog(@"hello GCD");
    };
    
    //第一个参数标识，第二个串行还是并行
    dispatch_queue_t queue = dispatch_queue_create("com.fanxing.cn", NULL);
    
    //函数
    dispatch_async(queue, block);
}

- (void)testDemo{
    
//    并发队列
    dispatch_queue_t serialQueue = dispatch_queue_create("my.serialQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
//    异步函数，不阻塞线程
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        //    异步函数，不阻塞线程
        dispatch_async(serialQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    
//    1，5，2，4，3
}

- (void)testDemo7{
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("fanxing", DISPATCH_QUEUE_CONCURRENT);
    
//    栈栏函数：
//    1. 保证顺序执行
//    2. 保证线程安全
//    注意点：
//    3. 一定要是自定义的并发队列
//    4. 不是非常优秀
//    5. 只阻塞当前的自定义并发队列
    
    for (int i = 0; i < 2000; i++){
        dispatch_async(concurrentQueue, ^{
            UIImage *image = [UIImage imageNamed:@"timg"];
            dispatch_barrier_sync(concurrentQueue, ^{
                //同一时间，多条线程访问array数据结构
                //底层还会调用查，插入，导致下层数据混乱
                [self.mArray addObject:image];
            });
        });
    }
}


 

#pragma mark - 栈栏函数：dispatch_barrier_sync/dispatch_barrier_async

- (void)testDemo8{
    
    //你全部下载完毕之后，我才能处理
    dispatch_queue_t concurrentQueue = dispatch_queue_create("fanxing", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t concurrentQueue1 = dispatch_queue_create("fanxing", DISPATCH_QUEUE_CONCURRENT);

    //异步函数
    dispatch_async(concurrentQueue, ^{
       for (int i = 0; i < 5; i++) {
           NSLog(@"download1 - %d - %@", i, [NSThread currentThread]);
       }
    });
    dispatch_async(concurrentQueue1, ^{
      for (int i = 0; i < 5; i++) {
          NSLog(@"download2 - %d - %@", i, [NSThread currentThread]);
      }
    });

    //栈栏函数
    //dispatch_barrier_async只堵塞当前的自定义并发队列
    dispatch_barrier_async(concurrentQueue, ^{
       NSLog(@"--------------------%@--------------------", [NSThread currentThread]);
    });
    NSLog(@"加载那么多，喘口气!!!");

    //异步函数
    dispatch_async(concurrentQueue, ^{
       for (NSUInteger i = 0; i < 5; i++) {
           NSLog(@"日常处理3-%zd-%@",i,[NSThread currentThread]);
       }
    });
    NSLog(@"************起来干!!");
     
    dispatch_async(concurrentQueue1, ^{
       for (NSUInteger i = 0; i < 5; i++) {
           NSLog(@"日常处理4-%zd-%@",i,[NSThread currentThread]);
       }
    });
}

- (void)testDemo6{
    
    //你全部下载完毕之后，我才能处理
    dispatch_queue_t concurrentQueue = dispatch_queue_create("fanxing", DISPATCH_QUEUE_CONCURRENT);
    
    //异步函数
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"download1 - %d - %@", i, [NSThread currentThread]);
        }
    });
    dispatch_async(concurrentQueue, ^{
       for (int i = 0; i < 5; i++) {
           NSLog(@"download2 - %d - %@", i, [NSThread currentThread]);
       }
   });
    
    //栈栏函数
    dispatch_barrier_sync(concurrentQueue, ^{
        NSLog(@"--------------------%@--------------------", [NSThread currentThread]);
    });
    NSLog(@"加载那么多，喘口气!!!");
    
    //异步函数
    dispatch_async(concurrentQueue, ^{
        for (NSUInteger i = 0; i < 5; i++) {
            NSLog(@"日常处理3-%zd-%@",i,[NSThread currentThread]);
        }
    });
    NSLog(@"************起来干!!");
      
    dispatch_async(concurrentQueue, ^{
        for (NSUInteger i = 0; i < 5; i++) {
            NSLog(@"日常处理4-%zd-%@",i,[NSThread currentThread]);
        }
    });
}

#pragma mark - //GCD应用
- (void)testDemo5{
    
    //1. 通常的多个请求处理方法
     __weak typeof(self) weakSelf = self;
    [self requestToken:^(id value) {
        weakSelf.token = value;

        [weakSelf requestHeadDataWithToken:value handle:^(id value) {
            NSLog(@"%@",value);
            weakSelf.headData = value;
        }];

        [weakSelf requestListDataWithToken:value handle:^(id value) {
            NSLog(@"%@",value);
            weakSelf.listData = value;
        }];
    }];
    
    //2. 使用全局队列，阻塞主线程
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
   
    dispatch_sync(queue, ^{
        [self requestToken:^(id value) {
            weakSelf.token = value;
        }];
    });

    dispatch_async(queue, ^{
        [weakSelf requestHeadDataWithToken:self.token handle:^(id value) {
            NSLog(@"%@",value);
            weakSelf.headData = value;
        }];
    });

    dispatch_async(queue, ^{
        [weakSelf requestListDataWithToken:self.token handle:^(id value) {
            NSLog(@"%@",value);
            weakSelf.listData = value;
        }];
    });
    
    
    //3. 使用任务的形式封装多个网络请求，不会阻塞主线程，可以执行其他的事情
    dispatch_block_t task = ^{

        dispatch_sync(queue, ^{
            [self requestToken:^(id value) {
                weakSelf.token = value;
            }];
        });

        dispatch_async(queue, ^{
            [weakSelf requestHeadDataWithToken:self.token handle:^(id value) {
                NSLog(@"%@",value);
                weakSelf.headData = value;
            }];
        });

        dispatch_async(queue, ^{
            [weakSelf requestListDataWithToken:self.token handle:^(id value) {
                NSLog(@"%@",value);
                weakSelf.listData = value;
            }];
        });
    };
    dispatch_async(queue, task);
}

/**
 token请求

 @param successBlock 请求回来的token保存 通常还有时效性
 */
- (void)requestToken:(void(^)(id value))successBlock{
    NSLog(@"开始请求token");
    [NSThread sleepForTimeInterval:10];
    successBlock(@"b2a8f8523ab41f8b4b9b2a79ff47c3f1");
}

/**
 头部数据的请求

 @param token token
 @param successBlock 成功数据回调
 */
- (void)requestHeadDataWithToken:(NSString *)token handle:(void(^)(id value))successBlock{
    if (token.length == 0) {
        NSLog(@"没有token,因为安全性无法请求数据");
        return;
    }
    [NSThread sleepForTimeInterval:1];
    successBlock(@"我是头,都听我的");
}
/**
 列表数据的请求
 
 @param token token
 @param successBlock 成功数据回调 --> 刷新列表
 */
- (void)requestListDataWithToken:(NSString *)token handle:(void(^)(id value))successBlock{
    if (token.length == 0) {
        NSLog(@"没有token,因为安全性无法请求数据");
        return;
    }
    [NSThread sleepForTimeInterval:1];
    successBlock(@"我是列表数据");
}


- (void)dealloc{
    NSLog(@"我走了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - //全局队列,主队列
- (void)testDemo4{
    
    //全局队列 -- 并发队列
    //如果需要并发队列不要使用全局队列，因为是系统生成的，如果需要的话最好自己写一个并发队列，和系统的队列分开管理，而且调试也方便。
    //dispatch_get_global_queue(0, 0);
    
    //主队列 -- 串行队列
    //dispatch_get_main_queue();
    
    __block int a = 0; //把a的值和指针地址拷贝到 struct
    
//    用信号量锁
    dispatch_semaphore_t lock = dispatch_semaphore_create(1);
    
    while (a<10) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            a++;
            NSLog(@"%d-%@", a, [NSThread currentThread]);
            dispatch_semaphore_signal(lock);
            
//            @synchronized (@(a)) {
//                a++;
//            }
        });
//        全局并发队列会添加多于10条线程，所以会执行多余10次a++，结果肯定大于10。
        dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER); //阻塞前面的线程，不会出现两条线程a都等于0，所以a一直都是正确的。
    
    }
    NSLog(@"--%d", a);
    sleep(1);//主线程 耗时 阻塞 前面的队列全部执行完成 后面输出的是a真正的值 FIFO
    //a 为什么会报错 __block
    //a 输出的值 >= 10
    //输出a真正的值
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"**%d", a);
    });
}

#pragma mark - //主队列测试
- (void)testDemo3{
    NSLog(@"1");
    dispatch_sync(dispatch_get_main_queue(),^{
        NSLog(@"2");
    });
    NSLog(@"3");
//    1 崩溃
}

#pragma mark - //同步异步测试
- (void)testDemo2{
    
    //    同步队列
        dispatch_queue_t serialQueue = dispatch_queue_create("my.serialQueue", DISPATCH_QUEUE_SERIAL);
        NSLog(@"1");
    //    异步函数，不阻塞线程
        dispatch_async(serialQueue, ^{
            NSLog(@"2");
            //    同步函数阻塞线程
            dispatch_sync(serialQueue, ^{
                NSLog(@"3");
            });
            NSLog(@"4");
        });
        NSLog(@"5");
        
    //    1，5，2 奔溃
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
