//
//  NSString+KCAdd.m
//  003---自定义NSOperation
//
//  Created by Cooci on 2018/7/6.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import "NSString+KCAdd.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (KCAdd)


/**
 下载图片的路径

 @return MD5加密的图片下载地址
 */
- (NSString *)getDowloadImagePath{
    
    //沙盒路径拼接LGDiskPath
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"LGDiskPath"];
    //再拼接MD5，加MD5目的是，防止逆向把你的下载地址，或者把主机地址使用爬虫爬数据。
    //所以进行相应的散列，让别人看不到。
    NSString *md5Str = [self kc_md5String];
    NSFileManager *fileManager = NSFileManager.defaultManager;
    if (![fileManager fileExistsAtPath:cachePath]) {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [cachePath stringByAppendingPathComponent:md5Str];
}

/**
 MD5 加密

 @return 返回MD5加密数据
 */
- (NSString *)kc_md5String{
//    const char *cStr = [self UTF8String];
//    unsigned char result[16];
//    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
//    return [NSString stringWithFormat:
//            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]
//            ];
    
    const char *str = self.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSURL *keyURL = [NSURL URLWithString:self];
    NSString *ext = keyURL ? keyURL.pathExtension : self.pathExtension;
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
            r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7],
            r[8], r[9], r[10],r[11], r[12], r[13], r[14], r[15],
            ext.length == 0 ? @"" : [NSString stringWithFormat:@".%@", ext]];

}
@end
