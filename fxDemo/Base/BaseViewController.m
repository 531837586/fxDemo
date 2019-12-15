//
//  BaseViewController.m
//  fxDemo
//
//  Created by 樊星 on 2019/4/15.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configDefaultUI];
    [self addObserver];
}

-(void)configDefaultUI{
    
    self.view.backgroundColor = COLOR_BG;
    [self setNavigationBarShadowColor:COLOR_GRAY_LINE];
    
    self.view.autoresizingMask =  UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
}
- (void)setNavigationBarShadowColor:(UIColor *)color{
    [self.navigationController.navigationBar setShadowImage:[FXUtils imageWithColor:color size:CGSizeMake(SCREEN_WIDTH, 0.5)]];
}

- (void)addObserver{

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusFrameChanged:)
                                                 name:UIApplicationDidChangeStatusBarFrameNotification
                                               object:nil];
}

//- (void)checkStatusBarNormal {
//    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
//    CGFloat statusBarHeight = statusBarFrame.size.height;
//    if (statusBarHeight == 20.0) {
//        self.isStatusBarNormal = YES;
//    } else {
//        self.isStatusBarNormal = NO;
//    }
//}
//
//- (void)layOutControllerViews {
//    CGRect mainFrame = self.view.frame;
//    CGRect leftMenuFrame = self.view.frame;
//    mainFrame.origin.y = 0;
//    leftMenuFrame.origin.y = 0;
//    leftMenuFrame.size.height = SCREEN_HEIGHT;
//    if (!self.isStatusBarNormal) {
//        mainFrame.size.height = SCREEN_HEIGHT;
//    }
//    _mainVc.view.frame = mainFrame;
//    self.view.frame = leftMenuFrame;
//}


//-(void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
////    self.view.frame.origin.y = 0;
////    self.view.frame.size.height = SCREEN_HEIGHT
//}

-(void)statusFrameChanged:(NSNotification*) note
{
    
//    self.view.frame.origin.y = 0;
//    self.view
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    CGFloat statusHeight = statusBarFrame.size.height;
    NSLog(@"%f", statusHeight);
    if (statusHeight == 44) {
        statusHeight = 0;
    }else if (statusHeight == 40)
    {
        statusHeight = 20;
    }else if (statusHeight == 20)
    {
        statusHeight = -20;
    }
        
    self.view.transform = CGAffineTransformScale(self.view.transform, 1, (SCREEN_HEIGHT-statusHeight)/SCREEN_HEIGHT);
    self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, -statusHeight/2);
//        self.view.transform = CGAffineTransformMakeScale(1, 1);
//
//    UIScreen *screen = [UIScreen mainScreen];
//    CGRect viewRect = screen.bounds;
//
//    viewRect.size.height -= statusHeight;
//    viewRect.origin.y = statusHeight;
//
//    self.view.frame = viewRect;
//    [self.view setNeedsLayout];
}

 
@end
