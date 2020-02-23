//
//  KC_JSObject.h
//  003---JavaScriptCoreDemo
//
//  Created by Cooci on 2018/7/26.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h> //开源的，可以下载源码

@protocol KCProtocol <JSExport>

- (void)letShowImage;
// 协议 - 协议方法
//会给对象增加getSum方法，不用重复声明
JSExportAs(getSum, -(int)getSum:(int)num1 num2:(int)num2);//方法起别名

@end

@interface KC_JSObject : NSObject<KCProtocol>
@end
