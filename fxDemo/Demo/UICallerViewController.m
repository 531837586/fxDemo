//
//  UICallerViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/4/16.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "UICallerViewController.h"

@interface UICallerViewController()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation UICallerViewController

-(UIScrollView *)scrollView{
    if(!_scrollView){
//        CGFloat hotHeidht = HOTSPOT_STATUSBAR_HEIGHT;
//        CGFloat sysHeight = SYS_STATUSBAR_HEIGHT;
//        CGFloat navHeight = NAV_BAR_HEIGHT;
//        CGFloat statusHeight = STATUS_BAR_HEIGHT;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, STATUS_AND_NAV_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT)];
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_AND_NAV_BAR_HEIGHT+1);
//        _scrollView.bounces = YES;
        _scrollView.backgroundColor = [UIColor grayColor];
    }
    return _scrollView;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.scrollView];
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height-99, 100, 100)];
    textView.backgroundColor = COLOR_BLUE;
    [self.scrollView addSubview:textView];
}

//-(void)statusBarHeightChanged{
//    
//}

@end
