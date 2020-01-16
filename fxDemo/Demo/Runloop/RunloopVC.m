//
//  RunloopVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/1/8.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "RunloopVC.h"
#import "FXThread.h"
#import <CoreFoundation/CFRunLoop.h>

@interface RunloopVC ()<UITextViewDelegate, NSPortDelegate>
@property (nonatomic, assign) BOOL isStopping;

@property (nonatomic, strong) NSPort *subThreadPort;
@property (nonatomic, strong) NSPort *mainThreadPort;

@end

@implementation RunloopVC

//联合体最重要的特性是可以节约，如果产生两个地址会浪费
typedef union {
    int a;
    int *b;
} UnionType;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    UnionType type;
    type.a = 10;
    NSLog(@"a=%p", &type.a);
    NSLog(@"b=%p", &type.b);
    NSLog(@"%zd", sizeof(UnionType));
    
//    self.isStopping = NO;
//    FXThread *thread = [[FXThread alloc] initWithBlock:^{
//        NSLog(@"%@-hello****", [NSThread currentThread]);
//        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            NSLog(@"子线程 timer");
//            if(self.isStopping){
//                [NSThread exit];
//            }
//        }];
//        [[NSRunLoop currentRunLoop] run];
//    }];
//    thread.name = @"fanxing";
//    [thread start];
    
    
    UITextView *textView = [UITextView new];
    textView.text = [FXUtils getPlaceStr];
//    textView.text = @"asdfaf";
//    textView.frame = self.view.bounds;
    textView.frame = CGRectMake(0, 0, 100, 100);
    textView.delegate = self;
    [self.view addSubview:textView];
    
    
//    [self timerDemo];
//    [self cfTimerDemo];
//    [self cfObserverDemo];
//    [self source0Demo];
    [self setupPort];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotNotification:) name:@"helloMyNotification" object:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"!@#");
    NSLog(@"%@", [NSRunLoop currentRunLoop].currentMode);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"123");
    NSLog(@"%@", [NSRunLoop currentRunLoop].currentMode);
}

- (void)gotNotification:(NSNotification *)noti{
    NSLog(@"gotNotification = %@",noti);
}

#pragma mark - timer

- (void)timerDemo{
    
    //CFRunloopMode 研究
    CFRunLoopRef lp = CFRunLoopGetCurrent();
    CFRunLoopMode model = CFRunLoopCopyCurrentMode(lp);
    NSLog(@"model == %@", model);
    CFArrayRef modeArray = CFRunLoopCopyAllModes(lp);
    NSLog(@"modelArray == %@", modeArray);
    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"fire in home -- %@", [[NSRunLoop currentRunLoop] currentMode]);
//    }];
//
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

 

- (void)cfTimerDemo{
    CFRunLoopTimerContext context = {
        0,
        ((__bridge void *)self),
        NULL,
        NULL,
        NULL
    };
    
    CFRunLoopRef rlp = CFRunLoopGetCurrent();
    /**
     参数一：用于分配对象的内存
     参数二：在什么时候触发（距离现在）
     参数三：每隔多少时间触发一次
     参数四：为了参数
     参数五：CFRunLoopObserver的优先级  当在Runloop同一运行阶段中有多个CFRunLoopObserver 正常情况下使用0
     参数六：回调，比如触发事件，就会来到这里
     参数七：上下文记录信息
     */
    CFRunLoopTimerRef timerRef = CFRunLoopTimerCreate(kCFAllocatorDefault, 0, 1, 0, 0, fxRunLoopTimerCallBack, &context);
    CFRunLoopAddTimer(rlp, timerRef, kCFRunLoopDefaultMode);
}

void fxRunLoopTimerCallBack(CFRunLoopTimerRef timer, void *info){
    NSLog(@"%@--fx--%@",timer,info);
}

#pragma mark - observe
- (void)cfObserverDemo{
    
    CFRunLoopObserverContext context = {
           0,
           ((__bridge void *)self),
           NULL,
           NULL,
           NULL
       };
    CFRunLoopRef rlp = CFRunLoopGetCurrent();
    
    /**
    参数一：用于分配对象的内存
    参数二：你关注的事件
     kCFRunLoopEntry=(1<<0),
     kCFRunLoopBeforeTimers=(1<<0),
     kCFRunLoopBeforeSources=(1<<2),
     kCFRunLoopBeforeWaiting=(1<<5),
     kCFRunLoopAfterWaiting=(1<<6),
     kCFRunLoopExit=(1<<7),
     kCFRunLoopAllActivities=0x0FFFFFFFU
    参数三：CFRunLoopObserver是否循环调用
    参数四：CFRunLoopObserver的优先级 当在Runloop同一运行阶段中有多个CFRunLoopObserver 正常情况下使用0
    参数五：回调，比如触发事件，就会来到这里
    参数六：上下文记录信息
     */
    //observer 监听runloop的状态，
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, fxRunLoopObserveCallBack, &context);
    CFRunLoopAddObserver(rlp, observerRef, kCFRunLoopDefaultMode);
}

//只要runloop状态发生改变，就会回调。
void fxRunLoopObserveCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    NSLog(@"%lu--%@", activity, info);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.isStopping = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"helloMyNotification" object:@"fanxing"];
    
    NSMutableArray *components = [NSMutableArray array];
    NSData *data = [@"hello" dataUsingEncoding:NSUTF8StringEncoding];
    [components addObject:data];
    
    [self.subThreadPort sendBeforeDate:[NSDate date] components:components from:self.mainThreadPort reserved:0];
}

 
#pragma mark - source

- (void)source0Demo {
    
    CFRunLoopSourceContext context = {
        0,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        schedule,
        cancel,
        perform
    };
    
    /**
     参数一：传递NULL或kCFAllocatorDefault以使用当前默认分配器。
     参数二：优先级索引，指示处理运行循环源的顺序。这里我传0为了的就是自主回调
     参数三：为运行循环源保存上下文信息的结构
     */
    CFRunLoopSourceRef source0 = CFRunLoopSourceCreate(CFAllocatorGetDefault(), 0, &context);
    CFRunLoopRef rlp = CFRunLoopGetCurrent();
    
    //source --> runloop 指定了mode 那么此时我们source就进入待续状态
    CFRunLoopAddSource(rlp, source0, kCFRunLoopDefaultMode);
    //一个执行信号
    CFRunLoopSourceSignal(source0);
 
    //唤醒 run loop 防止沉睡状态
    CFRunLoopWakeUp(rlp);
    //取消 移除
    CFRunLoopRemoveSource(rlp, source0, kCFRunLoopDefaultMode);
//    CFRelease(rlp);
}

void schedule(void *info, CFRunLoopRef rl, CFRunLoopMode mode){
    NSLog(@"准备代发schedule");
}

void perform(void *info){
    NSLog(@"执行吧,骚年perform");
}

void cancel(void *info, CFRunLoopRef rl, CFRunLoopMode mode){
    NSLog(@"取消了,终止了!!!!cancel");
}

#pragma mark - source1: port演示

- (void)setupPort{
    self.mainThreadPort = [NSPort port];
    self.mainThreadPort.delegate = self;
    //port -> source1 依赖于 runloop
    [[NSRunLoop currentRunLoop] addPort:self.mainThreadPort forMode:NSDefaultRunLoopMode];
    [self task];
}

- (void)task {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        self.subThreadPort = [NSPort port];
        self.subThreadPort.delegate = self;
        
        [[NSRunLoop currentRunLoop] addPort:self.subThreadPort forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }];
    [thread start];
    //主线 -- 子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@", [NSThread currentThread]); // 3
        
        NSString *str;
        dispatch_async(dispatch_get_main_queue(), ^{
            //1
            NSLog(@"%@", [NSThread currentThread]);
        });
    });
}
//线程之间通讯
//主线程 -- data
//子线程 -- data1
//更加底层 -- 内核
//mach
- (void)handlePortMessage:(id)message{
    NSLog(@"%@", [NSThread currentThread]); //3 1
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([message class], &count);
    for (int i = 0; i < count; i++) {
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        NSLog(@"%@",name);
    }
    
    sleep(1);
    if(![[NSThread currentThread] isMainThread]){
        
        NSMutableArray *components = [NSMutableArray array];
           NSData *data = [@"woard" dataUsingEncoding:NSUTF8StringEncoding];
           [components addObject:data];
           
           [self.mainThreadPort sendBeforeDate:[NSDate date] components:components from:self.subThreadPort reserved:0];
    }
}
@end
