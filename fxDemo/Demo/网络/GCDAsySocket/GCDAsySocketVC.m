//
//  GCDAsySocketVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/9.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "GCDAsySocketVC.h"
#import "GCDAsyncSocket.h"

@interface GCDAsySocketVC ()<GCDAsyncSocketDelegate>
@property (strong, nonatomic) UITextField *contentTF;
@property (nonatomic, strong) GCDAsyncSocket *socket;
@end

@implementation GCDAsySocketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, 50, 50)];
    //    leftLabel.backgroundColor = [UIColor lightGrayColor];
    leftLabel.text = @"连接";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:leftLabel];
    [leftLabel onClick:^(id obj) {
        [self connectSocket];
    }];
      
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, STATUS_AND_NAV_BAR_HEIGHT, 50, 50)];
    //    rightLabel.backgroundColor = [UIColor lightGrayColor];
    rightLabel.text = @"发送";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rightLabel];
    [rightLabel onClick:^(id obj) {
        [self sendMsgAction];
    }];
        
    self.contentTF = [[UITextField alloc] initWithFrame:CGRectMake(50, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH-100, 50)];
    [self.view addSubview:self.contentTF];
    self.contentTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentTF.layer.borderWidth = 0.5;
    
    UILabel *closeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, STATUS_AND_NAV_BAR_HEIGHT+50, SCREEN_WIDTH-100, 50)];
       //    rightLabel.backgroundColor = [UIColor lightGrayColor];
    closeLabel.text = @"关闭连接";
    closeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:closeLabel];
    [closeLabel onClick:^(id obj) {
        [self.socket disconnect];
        self.socket = nil;
    }];
        
}

#pragma mark - 连接socket
- (void)connectSocket{
    // 创建socket
    if (self.socket == nil)
        // 并发队列
        // 写自己并发队列
        // 同步
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    // 连接socket
    if (!self.socket.isConnected){
        NSError *error;
        [self.socket connectToHost:@"127.0.0.1" onPort:8090 withTimeout:-1 error:&error];
        if (error) NSLog(@"%@",error);
    }
}

#pragma mark - 发送
- (void)sendMsgAction{
    NSData *data = [self.contentTF.text dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:10086];
}

#pragma mark - 重连
- (IBAction)didClickReconnectAction:(id)sender {
    // 创建socket
    if (self.socket == nil)
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    // 连接socket
    if (!self.socket.isConnected){
        NSError *error;
        [self.socket connectToHost:@"127.0.0.1" onPort:8090 withTimeout:-1 error:&error];
        if (error) NSLog(@"%@",error);
    }
}

#pragma mark - GCDAsyncSocketDelegate
// 代理回调 -- 你想到了什么
// block
// 二次封装 : host port data
// socketManager 数据;
// apns - 太慢 -- 数据
// socket -- 服务器
//
//已经连接到服务器
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(nonnull NSString *)host port:(uint16_t)port{
    NSLog(@"连接成功 : %@---%d",host,port);
    //连接成功或者收到消息，必须开始read，否则将无法收到消息,
    //不read的话，缓存区将会被关闭
    // -1 表示无限时长 ,永久不失效
    [self.socket readDataWithTimeout:-1 tag:10086];
}

// 连接断开
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"断开 socket连接 原因:%@",err);
}

//已经接收服务器返回来的数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"接收到tag = %ld : %ld 长度的数据",tag,data.length);
    //连接成功或者收到消息，必须开始read，否则将无法收到消息
    //不read的话，缓存区将会被关闭
    // -1 表示无限时长 ， tag
    [self.socket readDataWithTimeout:-1 tag:10086];
}

//消息发送成功 代理函数 向服务器 发送消息
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"%ld 发送数据成功",tag);
}

@end
