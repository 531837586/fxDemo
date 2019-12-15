//
//  DisfileViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/7/31.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "DisfileViewController.h"

@interface DisfileViewController ()

@end

@implementation DisfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getAppList];
//    [self opurl];
    [self getUUID];
}

// 普通的获取UUID的方法
- (NSString *)getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    return result;
}

- (void)getAppList
{
    Class LSApplicationWorkspace_Class = NSClassFromString(@"LSApplicationWorkspace");
    NSObject *workspace = [LSApplicationWorkspace_Class performSelector:NSSelectorFromString(@"defaultWorkspace")];
    NSArray *appList = [workspace performSelector:NSSelectorFromString(@"allApplications")];
    for (id app in appList) {
        NSLog(@"-----App列表----%@", [app performSelector:NSSelectorFromString(@"applicationIdentifier")]);
    }
}

-(void)opurl{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://online-qianzhouyouxi.oss-cn-shanghai.aliyuncs.com/games/KK%E6%B8%B8%E6%88%8F.mobileconfig"]];
}

@end
