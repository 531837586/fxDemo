//
//  FXTank.h
//  fxDemo
//
//  Created by 樊星 on 2020/2/17.
//  Copyright © 2020 樊星. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXTank : NSObject

//isa = 8
//内存 = isa + 1 * 4(abcd) + 1(union) = 8 + 4 + 1 = 13 对齐为 16


//@property (nonatomic, assign) NSString *fx_test;

@property (nonatomic, assign) BOOL fx_a;
@property (nonatomic, assign) BOOL fx_b;
@property (nonatomic, assign) BOOL fx_c;
@property (nonatomic, assign) BOOL fx_d;
//
//@property (nonatomic, assign) BOOL fx_e;
//@property (nonatomic, assign) BOOL fx_f;
//@property (nonatomic, assign) BOOL fx_g;
//@property (nonatomic, assign) BOOL fx_h;

//@property (nonatomic, assign) BOOL fx_i;

@property (nonatomic, assign) int fx_j;



- (void)setFront:(BOOL)isFront;
- (BOOL)isFront;

- (void)setBack:(BOOL)isBack;
- (BOOL)isBack;
@end

NS_ASSUME_NONNULL_END
