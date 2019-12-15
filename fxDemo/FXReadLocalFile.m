//
//  FXReadLocalFile.m
//  fxDemo
//
//  Created by 樊星 on 2019/3/8.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "FXReadLocalFile.h"

@implementation FXReadLocalFile

#pragma mark - 处理html字符串
// 读取本地JSON文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

+ (NSDictionary *)readLocalPlistWithName:(NSString *)name{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"attributeString" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", data);//直接打印数据。
    return data;
}
@end
