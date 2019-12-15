//
//  NSString+AES.h
//  fxDemo
//
//  Created by 樊星 on 2019/6/24.
//  Copyright © 2019 樊星. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES)
/**< 加密方法 */
- (NSString*)aci_encryptWithAES;

/**< 解密方法 */
- (NSString*)aci_decryptWithAES;
@end

NS_ASSUME_NONNULL_END
