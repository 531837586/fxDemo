//
//  WKViewController.m
//  002---HTTPCookie
//
//  Created by Cooci on 2018/8/23.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "WKViewController.h"
#import "WKCookieManager.h"

@interface WKViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NS
    // WKHTTPCookieStore
//    [WKWebsiteDataStore defaultDataStore].httpCookieStore;
    
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
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
                     WKUserContentController *contoller = [[WKUserContentController alloc] init];
                     [contoller addUserScript:[[WKCookieManager shareManager] futhureCookieScript]];
                     configuration.userContentController = contoller;
                    
                     self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT+50, SCREEN_WIDTH, self.view.height) configuration:configuration];
                     self.webView.navigationDelegate = self;
                     [self.view addSubview:self.webView];

                     [self.webView loadRequest:[self cookieAppendRequest]];
     }];

}

- (NSURLRequest *)cookieAppendRequest{
    // 网络里面数据保存地方
    // token
    // UIWebView token -- cookie
    // WKWebView 奔溃哦 ?
    // H5 - token - username - password
    // 及时性 + 浪费带宽
    // 拉去更新cookie
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    NSArray *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    //Cookies数组转换为requestHeaderFields
    NSDictionary *requestHeaderFields = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
    //设置请求头
    request.allHTTPHeaderFields = requestHeaderFields;
    NSLog(@"%@",request.allHTTPHeaderFields);
    return request;
}


#pragma mark - WKNavigationDelegate

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    NSLog(@"开始加载的时候调用。。");
    NSLog(@"%lf", self.webView.estimatedProgress);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"来到00000");
    [[WKCookieManager shareManager] fixNewRequestCookieWithRequest:navigationAction.request];
    decisionHandler(WKNavigationActionPolicyAllow);
}



@end
