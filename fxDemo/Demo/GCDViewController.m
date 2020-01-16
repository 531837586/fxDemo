//
//  GCDViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/2.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "GCDViewController.h"
#import "KC_ImageTool.h"

@interface GCDViewController ()
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) id headData;
@property (nonatomic, strong) id listData;
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) dispatch_source_t source;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, assign) NSUInteger totalComplete;

@property (strong, nonatomic)   UIProgressView *progressView;
@property (nonatomic) BOOL isRunning;
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
//    [self testDemo4];
//    [self testDemo5];
//    [self testDemo6];
//    [self testDemo7];
//    [self testDemo8];
//    [self testDemo9];
//    [self testDemo10];
//    [self testDemo11];
    [self testDemo12];
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

#pragma mark - dispatch_source
- (void)testDemo12{
    
   
    
    self.totalComplete = 0;
    self.queue = dispatch_queue_create("com.fanxing.cn", 0);
    
    // source -- runloop source
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    /**
        第一个参数：dispatch_source_type_t type为设置GCD源方法的类型，前面已经列举过了。
        第二个参数：uintptr_t handle Apple的API介绍说，暂时没有使用，传0即可。
        第三个参数：unsigned long mask Apple的API介绍说，使用DISPATCH_TIMER_STRICT，会引起电量消耗加剧，毕竟要求精确时间，所以一般传0即可，视业务情况而定。
        第四个参数：dispatch_queue_t _Nullable queue 队列，将定时器事件处理的Block提交到哪个队列之上。可以传Null，默认为全局队列。
        注意：当提交到全局队列的时候，时间处理的回调内，需要异步获取UI线程，更新UI...不过这好像是常识，又啰嗦了...
        */
    //1. 封装计时器时比较准确
    //2. 操作麻烦，如果设置了回调信息，一定要dispatch_resume，默认是挂起的。
    //3.应用： 参考LGGXDTimer类，可以封装一些计时器要比 timer 准确灵活，独立，不受runloop影响。也可以做响应回调参考
    self.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    
    //保存代码块 ---> 异步dispatch_source_set_event_handle()
    //设置取消回调 dispatch_source_set_cancel_handler(dispatch_source_t source,dispatch_block_t _Nullable handler)
    //封装我们需要回调的触发函数 -- 响应
    dispatch_source_set_event_handler(self.source, ^{
       NSUInteger value = dispatch_source_get_data(self.source); // 取回来值 1 响应式
        self.totalComplete += value;
        NSLog(@"进度：%.2f", self.totalComplete/100.0);
        self.progressView.progress = self.totalComplete/100.0;
    });
    self.isRunning = YES;
    dispatch_resume(self.source);
    

    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
//    [btn setBackgroundImage:[UIImage imageNamed:@"kk_game_login_top_V_background2"] forState:UIControlStateNormal];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(didClickStartOrPauseAction:) forControlEvents:UIControlEventTouchUpInside];
   
    UILabel *btn = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:btn];
    btn.text = @"暂停/恢复";
    [btn onClick:^(id obj) {
            if (self.isRunning) {// 正在跑就暂停
                dispatch_suspend(self.source);
                dispatch_suspend(self.queue);// mainqueue 挂起
                self.isRunning = NO;
//                [sender setTitle:@"暂停中..." forState:UIControlStateNormal];
                btn.text = @"暂停中...";
            }else{
                dispatch_resume(self.source);
                dispatch_resume(self.queue);
                self.isRunning = YES;
//                [sender setTitle:@"加载中..." forState:UIControlStateNormal];
                btn.text = @"加载中...";
            }
    }];
    
    UILabel *btn1 = [[UILabel alloc] initWithFrame:CGRectMake(200, 100, 100, 50)];
    [btn1 setBackgroundColor:[UIColor redColor]];
    btn1.text = @"点击开始下载";
    [self.view addSubview:btn1];
    [btn1 onClick:^(id obj) {
        NSLog(@"点击开始加载");
        for (NSUInteger index = 0; index < 100; index++) {
               dispatch_async(self.queue, ^{
                   if (!self.isRunning) {
                       NSLog(@"暂停下载");
                       return ;
                   }
                   sleep(1);

                   dispatch_source_merge_data(self.source, 1); // source 值响应
               });
           }
    }];
      
  self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(100, 200, 100, 10)];
  self.progressView.backgroundColor = [UIColor grayColor];
  self.progressView.tintColor = [UIColor blueColor];
  [self.view addSubview:self.progressView];
}

//- (void)didClickStartOrPauseAction:(id)sender {
//
//    if (self.isRunning) {// 正在跑就暂停
//        dispatch_suspend(self.source);
//        dispatch_suspend(self.queue);// mainqueue 挂起
//        self.isRunning = NO;
//        [sender setTitle:@"暂停中..." forState:UIControlStateNormal];
//    }else{
//        dispatch_resume(self.source);
//        dispatch_resume(self.queue);
//        self.isRunning = YES;
//        [sender setTitle:@"加载中..." forState:UIControlStateNormal];
//    }
//}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"点击开始加载");
//
//    for (NSUInteger index = 0; index < 100; index++) {
//        dispatch_async(self.queue, ^{
//            if (!self.isRunning) {
//                NSLog(@"暂停下载");
//                return ;
//            }
//            sleep(1);
//
//            dispatch_source_merge_data(self.source, 1); // source 值响应
//        });
//    }
//}

#pragma mark -//信号量
- (void)testDemo11{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //信号量 -- gcd控制并发数
    //控制数量为1，可以当锁用，实现同步效果，一次只允许通过一个
    //总结：由于设定的信号值为3
    dispatch_semaphore_t semphore = dispatch_semaphore_create(2);
    
    //任务1
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semphore, DISPATCH_TIME_FOREVER);
        NSLog(@"执行任务1");
        sleep(1);
        NSLog(@"任务1执行完成");
        dispatch_semaphore_signal(semphore);
    });
    
    //任务2
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semphore, DISPATCH_TIME_FOREVER);
        NSLog(@"执行任务2");
        sleep(1);
        NSLog(@"任务2执行完成");
        dispatch_semaphore_signal(semphore);
    });
    
    //任务3
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semphore, DISPATCH_TIME_FOREVER);
        NSLog(@"执行任务3");
        sleep(1);
        NSLog(@"任务3执行完成");
        dispatch_semaphore_signal(semphore);
    });
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

 

#pragma mark - 调度组
- (void)testDemo10{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_t group = dispatch_group_create();
    
    //进组之后，底层signal+1
    //group会一直循环判断signal是否为0，如果为0，就会调用一个group的wakeup函数，就会隐性调用dispatch_group_notify这个通知。
    //signal 不为0，就不会调用dispatch_group_notify，如果signal为负数，就会发生崩溃。
    
    dispatch_group_enter(group); //+1
    dispatch_async(queue, ^{
        NSLog(@"第一个走完了");
        dispatch_group_leave(group); //-1
    });
    
    dispatch_group_enter(group); //+1
    dispatch_async(queue, ^{
        NSLog(@"第二个走完了");
        dispatch_group_leave(group); //-1
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"所有任务完成，可以更新UI");
    });
}

- (void)testDemo9{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:imageView];
    
    //创建调度组
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue1 = dispatch_queue_create("fanxing.com", DISPATCH_QUEUE_CONCURRENT);
    
    //SIGNAL
    dispatch_group_async(group, queue, ^{
          NSString *logoStr = @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3351002169,4211425181&fm=27&gp=0.jpg";
              NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:logoStr]];
              UIImage *image = [UIImage imageWithData:data];
              [self.mArray addObject:image];
    });
    
    dispatch_group_async(group, queue1, ^{
        NSString *logoStr = @"https://www.baidu.com/img/baidu_resultlogo@2.png";
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:logoStr]];
        UIImage *image = [UIImage imageWithData:data];
        [self.mArray addObject:image];
    });
    
//    在全局并发队列进行请求，在主队列进行更新UI，对队列的影响和需求降低
    __block UIImage *newImage = nil;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"数组个数:%ld",self.mArray.count);
        for (int i = 0; i<self.mArray.count; i++) {
            UIImage *waterImage = self.mArray[i];
            newImage = [KC_ImageTool kc_WaterImageWithWaterImage:waterImage backImage:newImage waterImageRect:CGRectMake(20, 100*(i+1), 100, 40)];
        }
        imageView.image = newImage;
    });
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
