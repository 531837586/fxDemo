//
//  LGGCDTimer.h
//  007---Dispatch_source
//
//  Created by cooci on 2019/3/13.
//  Copyright © 2019 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGGCDTimer : NSObject

- (void)start;
- (void)supend;
- (instancetype)initWithTimer:repertBlock;
// timer 准确灵活，独立，不收runloop影响

@end

NS_ASSUME_NONNULL_END
