//
//  NetWorkVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/1/20.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "NetWorkVC.h"

@interface NetWorkVC ()

@end

@implementation NetWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    传输过程
//    1.域名换ip地址。
//    2.建立连接
//    3.head
//    空行+body
//    8.断开连接 - 四次挥手
 
}

- (void)configData{
    
    self.menuDataArray = [NSMutableArray arrayWithObjects:
                          @"ImageDownloadVC",
                          @"UIWebViewVC",
                          @"JSCoreVC",
                          @"WKWebViewVC",
                          @"JSBridgeVC",
                          @"NSURLProtocolVC",
                          @"HTTPCookieVC",
                          @"SocketVC",
                          @"GCDAsySocketVC",
                          nil];
}

 

@end
