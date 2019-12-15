//
//  AnimationImageVC.m
//  fxDemo
//
//  Created by 樊星 on 2019/9/6.
//  Copyright © 2019 樊星. All rights reserved.
//

#import "AnimationImageVC.h"

@interface AnimationImageVC ()
@property (nonatomic, strong) UIImageView *topBackgroundImage;
@property (nonatomic, strong) UIImageView *topBehindBackgroundImage;
@property (nonatomic, strong) CABasicAnimation *normalAnimation;
@end

@implementation AnimationImageVC

- (UIImageView *)topBackgroundImage {
    
    if(!_topBackgroundImage) {
        _topBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kk_game_login_top_V_background"]];
//        _topBackgroundImage.contentMode = UIViewContentModeScaleAspectFit;
        _topBackgroundImage.clipsToBounds = YES;
        [self.view addSubview:_topBackgroundImage];
    }
    return _topBackgroundImage;
}

- (UIImageView *)topBehindBackgroundImage {
    
    if(!_topBehindBackgroundImage) {
        _topBehindBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kk_game_login_top_V_background"]];
//        _topBehindBackgroundImage.contentMode = UIViewContentModeScaleAspectFit;
        _topBehindBackgroundImage.clipsToBounds = YES;
        [self.view addSubview:_topBehindBackgroundImage];
    }
    return _topBehindBackgroundImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startAnimation];
}

- (void)configUI{
    
//    self.topBackgroundImage.frame = CGRectMake(0, 0, floor(self.view.height*(4500/1334)), self.view.height);
//    self.topBehindBackgroundImage.frame = CGRectMake(floor(self.view.height*(4500/1334))-5, 0, floor(self.view.height*(4500/1334)), self.view.height);
//
//    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:2];
    CGFloat imageWidth = floor(5000/2);
    self.topBackgroundImage.frame = CGRectMake(0, 0, imageWidth, self.view.height);
    self.topBehindBackgroundImage.frame = CGRectMake(imageWidth-5, 0, imageWidth, self.view.height);
    
//    self.topBackgroundImage.frame = CGRectMake(0, 0, floor(1366), self.view.height);
//    self.topBehindBackgroundImage.frame = CGRectMake(floor(1366)-5, 0, floor(1366/2), self.view.height);
}

-(void)startAnimation {
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.repeatCount = HUGE_VALF;
    animation.duration = 20;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CGPoint point = self.topBackgroundImage.layer.position;
        animation.values = @[[NSValue valueWithCGPoint:point],[NSValue valueWithCGPoint:CGPointMake(point.x-self.topBackgroundImage.width, point.y)]];
    [self.topBackgroundImage.layer addAnimation:animation forKey:nil];
    animation.values = @[[NSValue valueWithCGPoint:self.topBehindBackgroundImage.layer.position], [NSValue valueWithCGPoint:point]];
    [self.topBehindBackgroundImage.layer addAnimation:animation forKey:nil];
    
    
//    float behindViewOriX = floor(self.view.height*(4500/1334)-5);
//    float distace =  floor(self.view.height*(4500/1334));
//
//    [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.topBackgroundImage.left = -distace;
//        self.topBehindBackgroundImage.left = behindViewOriX-distace;
//    } completion:^(BOOL finished) {
//        self.topBackgroundImage.left = behindViewOriX;
//        [UIView animateWithDuration:10 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//            self.topBackgroundImage.left = behindViewOriX-distace;
//            self.topBehindBackgroundImage.left = behindViewOriX-distace-distace;
//        } completion:^(BOOL finished) {
//            self.topBehindBackgroundImage.left = behindViewOriX;
//            [self startAnimation];
//        }];
//    }];
}

-(void)stopAnimation {
    [self.topBackgroundImage.layer removeAllAnimations];
    [self.topBehindBackgroundImage.layer removeAllAnimations];
}

@end
