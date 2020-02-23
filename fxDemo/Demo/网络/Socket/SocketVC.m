//
//  SocketVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/7.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "SocketVC.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

//htons : 将一个无符号短整型的主机数值转换为网络字节顺序，不同cpu 是不同的顺序 (big-endian大尾顺序 , little-endian小尾顺序)
#define SocketPort htons(8040)
//inet_addr是一个计算机函数，功能是将一个点分十进制的IP转换成一个长整数型数
#define SocketIP   inet_addr("127.0.0.1")

@interface SocketVC ()
@property (nonatomic, assign) int clinenId;
@property (strong, nonatomic) UITextField *sendMsgContent_tf;
@property (strong, nonatomic) UITextView *allMsgContent_tv;
@property (nonatomic, strong) NSMutableAttributedString *totalAttributeStr;
@property (nonatomic, copy) NSString *recoderTime;
@property (nonatomic, assign) int restartId;
@end

@implementation SocketVC{
    UILabel *leftLabel;
    UILabel *rightLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.totalAttributeStr = [[NSMutableAttributedString alloc] init];
    
    leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, 50, 50)];
//    leftLabel.backgroundColor = [UIColor lightGrayColor];
    leftLabel.text = @"连接";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:leftLabel];
    [leftLabel onClick:^(id obj) {
        [self connectSocket];
    }];
  
    rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, STATUS_AND_NAV_BAR_HEIGHT, 50, 50)];
//    rightLabel.backgroundColor = [UIColor lightGrayColor];
    rightLabel.text = @"发送";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rightLabel];
    [rightLabel onClick:^(id obj) {
        [self sendMsgAction];
    }];
    
    self.sendMsgContent_tf = [[UITextField alloc] initWithFrame:CGRectMake(50, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH-100, 50)];
    [self.view addSubview:self.sendMsgContent_tf];
    self.sendMsgContent_tf.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.allMsgContent_tv = [[UITextView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT+50, SCREEN_WIDTH, self.view.height-STATUS_AND_NAV_BAR_HEIGHT-50)];
    [self.view addSubview:self.allMsgContent_tv];
    self.allMsgContent_tv.editable = NO;
    self.allMsgContent_tv.backgroundColor = [UIColor lightGrayColor];
    self.allMsgContent_tv.textColor = [UIColor blackColor];
    
}

-(void)connectSocket{
    /**
        1: 创建socket
        参数
        domain：协议域，又称协议族（family）。常用的协议族有AF_INET(ipv4)、AF_INET6、AF_LOCAL（或称AF_UNIX，Unix域Socket）、AF_ROUTE等。协议族决定了socket的地址类型，在通信中必须采用对应的地址，如AF_INET决定了要用ipv4地址（32位的）与端口号（16位的）的组合、AF_UNIX决定了要用一个绝对路径名作为地址。
        type：指定Socket类型。常用的socket类型有SOCK_STREAM、SOCK_DGRAM、SOCK_RAW、SOCK_PACKET、SOCK_SEQPACKET等。流式Socket（SOCK_STREAM）是一种面向连接的Socket，针对于面向连接的TCP服务应用。数据报式Socket（SOCK_DGRAM）是一种无连接的Socket，对应于无连接的UDP服务应用。
        protocol：指定协议。常用协议有IPPROTO_TCP、IPPROTO_UDP、IPPROTO_STCP、IPPROTO_TIPC等，分别对应TCP传输协议、UDP传输协议、STCP传输协议、TIPC传输协议。
        注意：1.type和protocol不可以随意组合，如SOCK_STREAM不可以跟IPPROTO_UDP组合。当第三个参数为0时，会自动选择第二个参数类型对应的默认协议。
        返回值:
        如果调用成功就返回新创建的套接字的描述符，如果失败就返回INVALID_SOCKET（Linux下失败返回-1）
        */
    
       _clinenId = socket(AF_INET, SOCK_STREAM, 0);
       
       if (_clinenId == -1) {
           NSLog(@"创建socket 失败");
           return;
       }
       
       //2: 建立连接
       
       /**
        __uint8_t    sin_len;          假如没有这个成员，其所占的一个字节被并入到sin_family成员中
        sa_family_t    sin_family;     一般来说AF_INET（地址族）PF_INET（协议族）
        in_port_t    sin_port;         // 端口
        struct    in_addr sin_addr;    // ip
        char        sin_zero[8];       没有实际意义,只是为了　跟SOCKADDR结构在内存中对齐
        */
       
       struct sockaddr_in socketAddr;
       socketAddr.sin_family   = AF_INET;
       socketAddr.sin_port     = SocketPort;
    
       struct in_addr  socketIn_addr;
       socketIn_addr.s_addr    = SocketIP;
    
       socketAddr.sin_addr     = socketIn_addr;
       /**
        参数
        参数一：套接字描述符
        参数二：指向数据结构sockaddr的指针，其中包括目的端口和IP地址
        参数三：参数二sockaddr的长度，可以通过sizeof（struct sockaddr）获得
        返回值
        成功则返回0，失败返回非0，错误码GetLastError()。
        */
       int result = connect(_clinenId, (const struct sockaddr *)&socketAddr, sizeof(socketAddr));
       if (result != 0) {
           NSLog(@"连接socket 失败");
           return;
       };
       leftLabel.text = @"已连接";
       leftLabel.userInteractionEnabled = NO;
       self.restartId = 0;
       NSLog(@"连接成功");
       
       dispatch_async(dispatch_get_global_queue(0, 0), ^{
           [self recvMsg];
       });
       
}

#pragma mark - 发送消息

- (void)sendMsgAction{
    /**
     3: 发送消息
     s：一个用于标识已连接套接口的描述字。
     buf：包含待发送数据的缓冲区。
     len：缓冲区中数据的长度。
     flags：调用执行方式。
     
     返回值
     如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR
     一个中文对应 3 个字节！UTF8 编码！
     */
    
    if (self.sendMsgContent_tf.text.length==0) {
        NSLog(@"消息为空,无法发送");
        return;
    }
    const char *msg = @"消息".UTF8String;
    ssize_t sendLen = send(self.clinenId, msg, strlen(msg), 0);
    NSLog(@"发送了:%ld字节",sendLen);
    [self showMsg:self.sendMsgContent_tf.text msgType:0];
    self.sendMsgContent_tf.text = @"";

}

#pragma mark - 接受数据

- (void)recvMsg{
    // 4. 接收数据
    /**
     参数
     1> 客户端socket
     2> 接收内容缓冲区地址
     3> 接收内容缓存区长度
     4> 接收方式，0表示阻塞，必须等待服务器返回数据
     
     返回值
     如果成功，则返回读入的字节数，失败则返回SOCKET_ERROR
     */
 
    while (1) {
        uint8_t buffer[1024];
        ssize_t recvLen = recv(self.clinenId, buffer, sizeof(buffer), 0);
        NSLog(@"接收到了:%ld字节",recvLen);
        // 判断如果 0  下面会奔溃
        if (recvLen==0) {
            self.restartId ++;
            if (self.restartId>3) {
                self.restartId = 0;
                return;
            }
            NSLog(@"此次传输长度为0 如果下次还为0 请检查连接");
            continue;
        }
        
        // 接收到的数据转换
        NSData *recvData  = [NSData dataWithBytes:buffer length:recvLen];
        NSString *recvStr = [[NSString alloc] initWithData:recvData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",recvStr);
        self.restartId = 0;

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self showMsg:recvStr msgType:1];
        });
    }

}

- (void)showMsg:(NSString *)msg msgType:(int)msgType{
    // 时间处理
    NSString *showTimeStr = [self getCurrentTime];
    if (showTimeStr) {
        NSMutableAttributedString *dateAttributedString = [[NSMutableAttributedString alloc] initWithString:showTimeStr];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        // 对齐方式
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [dateAttributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle} range:NSMakeRange(0, showTimeStr.length)];
        [self.totalAttributeStr appendAttributedString:dateAttributedString];
        [self.totalAttributeStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 20.f;
    NSMutableAttributedString *attributedString;
    if (msgType == 0) { // 我发送的
        attributedString = [[NSMutableAttributedString alloc] initWithString:msg];

        paragraphStyle.alignment = NSTextAlignmentRight;
        [attributedString addAttributes:@{
                                          NSFontAttributeName:[UIFont systemFontOfSize:15],
                                          NSForegroundColorAttributeName:[UIColor whiteColor],
                                          NSBackgroundColorAttributeName:[UIColor blueColor],
                                          NSParagraphStyleAttributeName:paragraphStyle
                                          }
                                  range:NSMakeRange(0, msg.length)];
    }else{
        attributedString = [[NSMutableAttributedString alloc] initWithString:msg];

        [attributedString addAttributes:@{
                                          NSFontAttributeName:[UIFont systemFontOfSize:15],
                                          NSForegroundColorAttributeName:[UIColor blackColor],
                                          NSBackgroundColorAttributeName:[UIColor whiteColor],
                                          NSParagraphStyleAttributeName:paragraphStyle
                                          }
                                  range:NSMakeRange(0, msg.length)];
    }
    [self.totalAttributeStr appendAttributedString:attributedString];
    [self.totalAttributeStr appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];

    self.allMsgContent_tv.attributedText = self.totalAttributeStr;

}

#pragma mark - 显示时间逻辑
- (NSString *)getCurrentTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [dateFormatter stringFromDate:date];
    if (!self.recoderTime || self.recoderTime.length == 0) {
        self.recoderTime = dateStr;
        return dateStr;
    }
    NSDate *recoderDate = [dateFormatter dateFromString:self.recoderTime];
    self.recoderTime = dateStr;
    NSTimeInterval timeInter = [date timeIntervalSinceDate:recoderDate];
    NSLog(@"%@--%@ -- %f",date,recoderDate,timeInter);
    if (timeInter<6) {
        return @" ";
    }
    return dateStr;
}


@end
