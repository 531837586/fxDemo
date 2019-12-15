//
//  AppDelegate.m
//  fxDemo
//
//  Created by 樊星 on 2019/3/6.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "AppDelegate.h"
//#import <Growing/Growing.h>
#import "RootNavigationController.h"
#import "MenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];//UIScreen mainScreen].bounds个人理解获取屏幕的硬件信息然后设置尺寸大小
    RootNavigationController *nav =  [[RootNavigationController alloc] initWithRootViewController:[MenuViewController new]];
    self.window.rootViewController = nav;//设置根视图控制器
    [self.window makeKeyAndVisible];//设置成为主窗口并显示
    
//    [Growing startWithAccountId:@"bf27ce0ccf00100a"];
//    [Growing disablePushTrack:NO];  //开启推送点击采集
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    
    [self exitApplication];
//    if ([Growing handleUrl:url]) {
//        [self exitApplication];
//        return YES;
//    }
    return NO;
}

- (void)exitApplication {
    UIWindow *window = self.window;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
    [self performSelector:@selector(sdfafdafdfadsf:)];
}

@end
