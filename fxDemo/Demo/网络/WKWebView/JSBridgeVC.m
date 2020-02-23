//
//  JSBridgeVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/2.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "JSBridgeVC.h"
#import <WebViewJavascriptBridge.h>
#import <WebKit/WebKit.h>

@interface JSBridgeVC ()<WKUIDelegate>
@property (strong, nonatomic) WKWebView   *webView;
@property (nonatomic, strong) WebViewJavascriptBridge *wjb;

@end

@implementation JSBridgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    configuration.userContentController = wkUController;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"index4.html" ofType:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    [self.webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
    
    self.wjb = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    // 如果你要在VC中实现 UIWebView的代理方法 就实现下面的代码(否则省略)
     [self.wjb setWebViewDelegate:self];
    
    
    // 编辑器
    // js - 自己OC 封装一个JS 编辑器
    // 字体 颜色 -- html
    // 图片 - 播放器
    
    [self.wjb registerHandler:@"jsCallsOC" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        // 这个框架默认回调都是在主线程回调，不怪框架，如果阻塞就是用户自己阻塞的
        
        NSLog(@"currentThread == %@",[NSThread currentThread]);
        
        NSLog(@"data == %@ -- %@",data,responseCallback);
    }];
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
