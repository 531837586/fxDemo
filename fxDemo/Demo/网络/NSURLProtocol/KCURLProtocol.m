//
//  KCURLProtocol.m
//  001---NSURLProtocol
//
//  Created by Cooci on 2018/8/22.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "KCURLProtocol.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


static NSString *const kcProtocolKey = @"kcProtocolKey";

@implementation KCURLProtocol

// 这个方法是注册后,NSURLProtocol就会通过这个方法确定参数request是否需要被处理
// return : YES 需要经过这个NSURLProtocol"协议" 的处理, NO 这个 协议request不需要遵守这个NSURLProtocol"协议"
// 这个方法的作用 :
//   -| 1, 筛选Request是否需要遵守这个NSURLRequest ,
//   -| 2, 处理http: , https等URL
// 重定向
// 监听 - sdk -

+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    NSLog(@"*** %@",request);
    // md5
    if ([NSURLProtocol propertyForKey:kcProtocolKey inRequest:request]) {
        return NO;//自己的链接不需要hook，或者如果已经重定向过，就不需要在拦截了
    
    }
    
    // 直接hook 图片
    NSArray *array = @[@"png",@"jpg",@"jpeg"];
    if ([array containsObject:[request.URL pathExtension]]) {
        return YES; //返回YES需要重定向，会调用startloading方法
    }
    // 拦截百度的logo
    if ([[request.URL absoluteString] isEqualToString:@"https://m.baidu.com/static/index/plus/plus_logo_web.png"]) {
        return YES;
    }
    
    if ([[request.URL absoluteString] isEqualToString:@"http://www.baidu.com/"]) {
        return YES;
    }
    // 黑名单 -- 服务器 -- 本地
    //

    return NO;
}



// 需要在该方法中发起一个请求，对于NSURLConnection来说，就是创建一个NSURLConnection，对于NSURLSession，就是发起一个NSURLSessionTask
// 另外一点就是这个方法之后,会回调<NSURLProtocolClient>协议中的方法,

- (void)startLoading{
    NSLog(@"%s",__func__);
    NSArray *array = @[@"png",@"jpg",@"jpeg"];
    // 广告
    if ([array containsObject:[self.request.URL pathExtension]]) {
        NSData *data = [self getImageData];
        [self.client URLProtocol:self didLoadData:data];
    }
    
    // 拦截给与自己数据
    if ([[self.request.URL absoluteString] isEqualToString:@"https://m.baidu.com/static/index/plus/plus_logo_web.png"]) {
        NSData *data = [self getImageData];
        [self.client URLProtocol:self didLoadData:data];
    }
    
    if ([[self.request.URL absoluteString] isEqualToString:@"http://www.baidu.com/"]) {
        

//        NSString *url = @"http://127.0.0.1:8080/getMethod/";
                NSString *url = @"http://127.0.0.1:8080";
    
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLProtocol setProperty:@(YES) forKey:kcProtocolKey inRequest:request];//自己的链接不需要hook

        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            
            NSLog(@"Connection - %@---%@",response,data);
        }];
        
    }
}

// 这个方法是和start是对应的 一般在这个方法中,断开Connection
// 另外一点就是当NSURLProtocolClient的协议方法都回调完毕后,就会开始执行这个方法了
- (void)stopLoading{
    NSLog(@"stopLoading :来了");
}

// 这个方法就是返回规范的request
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    NSLog(@"%s",__func__);
    return request;
}

// 这个方法主要用来判断两个请求是否是同一个请求，
// 如果是，则可以使用缓存数据，通常只需要调用父类的实现即可,默认为YES,而且一般不在这里做事情
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}


#pragma mark - private

- (NSData *)getImageData{
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"lufei.jpg" ofType:@""];
    return [NSData dataWithContentsOfFile:fileName];
}

#pragma mark - hook

+ (void)hookNSURLSessionConfiguration{

    Class cls = NSClassFromString(@"__NSCFURLSessionConfiguration") ?: NSClassFromString(@"NSURLSessionConfiguration");
    
    Method originalMethod = class_getInstanceMethod(cls, @selector(protocolClasses));
    Method stubMethod = class_getInstanceMethod([self class], @selector(protocolClasses));
    if (!originalMethod || !stubMethod) {
        [NSException raise:NSInternalInconsistencyException format:@"没有这个方法 无法交换"];
    }
    method_exchangeImplementations(originalMethod, stubMethod);
}

- (NSArray *)protocolClasses {
//    <__NSArrayI 0x600002ac8bc0>(
//    _NSURLHTTPProtocol,
//    _NSURLDataProtocol,
//    _NSURLFTPProtocol,
//    _NSURLFileProtocol,
//    NSAboutURLProtocol
//    )
    return @[[KCURLProtocol class]];
    //如果还有其他的监控protocol,也可以在这里加进去
}



@end
