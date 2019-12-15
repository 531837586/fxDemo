//
//  FXReadLocalFile.h
//  fxDemo
//
//  Created by 樊星 on 2019/3/8.
//  Copyright © 2019 樊星. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FXReadLocalFile : NSObject
+ (NSDictionary *)readLocalFileWithName:(NSString *)name;
+ (NSDictionary *)readLocalPlistWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
