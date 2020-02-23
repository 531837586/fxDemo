//
//  UIWebViewVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/1.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "UIWebViewVC.h"
#import <objc/message.h>

@interface UIWebViewVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation UIWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, 50, 50)];
    leftLabel.backgroundColor = [UIColor lightGrayColor];
    leftLabel.text = @"左边";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:leftLabel];
    [leftLabel onClick:^(id obj) {
        
    }];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, STATUS_AND_NAV_BAR_HEIGHT, 50, 50)];
    rightLabel.backgroundColor = [UIColor lightGrayColor];
    rightLabel.text = @"右边";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:rightLabel];
    [rightLabel onClick:^(id obj) {
        NSString *result = [self.webView stringByEvaluatingJavaScriptFromString:@"showAlert('点右边的传给JS的值')('闭包传值')"];
        NSLog(@"点击右边调用JS返回结果 = %@",result);
    }];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.top = STATUS_AND_NAV_BAR_HEIGHT+50;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
       
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index.html" withExtension:nil];;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
     
}

// 加载所有请求数据,以及控制是否加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"request = %@",request);
    // 路由能力 --
    NSLog(@"URL = %@",request.URL.pathComponents);
    NSLog(@"scheme = %@",request.URL.scheme);
    // 综合以上 - 拦截本地文件加载
    // 拦截路由 -- 制定出自己的一套路由方案
    // JS 响应我是不是可以接收到 - OC
    // js 传参数 -- data
    // js -> OC 调用 getSum(10,20)
    // 方法 - 参数
    
    // scheme - 路由发放响应
    // JS -> OC
    NSString *scheme = request.URL.scheme;
    if ([scheme isEqualToString:@"lgedu"]) {
        NSLog(@"来的是我自己的路由");
        NSArray *array = request.URL.pathComponents;
        // 非空处理 - bug
        NSString *methodName = array[1];

        if ([methodName isEqualToString:@"getSum"]) {
            // array[2],array[3]
            NSLog(@"%@-%@",array[2],array[3]);
        }
        
        [self performSelector:NSSelectorFromString(methodName) withObject:array afterDelay:0];
        
        // js 函数
        // OC 方法
        // objc_msgSend(<#id  _Nullable self#>, <#SEL  _Nonnull op, ...#>)
        
        return NO; //不加载链接
    }

    return YES;
}

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //  进度条
    NSLog(@"****************华丽的分界线****************");
    NSLog(@"开始加载咯!!!!");
}

// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
 
    // tittle
    NSString *tittle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = tittle;
    
//    给js传全局变量
//    [self.webView stringByEvaluatingJavaScriptFromString:@"var arr = @[username,userID]"];
    
    NSLog(@"****************华丽的分界线****************");
    NSLog(@"加载完成了咯!!!!");
}

// 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"****************华丽的分界线****************");
    NSLog(@"加载失败了咯,为什么:%@",error);
}



@end
