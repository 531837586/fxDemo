//
//  CategoryVC.m
//  fxDemo
//
//  Created by 樊星 on 2019/12/15.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "CategoryVC.h"
#import "FXPerson.h"
#import "FXPerson+something.h"

@interface CategoryVC ()

@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FXPerson *p = [FXPerson new];
//    [p walk];
    [self printMethodNamesOfClass:[p class]];
}

#pragma mark - 遍历方法
- (void)printMethodNamesOfClass:(Class)cls
{
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    // 释放
    free(methodList);
    // 打印方法名
    NSLog(@"%@ - %@", cls, methodNames);
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
