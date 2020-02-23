//
//  DictionaryVC.m
//  fxDemo
//
//  Created by 樊星 on 2019/8/29.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "DictionaryVC.h"
//#import <UITemplateKit-umbrella.h>
#import <AdSupport/AdSupport.h>

@interface DictionaryVC ()

@end

@implementation DictionaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configData];
    
    UILabel *textLabel = [UILabel new];
    textLabel.text = @"1234";
    [self.view addSubview:textLabel];
    
//    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // 判断是否开启
    // 判断是否开启  限制广告跟踪选项（该选项在设置-隐私-广告-限制广告隐私）
//    Boolean on = [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled];
    
    [self test];
    [self test1];
}

- (void)test{
    
    NSMutableArray *tempLable = [NSMutableArray array];
    
    NSArray *subviews = [self.view subviews];
    
    
    [subviews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *tempLableArray = [NSMutableArray array];
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *testLable = obj;
            
            NSLog(@"========test%@",testLable.text);
            
            [tempLableArray addObject:testLable.text];
        }
        
        [tempLable addObject:tempLableArray];
        
    }];
}

- (void)configData{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    [dic setValue:@"1" forKey:@"z"];
    [dic setValue:@"1" forKey:@"x"];
    [dic setValue:@"1" forKey:@"y"];
    [dic setValue:@"1" forKey:@"a"];
    [dic setValue:@"1" forKey:@"b"];
    [dic setValue:@"1" forKey:@"c"];
}

- (void)test1{
    
//    popview = [[CatDefaultPop alloc] initWithTitle:@"title" content:@"content" confirmTitle:@"confirm"];
//    popview.delegate = self;
//    [popview popUpCatDefaultPopView];
//
}

//-(void)catDefaultPopConfirm:(CatDefaultPop *)defaultPop{
//    
//    NSLog(@"1");
//}

@end
