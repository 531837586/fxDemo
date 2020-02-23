//
//  TestWebViewController.m
//  002---HTTPCookie
//
//  Created by Cooci on 2018/8/23.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "TestWebViewController.h"

@interface TestWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

// http 无状态
// token cookie
// WK 带不上
@implementation TestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, 100, 50)];
    leftLabel.backgroundColor = [UIColor lightGrayColor];
    leftLabel.text = @"cookies";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:leftLabel];
    [leftLabel onClick:^(id obj) {
        NSHTTPCookieStorage *storages = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in [storages cookies]) {
            NSLog(@"%@",cookie);
        }
    }];
   
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, STATUS_AND_NAV_BAR_HEIGHT, 100, 50)];
    rightLabel.backgroundColor = [UIColor lightGrayColor];
    rightLabel.text = @"setCookies";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rightLabel];
    [rightLabel onClick:^(id obj) {
        [self setCookieWithDomain:@"http://www.baidu.com" sessionName:@"cooci_token_UIWebView" sessionValue:@"123456789" expiresDate:nil];
        
        NSDictionary *headerDict = [NSHTTPCookie requestHeaderFieldsWithCookies:[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        request.allHTTPHeaderFields = headerDict;
        [self.webView loadRequest:request];
    }];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT+50, SCREEN_WIDTH, self.view.height)];
    self.webView.delegate = self;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCookieWithDomain:(NSString*)domainValue
                sessionName:(NSString *)name
               sessionValue:(NSString *)value
                expiresDate:(NSDate *)date{
    
    NSURL *url = [NSURL URLWithString:domainValue];
    NSString *domain = [url host];
    
    //创建字典存储cookie的属性值
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    //设置cookie名
    [cookieProperties setObject:name forKey:NSHTTPCookieName];
    //设置cookie值
    [cookieProperties setObject:value forKey:NSHTTPCookieValue];
    //设置cookie域名
    [cookieProperties setObject:domain forKey:NSHTTPCookieDomain];
    //设置cookie路径 一般写"/"
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    //设置cookie版本, 默认写0
    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
    //设置cookie过期时间
    if (date) {
        [cookieProperties setObject:date forKey:NSHTTPCookieExpires];
    }else{
        [cookieProperties setObject:[NSDate dateWithTimeIntervalSince1970:([[NSDate date] timeIntervalSince1970]+365*24*3600)] forKey:NSHTTPCookieExpires];
    }
    [[NSUserDefaults standardUserDefaults] setObject:cookieProperties forKey:@"app_cookies"];
    //删除原cookie, 如果存在的话
    NSArray * arrayCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie * cookice in arrayCookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookice];
    }
    //使用字典初始化新的cookie
    NSHTTPCookie *newcookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    //使用cookie管理器 存储cookie
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:newcookie];
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
