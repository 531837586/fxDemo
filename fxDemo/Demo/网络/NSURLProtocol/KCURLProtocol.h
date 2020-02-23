//
//  KCURLProtocol.h
//  001---NSURLProtocol
//
//  Created by Cooci on 2018/8/22.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCURLProtocol : NSURLProtocol<NSURLSessionDataDelegate>
@property (nonatomic, strong) NSURLSession *session;

+ (void)hookNSURLSessionConfiguration;
@end
