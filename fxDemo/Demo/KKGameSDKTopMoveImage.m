////
////  KKGameSDKTopMoveImage.m
////  KKGameSDK
////
////  Created by 樊星 on 2019/8/2.
////  Copyright © 2019 樊星. All rights reserved.
////
//
//#import "KKGameSDKTopMoveImage.h"
//
//@interface KKGameSDKTopMoveImage ()<CAAnimationDelegate>
//@property (nonatomic, strong) UIImageView *placeBackgroundImage;
// 
//@property (nonatomic, strong) UILabel *titleLabel;
// 
//@end
//
//@implementation KKGameSDKTopMoveImage
//
//- (UIImageView *)topBackgroundImage {
//    
//    if(!_topBackgroundImage) {
//        _topBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kk_game_login_top_V_background"]];
//        _topBackgroundImage.contentMode = UIViewContentModeScaleAspectFill;
//        _topBackgroundImage.clipsToBounds = YES;
//        [self addSubview:_topBackgroundImage];
//    }
//    return _topBackgroundImage;
//}
//
//- (UIImageView *)topBehindBackgroundImage {
//    
//    if(!_topBehindBackgroundImage) {
//        _topBehindBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kk_game_login_top_V_background"]];
//        _topBehindBackgroundImage.contentMode = UIViewContentModeScaleAspectFill;
//        _topBehindBackgroundImage.clipsToBounds = YES;
//        [self addSubview:_topBehindBackgroundImage];
//    }
//    return _topBehindBackgroundImage;
//}
//
//- (UILabel *)titleLabel{
//    if(!_titleLabel){
//        _titleLabel = [UILabel new];
//        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
//        _titleLabel.textColor = COLOR_HEX(0xffffff);
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_titleLabel];
//    }
//    return _titleLabel;
//}
//
//- (UIImageView *)backImage{
//    if(!_backImage){
//        _backImage = [UIImageView new];
//        _backImage.contentMode = UIViewContentModeCenter;
//        [self addSubview:_backImage];
//    }
//    return _backImage;
//}
//
//-(void)configUI{
//}
//
//- (void)configBackImage:(NSString *)imageName{
//    self.topBackgroundImage.image = [UIImage imageNamed:imageName];
//    self.topBehindBackgroundImage.image = [UIImage imageNamed:imageName];
//}
//
//- (void)configTitle:(NSString *)title{
//    self.titleLabel.text = title;
//}
//
//- (void)setFrame:(CGRect)frame{
//    [super setFrame:frame];
//}
//
//- (void)setNeedAnimation:(BOOL)needAnimation{
//    _needAnimation = needAnimation;
//    if(needAnimation) [self startAnimation];
//}
//
//- (void)setIsShowBackImage:(BOOL)isShowBackImage{
//    if(isShowBackImage){
//        self.backImage.image = [UIImage imageNamed:@"kk_game_back_image"];
//    }
//}
//
//-(void)startAnimation {
// 
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
//    animation.repeatCount = HUGE_VALF;
//    animation.duration = 20;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    CGPoint point = self.topBackgroundImage.layer.position;
////    animation.values = @[[NSValue valueWithCGPoint:point],[NSValue valueWithCGPoint:CGPointMake(point.x-self.topBackgroundImage.width,point.y)]];
//    [self.topBackgroundImage.layer addAnimation:animation forKey:nil];
//    animation.values = @[[NSValue valueWithCGPoint:self.topBehindBackgroundImage.layer.position], [NSValue valueWithCGPoint:point]];
//    [self.topBehindBackgroundImage.layer addAnimation:animation forKey:nil];
//}
//
//-(void)stopAnimation {
//    [self.topBackgroundImage.layer removeAllAnimations];
//    [self.topBehindBackgroundImage.layer removeAllAnimations];
//}
//
//@end
