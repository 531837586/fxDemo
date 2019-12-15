//
//  RACViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/6/19.
//  Copyright © 2019 樊星. All rights reserved.
//

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#import "RACViewController.h"
#import "RACLoginViewController.h"
#import "LogView.h"

@interface RACViewController ()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) UITextField *username;
//@property (nonatomic, strong) UITextField *emailField;
//@property (nonatomic, strong) UITextField *passwordField;
//@property (nonatomic, strong) UITextField *passwordVerificationField;
//
//@property (nonatomic, strong) UIButton *createButton;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) RACCommand *conmmand;

@end

@implementation RACViewController

-(NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [UITableView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 500);
        //        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.separatorColor = RGB(237, 237, 237);
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"RAC";
    [self configData];
    [self configSubView];
}

-(void)configSubView{
    
    [self.view addSubview:self.tableView];
    LogView *logView = [[LogView alloc] initWithFrame:CGRectMake(0, 500, SCREEN_WIDTH, SCREEN_HEIGHT-500)];
    [self.view addSubview:logView];
}

-(void)configData{
    
    self.dataArray = [NSMutableArray arrayWithObjects:
                      @"useRACSignal",
                      @"coldSignal",
                      @"hotSignal",
                      @"pushLoginVC",
                      @"RACSubject",
                      @"RACReplaySubject",
                      @"RACTuple",
                      @"RACSequence",
                      @"map",
                      @"switchToLatest",
                      nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID=@"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageView.image = [UIImage imageNamed:@"white_image"];
//    cell.imageView.image = [UIImage imageNamed:@"black_boll"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row < self.dataArray.count){
        NSString *name = [self.dataArray objectAtIndex:indexPath.row];
        @try {
            [self performSelector:NSSelectorFromString(name)];
        } @catch (NSException *exception) {
//            NSLog(@"未找到方法");
        } @finally {
//            NSLog(@"执行完毕");
        }
    }
}

#pragma mark - RACSignal
-(void)useRACSignal{
    /*
     RAC中最核心的类RACSiganl,搞定这个类就能用ReactiveCocoa开发了。
     信号类,一般表示将来有数据传递，只要有数据改变，信号内部接收到数据，就会马上发出数据。
     RACSiganl，只是表示当数据改变时，信号内部会发出数据，它本身不具备发送信号的能力，而是交给内部一个订阅者去发出。
     默认一个信号都是冷信号，也就是值改变了，也不会触发，只有订阅了这个信号，这个信号才会变为热信号，值改变了才会触发。
     */
    
     // RACSignal使用步骤：
     // 1. 创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
     // 2. 订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
     // 3. 发送信号 - (void)sendNext:(id)value
    
     // RACSignal底层实现：
     // 1.  创建信号，首先把didSubscribe保存到信号中，还不会触发。
     // 2.  当信号被订阅，也就是调用signal的subscribeNext:nextBlock
     // 3.  subscribeNext内部会创建订阅者subscriber，并且把nextBlock保存到subscriber中。
     // 4.  subscribeNext内部会调用siganl的didSubscribe
     // 5.  siganl的didSubscribe中调用[subscriber sendNext:@1];
     // 6.  sendNext底层其实就是执行subscriber的nextBlock
 
    // 1.创建信号
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    //RACSubscriber:表示订阅者的意思，用于发送信号，这是一个协议，不是一个类，只要遵守这个协议，并且实现方法才能成为订阅者。通过create创建的信号，都有一个订阅者，帮助他发送数据。
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        // 2.发送信号
        [subscriber sendNext:@1];
        
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
         //RACDisposable:用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。
        //使用场景:不想监听某个信号时，可以通过它主动取消订阅信号。
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            // 执行完Block后，当前信号就不在被订阅了。
            NSLog(@"信号被销毁");
        }];
    }];
    
    // 3.订阅信号,才会激活信号.
    [siganl subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
}

#pragma mark - coldSignal
-(void)coldSignal{
    //冷信号：只要有订阅者的时候才会发出信号，一对一，如果有其他的订阅者订阅会重新完整的发送信号，给订阅者发送消息则一定会收到。
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送信号");
        [subscriber sendNext:@"1"];
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"3"];
        [subscriber sendCompleted];
        return nil;
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"sign1 :%@",x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"sign2 :%@",x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"sign3 :%@",x);
    }];
}

#pragma mark - hotSignal
-(void)hotSignal{
    //热信号：不在乎是否有订阅者，一对多，如果发送当时有订阅者，就会同时接收到信号，如果没有就不会接收到消息，给订阅者发送消息不一定会收到。
    RACMulticastConnection * connection = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
            [subscriber sendNext: @"1"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendNext: @"2"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            [subscriber sendNext: @"3"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:4 schedule:^{
            [subscriber sendNext: @"4"];
        }];
        return nil;
    }] publish];
    [connection connect];
    RACSignal * signal = connection.signal;
    
    [[RACScheduler mainThreadScheduler] afterDelay:1.1 schedule:^{
        [signal subscribeNext:^(id x) {
            NSLog(@"sign1 :%@",x);
        }];
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:2.1 schedule:^{
        [signal subscribeNext:^(id x) {
            NSLog(@"sign2 :%@",x);
        }];
    }];
}

#pragma mark - RACSubjec
-(void)RACSubject{
    //信号提供者，自己可以充当信号，又能发送信号。
    //使用场景:通常用来代替代理，有了它，就不必要定义代理了。
    
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
    
    // RACSubject:底层实现和RACSignal不一样。
    // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
    // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"第二个订阅者%@",x);
    }];
    
    // 3.发送信号
    [subject sendNext:@"1"];
}

#pragma mark - pushLoginVC 代替代理
-(void)pushLoginVC{
    
    RACLoginViewController *vc = [RACLoginViewController new];
    // 1.给当前控制器添加一个按钮，modal到另一个控制器界面
    // 2.另一个控制器view中有个按钮，点击按钮，通知当前控制器
    [vc.delegateSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"点击了代理%@", x);
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - RACReplaySubject
-(void)RACReplaySubject{
    
    //RACReplaySubject:重复提供信号者，RACSubject的子类。
    //使用场景:如果一个信号每被订阅一次，就需要把之前的值重复发送一遍，使用重复提供信号类
    
    // RACReplaySubject使用步骤:
    // 1.创建信号 [RACReplaySubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value
    
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
    
    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。
    
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];

}

#pragma mark - RACTuple
-(void)RACTuple{
    //遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    //RACTuple:元组类,类似NSArray,用来包装值.
    NSDictionary *dict = @{@"name":@"xmg",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        
        // 相当于以下写法
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        
        NSLog(@"%@ %@",key,value);
        
    }];
}

#pragma mark - RACSequence
-(void)RACSequence{
    //RACSequence:RAC中的集合类，用于代替NSArray,NSDictionary,可以使用它来快速遍历数组和字典。
    // 1.遍历数组
    NSArray *numbers = @[@1,@2,@3,@4];
    
    // 这里其实是三步
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        
        NSLog(@"  %@",x);
    }];
}

#pragma mark - map
-(void)map{
    NSArray *dictArr = @[@1, @2, @3, @4, @5];
    // map:映射的意思，目的：把原始值value映射成一个新值
    // array: 把集合转换成数组
    // 底层实现：当信号被订阅，会遍历集合中的原始值，映射成新值，并且保存到新的数组里。
    NSArray *flags = [[dictArr.rac_sequence map:^id(NSNumber *value) {
        
        return @([value intValue] + 10);
        
    }] array];
    
    [flags.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"  %@", x);
    }];
}

#pragma mark - RACCommand
-(void)RACCommand{
    
    //RACCommand:RAC中用于处理事件的类，可以把事件如何处理,事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程。
    //使用场景:监听按钮点击，网络请求
    
    // 一、RACCommand使用步骤:
    // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
    // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
    // 3.执行命令 - (RACSignal *)execute:(id)input
    
    // 二、RACCommand使用注意:
    // 1.signalBlock必须要返回一个信号，不能传nil.
    // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
    // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
    // 4.RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
    
    // 三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
    // 1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
    // 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
    
    // 四、如何拿到RACCommand中返回信号发出的数据。
    // 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
    // 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
    
    // 五、监听当前命令是否正在执行executing
    
    // 六、使用场景,监听按钮点击，网络请求
    
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        
        NSLog(@"执行命令");
        
        // 创建空信号,必须返回信号
        //        return [RACSignal empty];
        
        // 2.创建信号,用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"请求数据"];
            
            // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }];
    
    // 强引用命令，不要被销毁，否则接收不到数据
    _conmmand = command;
    
    
    // 3.订阅RACCommand中的信号
    [command.executionSignals subscribeNext:^(id x) {
        
        [x subscribeNext:^(id x) {
            
            NSLog(@"%@",x);
        }];
        
    }];
    
    // RAC高级用法
    // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    
    // 4.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    [[command.executing skip:1] subscribeNext:^(id x) {
        
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            
        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
        
    }];
    // 5.执行命令
    [self.conmmand execute:@1];
}

#pragma mark - switchToLatest
-(void)switchToLatest{
    
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    RACSubject *signalB = [RACSubject subject];
    
    // 获取信号中信号最近发出信号，订阅最近发出的信号。
    // 注意switchToLatest：只能用于信号中的信号
    
    [signalOfSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    [signalOfSignals sendNext:signalA];
    [signalOfSignals sendNext:signalB];
    [signalA sendNext:@"  signalA"];
    [signalB sendNext:@"  signalB"];
}
@end
