//
//  GetChannelVC.m
//  fxDemo
//
//  Created by 樊星 on 2019/10/22.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "GetChannelVC.h"
#import "LogView.h"

@interface GetChannelVC ()

@end

@implementation GetChannelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    LogView *logView = [[LogView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:logView];
    
    
    
    NSFileManager *fileManager= [NSFileManager defaultManager];

    //在这里获取应用程序Documents文件夹里的文件及文件夹列表

//    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *bunPath = [[NSBundle mainBundle] bundlePath];
    //    NSString *codePath = [bunPath stringByAppendingPathComponent:@"_CodeSignature/kk_agent"];
        NSString *documentPaths = [bunPath stringByAppendingPathComponent:@"channel"];

//    NSString *documentDir= [documentPaths objectAtIndex:0];
    NSString *documentDir = documentPaths;

    NSError *error=nil;

    NSArray *fileList= [[NSArray alloc] init];

    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组

    fileList= [fileManager contentsOfDirectoryAtPath:documentDir error:&error];

    
    
    
//    NSMutableArray *dirArray= [[NSMutableArray alloc] init];
//
//    BOOL isDir=NO;
//
//    //在上面那段程序中获得的fileList中列出文件夹名
//
//    for (NSString *file in fileList) {
//
//    NSString *path= [documentDir stringByAppendingPathComponent:file];
//
//    [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
//
//    if (isDir) {
//
//    [dirArray addObject:file];
//
//    }
//
//    isDir=NO;
//
//    }

    NSLog(@"Every Thing in the dir:%@",fileList);

//    NSLog(@"All folders:%@",dirArray);

    
}



@end
