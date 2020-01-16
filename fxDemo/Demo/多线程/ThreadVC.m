//
//  ThreadVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/1/14.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "ThreadVC.h"
#import "ThreadPerson.h"
#import <pthread.h>

@interface ThreadVC ()
@property (nonatomic, strong) ThreadPerson *p;
@property (nonatomic, strong) NSThread *t;
@property (nonatomic, assign) NSInteger tickets;
@property (nonatomic, strong) NSMutableArray *mArray;
@end

@implementation ThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.p = [ThreadPerson alloc];
    self.tickets = 20;
//    [self creatThreadSpace];
//    [self creatpThread_t];
    
    
//    while (YES) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSLog(@"%@", [NSThread currentThread]);
//        });
//    }
}

//- (void)threadLifeCircle{
//
//        NSThread *t = [[NSThread alloc] initWithTarget:self selector:@selector(testThreadStatus) object:@100];
//    //    2. 启动线程
//        [t start];
//        t.name = @"学习线程";
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//     [self threadLifeCircle];
    
        
        // 资源问题
        // 数据库
        // 增删改查
        // 199 -- 100
        
        // 1. 开启一条售票线程
        NSThread *t1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets) object:nil];
        t1.name = @"售票 A";
        [t1 start];
    
        // 2. 再开启一条售票线程
        NSThread *t2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets) object:nil];
        t2.name = @"售票 B";
        [t2 start];
}

//线程资源共享
- (void)saleTickets {
    
    // runloop & 线程 不是一一对应
    
    while (YES) {
        // 0. 模拟延时
    
        //NSObject *obj = [[NSObject alloc] init];
        //obj 是自己的临时对象,对其他访问该区域的无影响
        //可以锁self 那么访问该方法的时候所有的都锁住,可以根据需求特定锁
        @synchronized(self){
        // 递归 非递归
            [NSThread sleepForTimeInterval:1];
            // 1. 判断是否还有票
            if (self.tickets > 0) {
                // 2. 如果有票，卖一张，提示用户
                self.tickets--;
                NSLog(@"剩余票数 %zd %@", self.tickets, [NSThread currentThread]);
            } else {
                // 3. 如果没票，退出循环
                NSLog(@"没票了，来晚了 %@", [NSThread currentThread]);
//                break;
            }
            //在锁里面操作其他的变量的影响
            [self.mArray addObject:[NSDate date]];
            NSLog(@"%@ *** %@",[NSThread currentThread],self.mArray);
        }
    }
    
}


//线程状态演练方法
- (void)threadLifeCircle{
    
    NSLog(@"%d %d %d", self.t.isExecuting, self.t.isFinished, self.t.isCancelled);
    //生命周期
    //SD--YY这些框架都会自己控制生命周期
    
    if(self.t == nil || self.t.isCancelled || self.t.isFinished) {
        
        self.t = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
        self.t.name = @"跑步线程";
        [self.t start];
    }else{
        NSLog(@"%@ 正在执行", self.t.name);
        
        //可以设置弹框 --> 这里直接置空
        self.t = nil;
    }
}

- (void)run{
    
    NSLog(@"开始");
    
    //下面的代码的作用是判断线程状态,可能因为下面的延时,阻塞会带来当前线程的一些影响
    [NSThread sleepForTimeInterval:3];

    // 判断线程是否被取消
    if ([NSThread currentThread].isCancelled) {
        NSLog(@"%@被取消",self.t.name);
        return;
    }
    
    for (NSInteger i = 0; i < 10; i++) {
        
        // 判断线程是否被取消
        if ([NSThread currentThread].isCancelled) {
            NSLog(@"%@被取消",self.t.name);
            return;
        }
        
        if (i == 3) {
            // 睡指定的时长(秒)
            [NSThread sleepForTimeInterval:1];
        }

        NSLog(@"%@ %zd", [NSThread currentThread], i);

//        //内部取消线程
//        // 强制退出 - 当某一个条件满足，不希望线程继续工作，直接杀死线程，退出
//        if (i == 8) {
//            // 强制退出当前所在线程！后续的所有代码都不会执行
//            [NSThread exit];
//        }
    }
    
    //强制胡哟一波,如果此时我 exit是不是UI也线程都退出去了 无法执行了!
    //[NSThread exit];
    NSLog(@"完成");
}



- (void)creatpThread_t {
    
    //0: pthread
    /**
     pthread_create 创建线程
     参数：
     1. pthread_t：要创建线程的结构体指针，通常开发的时候，如果遇到 C 语言的结构体，类型后缀 `_t / Ref` 结尾
     同时不需要 `*`
     2. 线程的属性，nil(空对象 - OC 使用的) / NULL(空地址，0 C 使用的)
     3. 线程要执行的`函数地址`
     void *: 返回类型，表示指向任意对象的指针，和 OC 中的 id 类似
     (*): 函数名
     (void *): 参数类型，void *
     4. 传递给第三个参数(函数)的`参数`
     
     返回值：C 语言框架中非常常见
     int
     0          创建线程成功！成功只有一种可能
     非 0       创建线程失败的错误码，失败有多种可能！
     */
    
//    1: pthread
    pthread_t threadId = NULL;
//    c 字符串
    char *cString = "HelloCode";
//    创建线程这样用的比较少，一般在封装锁的时候用这个，性能比较好
    int result = pthread_create(&threadId, NULL, pthreadTest, cString);
    
    if(result == 0){
        NSLog(@"成功");
    }else{
        NSLog(@"失败");
    }
    
// 2: NSThread
 [NSThread detachNewThreadSelector:@selector(threadTest) toTarget:self withObject:nil];
    
 // 3: GCD
 dispatch_async(dispatch_get_global_queue(0, 0), ^{
     [self threadTest];
 });
 
 // 4: NSOperation
 [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
     [self threadTest];
 }];
    
}

/**
 1. 循环的执行速度很快
 2. 栈区／常量区的内存操作也挺快
 3. 堆区的内存操作有点慢
 4. I(Input输入) / O(Output 输出) 操作的速度是最慢的！
 * 会严重的造成界面的卡顿，影响用户体验！
 * 多线程：开启一条线程，将耗时的操作放在新的线程中执行
 */
- (void)threadTest{
    NSLog(@"begin");
    NSInteger count = 1000 * 100;
    for (NSInteger i = 0; i < count; i++) {
        // 栈区
        NSInteger num = i;
        // 常量区
        NSString *name = @"zhang";
        // 堆区
        NSString *myName = [NSString stringWithFormat:@"%@ - %zd", name, num];
        NSLog(@"%@", myName);
    }
    NSLog(@"over");
}

void *pthreadTest(void *para){
    // 接 C 语言的字符串
        NSLog(@"===> %@ %s", [NSThread currentThread], para);
    // __bridge 将 C 语言的类型桥接到 OC 的类型
    NSString *name = (__bridge NSString *)(para);
    
    NSLog(@"===>%@ %@", [NSThread currentThread], name);
    
    return NULL;
}

- (void)creatThreadSpace {
    
//    开辟线程 -- 占用空间512
    NSLog(@"%lu", [NSThread currentThread].stackSize/1024);
    
//    属性
//   A: 1. 开辟线程
    NSThread *t = [[NSThread alloc] initWithTarget:self.p selector:@selector(study:) object:@100];
//    2. 启动线程
    [t start];
    t.name = @"学习线程";
//    [t start];两次start会崩溃
    
//B: detach 分离，不需要启动，直接分离出新的线程执行
//    [NSThread detachNewThreadSelector:@selector(study:) toTarget:self.p withObject:@10000];
    
//    NSObject (NSThreadPersonAddtions)的分类
//C: '影视'
    
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
