//
//  NSURLProtocolVC.m
//  fxDemo
//
//  Created by 樊星 on 2020/2/3.
//  Copyright © 2020 樊星. All rights reserved.
//

#import "NSURLProtocolVC.h"
#import <WebKit/WebKit.h>
#import <AFNetworking.h>
#import "KCURLProtocol.h"

static NSString *url  = @"http://www.baidu.com/";

@interface NSURLProtocolVC ()<NSURLSessionDataDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) WKWebView *wk;
@end

@implementation NSURLProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [NSURLProtocol registerClass:[KCURLProtocol class]];
    [KCURLProtocol hookNSURLSessionConfiguration];
    
    UILabel *loadBaidu = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 30)];
    loadBaidu.text = @"加载webView百度";
    loadBaidu.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loadBaidu];
    [loadBaidu onClick:^(id obj) {
        [self.webView removeFromSuperview];
        [self.wk removeFromSuperview];
        self.webView = nil;
        self.wk = nil;
      
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 300, self.view.bounds.size.width, 300)];
      
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        [self.webView loadRequest:request];
        [self.view addSubview:self.webView];
    }];
    
    UILabel *loadWKBaidu = [[UILabel alloc] initWithFrame:CGRectMake(0, loadBaidu.bottom+20, self.view.width, 30)];
    loadWKBaidu.text = @"加载WK百度";
    loadWKBaidu.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loadWKBaidu];
    [loadWKBaidu onClick:^(id obj) {
        [self.webView removeFromSuperview];
        [self.wk removeFromSuperview];
        self.webView = nil;
        self.wk = nil;
        
        self.wk = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 400, self.view.bounds.size.width, 400)];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
        [self.wk  loadRequest:request];
        [self.view addSubview:self.wk ];
    }];
    
    
//    NSURLProtocol 在AFN和Session拦截会失效，应为
    UILabel *loadAFN = [[UILabel alloc] initWithFrame:CGRectMake(0, loadWKBaidu.bottom+20, self.view.width, 30)];
    loadAFN.text = @"加载AFN";
    loadAFN.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loadAFN];
    [loadAFN onClick:^(id obj) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
        [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"AFN---%@",responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"AFN---%@",error);
        }];
    }];
    
    UILabel *loadURLSession = [[UILabel alloc] initWithFrame:CGRectMake(0, loadAFN.bottom+20, self.view.width, 30)];
    loadURLSession.text = @"加载URLSession";
    loadURLSession.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loadURLSession];
    [loadURLSession onClick:^(id obj) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:mainQueue];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];

        [dataTask resume];
    }];
    
    UILabel *loadURLConnection = [[UILabel alloc] initWithFrame:CGRectMake(0, loadURLSession.bottom+20, self.view.width, 30)];
    loadURLConnection.text = @"加载URLConnection";
    loadURLConnection.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loadURLConnection];
    [loadURLConnection onClick:^(id obj) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
           
            NSLog(@"URLSession:data == %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

        }];
    }];
    
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    NSLog(@"data == %@",data);
}

- (void)dealloc{
    [NSURLProtocol unregisterClass:[KCURLProtocol class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
