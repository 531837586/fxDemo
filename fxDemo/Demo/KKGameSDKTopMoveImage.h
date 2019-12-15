//
//  KKGameSDKTopMoveImage.h
//  KKGameSDK
//
//  Created by 樊星 on 2019/8/2.
//  Copyright © 2019 樊星. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKGameSDKTopMoveImage : UIView
@property (nonatomic, assign) BOOL needAnimation;
@property (nonatomic, assign) BOOL isShowBackImage;
@property (nonatomic, strong) UIImageView *backImage;
- (void)configBackImage:(NSString *)imageName;
- (void)configTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
