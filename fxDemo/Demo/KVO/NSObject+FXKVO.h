//
//  NSObject+FXKVO.h
//  fxDemo
//
//  Created by 樊星 on 2019/12/21.
//  Copyright © 2019 樊星. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FXKVOInfo.h"

@interface NSObject (FXKVO)

- (void)fx_addObserver:(NSObject *_Nullable)observer
            forKeyPath:(NSString *_Nullable)keyPath
               options:(FXKeyValueObservingOptions)options
               context:(nullable void *)context handBlock:(FXKVOBlock _Nullable )handBlock;

//- (void)fx_observeValueForKeyPath:(NSString *_Nullable)keyPath
//                         ofObject:(id _Nullable )object
//                           change:(NSDictionary<NSKeyValueChangeKey,id> *_Nullable)change
//                          context:(void *_Nullable)context;

//- (void)fx_removeObserver:(NSObject *_Nullable)observer forKeyPath:(NSString *_Nullable)keyPath;
@end


