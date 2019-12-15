//
//  FXShadowVC.m
//  fxDemo
//
//  Created by 樊星 on 2019/4/15.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "FXShadowVC.h"

@interface FXShadowVC ()

@end

@implementation FXShadowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"实现圆角阴的影方式";
    
    [self configSubViewOne];
    [self configSubViewTwo];
    [self configSubViewThree];
}

-(void)configSubViewOne{
    
    UIView *frontView = [[UIView alloc] initWithFrame:CGRectMake(25, 100, 100, 100)];
    frontView.layer.cornerRadius = 50;
    frontView.layer.masksToBounds = YES;
    frontView.backgroundColor = COLOR_RANDOM;
    
    CALayer *subLayer=[CALayer layer];
    CGRect fixframe = frontView.frame;
    subLayer.frame= fixframe;
    subLayer.cornerRadius=50;
    subLayer.backgroundColor=frontView.backgroundColor.CGColor;
    subLayer.masksToBounds=NO;
    subLayer.shadowColor = frontView.backgroundColor.CGColor;//shadowColor阴影颜色
    subLayer.shadowOffset = CGSizeMake(0,5);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    subLayer.shadowOpacity = 0.8;//阴影透明度，默认0
    subLayer.shadowRadius = 4;//阴影半径，默认3
    [self.view.layer insertSublayer:subLayer below:frontView.layer];
}

-(void)configSubViewTwo{
    
    UIView *frontView = [[UIView alloc] initWithFrame:CGRectMake(135, 100, 100, 100)];
    frontView.layer.cornerRadius = 50;
    frontView.layer.masksToBounds = NO;
    frontView.backgroundColor = COLOR_WHITE;
    frontView.layer.shadowColor = COLOR_BLACK.CGColor;//shadowColor阴影颜色
    frontView.layer.shadowOffset = CGSizeMake(0,5);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    frontView.layer.shadowOpacity = 0.08;//阴影透明度，默认0
    frontView.layer.shadowRadius = 4;//阴影半径，默认3
    [self.view addSubview:frontView];
    
//    UIView *subView = [UIView new];
//    CGRect fixframe = frontView.bounds;
//    subView.frame= fixframe;
//    subView.layer.cornerRadius=50;
//    subView.layer.masksToBounds=YES;
//    [frontView addSubview:subView];
}

-(void)configSubViewThree{
    
    UIView *parentView = [UIView new];
    CGRect fixframe =   CGRectMake(245, 100, 100, 100);
    parentView.frame= fixframe;
    parentView.layer.cornerRadius=50;
    parentView.backgroundColor = COLOR_WHITE;
    parentView.layer.shadowColor = COLOR_BLACK.CGColor;//shadowColor阴影颜色
    parentView.layer.shadowOffset = CGSizeMake(0,5);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
    parentView.layer.shadowOpacity = 0.2;//阴影透明度，默认0
    parentView.layer.shadowRadius = 4;//阴影半径，默认3
    [self.view addSubview:parentView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:Img(@"kongfu_image")];
    imageView.frame = parentView.bounds;
    imageView.layer.cornerRadius = 50;
    imageView.layer.masksToBounds = YES;
 
    [parentView addSubview:imageView];

}
@end
