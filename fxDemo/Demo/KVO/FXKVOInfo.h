//
//  FXKVOInfo.h
//  fxDemo
//
//  Created by 樊星 on 2019/12/27.
//  Copyright © 2019 樊星. All rights reserved.
//

typedef NS_OPTIONS(NSUInteger, FXKeyValueObservingOptions){
     FXKeyValueObservingOptionNew = 0x01,
     FXKeyValueObservingOptionOld = 0x02,
};


typedef void(^FXKVOBlock)(NSObject * _Nullable observer, NSString * _Nullable  keyPath, id _Nullable oldValue, id _Nullable newValue);

#import <Foundation/Foundation.h>
#import "NSObject+FXKVO.h"

NS_ASSUME_NONNULL_BEGIN

@interface FXKVOInfo : NSObject

@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, assign) FXKeyValueObservingOptions options;
@property (nonatomic, copy) FXKVOBlock handBlock;

- (instancetype)initWithObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(FXKeyValueObservingOptions)options handBlock:(FXKVOBlock)handBlock;
@end

NS_ASSUME_NONNULL_END
