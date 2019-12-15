//
//  LogView.m
//  fxDemo
//
//  Created by 樊星 on 2019/5/31.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "LogView.h"

@implementation LogView

-(UITextView *)logTextView{
    if(!_logTextView){
        _logTextView = [[UITextView alloc] initWithFrame:self.bounds];
        _logTextView.textAlignment = NSTextAlignmentCenter;
        _logTextView.backgroundColor = COLOR_RANDOM;
        _logTextView.editable = NO;
    }
    return _logTextView;
}

-(void)configSubView{
    
    [self addSubview:self.logTextView];
    [self redirectSTD:STDOUT_FILENO];
    [self redirectSTD:STDERR_FILENO];
}

- (void)redirectNotificationHandle:(NSNotification *)nf{ // 通知方法
    NSData *data = [[nf userInfo] objectForKey:NSFileHandleNotificationDataItem];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    self.logTextView.text = [NSString stringWithFormat:@"%@\n\n%@",self.logTextView.text, str];// logTextView 就是要将日志输出的视图（UITextView）
    NSRange range;
    range.location = [self.logTextView.text length] - 1;
    range.length = 0;
    [self.logTextView scrollRangeToVisible:range];
    [[nf object] readInBackgroundAndNotify];
}

- (void)redirectSTD:(int )fd{
    NSPipe * pipe = [NSPipe pipe] ;// 初始化一个NSPipe 对象
    NSFileHandle *pipeReadHandle = [pipe fileHandleForReading] ;
    dup2([[pipe fileHandleForWriting] fileDescriptor], fd) ;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(redirectNotificationHandle:)
                                                 name:NSFileHandleReadCompletionNotification
                                               object:pipeReadHandle]; // 注册通知
    [pipeReadHandle readInBackgroundAndNotify];
}

@end
