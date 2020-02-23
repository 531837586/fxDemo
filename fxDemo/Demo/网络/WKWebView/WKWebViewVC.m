//
//  WKWebViewVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/2.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "WKWebViewVC.h"
#import <WebKit/WebKit.h>
#import "WKMessageHandleVC.h"

@interface WKWebViewVC ()<WKNavigationDelegate,WKUIDelegate>
@property (strong, nonatomic) WKWebView   *webView;

@end

@implementation WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, 50, 50)];
    leftLabel.backgroundColor = [UIColor lightGrayColor];
    leftLabel.text = @"左边";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:leftLabel];
    [leftLabel onClick:^(id obj) {
        [self.navigationController pushViewController:[WKMessageHandleVC new] animated:YES];
    }];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, STATUS_AND_NAV_BAR_HEIGHT, 50, 50)];
    rightLabel.backgroundColor = [UIColor lightGrayColor];
    rightLabel.text = @"右边";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rightLabel];
    [rightLabel onClick:^(id obj) {
         NSString *jsStr = [NSString stringWithFormat:@"showAlert('%@')",@"登陆成功"];
         [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
             NSLog(@"%@----%@",result, error);
         }];
    }];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    configuration.userContentController = wkUController;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    self.webView.top = STATUS_AND_NAV_BAR_HEIGHT+50;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"index3.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSURL *URL = navigationAction.request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"lgedu"]) {
        NSString *host = [URL host];
        if ([host isEqualToString:@"jsCallOC"]) {
            NSMutableDictionary *temDict = [self decoderUrl:URL];
            NSString *username = [temDict objectForKey:@"username"];
            NSString *password = [temDict objectForKey:@"password"];
            NSLog(@"%@---%@",username,password);
        }else{
            NSLog(@"不明地址 %@",host);
        }
        decisionHandler(WKNavigationActionPolicyCancel);//拦截
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.title = webView.title;
    NSString *jsStr2 = @"var arr = [3, 'Cooci', 'abc']; ";
    [self.webView evaluateJavaScript:jsStr2 completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
    }];

}


#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - 解析URL地址
- (NSMutableDictionary *)decoderUrl:(NSURL *)URL{
    NSArray *params =[URL.query componentsSeparatedByString:@"&"];
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    for (NSString *paramStr in params) {
        NSArray *dicArray = [paramStr componentsSeparatedByString:@"="];
        if (dicArray.count > 1) {
            NSString *decodeValue = [dicArray[1] stringByRemovingPercentEncoding];
            [tempDic setObject:decodeValue forKey:dicArray[0]];
        }
    }
    return tempDic;
}


#pragma mark - 大小适应
- (WKUserContentController *)wkwebViewScalPreferences{
   
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    
    //    WKPreferences *preferences = [[WKPreferences alloc] init];
    //    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 100.0;
    //    configuration.preferences = preferences;
    
    return wkUController;
}

//#pragma mark - WKNavigationDelegate
////请求之前，决定是否要跳转:用户点击网页上的链接，需要打开新页面时，将先调用这个方法。
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
////接收到相应数据后，决定是否跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
////页面开始加载时调用
//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//// 主机地址被重定向时调用
//- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
//// 页面加载失败时调用
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//// 当内容开始返回时调用
//- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;
//// 页面加载完毕时调用
//- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
////跳转失败时调用
//- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler;
////9.0才能使用，web内容处理中断时会触发
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0);


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
