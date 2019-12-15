//
//  WCmsSDK.h
//  WanCmsSDK-Code
//
//  Created by Stack on 2017/2/10.
//  Copyright © 2017年 Joker_chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WCmsSDK : NSObject

/**
 *  加载登陆页面
 *
 *  @param successBlock 登陆成功回调
 *  @param failedBlock  失败回调
 *  状态码描述
 code = -1 : 用户名不能为空
 code = -2 : 用户名长度不正确
 code = -3 : 没有注册设备来源
 code = -4 : 密钥不对
 code = -5 : 渠道ID不能为空
 code = -6 : 账号不存在或者密码不正确
 code = -7 : 游戏ID不能为空
 code = -8 : 注册失败
 code = 501: 网络连接失败
 */
+ (void)loadLoginViewResultSuccess:(void(^)(NSString *logintime ,NSString *userName ,NSString *sign))successBlock failed:(void(^)(NSInteger code, NSString *message)) failedBlock;


/**
 *  加载支付页面
 *
 *  @param roleid       角色id
 *  @param ServiceID    服务器id
 *  @param money        支付金额
 *  @param attach    扩展参数
 *  @param name         商品名称
 *  @param desc         商品说明
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 *  状态码描述
 code = -1 : 缺少参数，请重试
 code = -2 : 密钥不对
 code = -3 : 渠道ID不能为空
 code = -4 : 用户名不能为空
 code = -5 : 游戏ID不能为空
 code = -6 : 余额不足
 code = -7 : 内部服务器发生错误，请重试！
 code = -8 : 没有回调地址，请通知我方配置
 code = -9 : 充值金额必须大于0
 
 */
+ (void)loadToPayVCWithroleid:(NSString*)roleid
                        money:(NSString *)money
                     serverid:(NSString*)ServiceID
                  productName:(NSString *)name
                  productDesc:(NSString *)desc
                       attach:(NSString *)attach
                      success:(void(^)(NSString *message,NSString *money))successBlock faild:(void(^)(NSString *message,NSInteger code,NSString *money))faildBlock;


/**
 *  退出登陆
 */
+ (void)LoginOut;


/**
 *  设置用户信息－－－支持改名（option）
 *
 *  @param roleId   角色id               必须
 *  @param roleName 角色名(支持改名)       必须
 *  @param Level    角色等级              必须
 *  @param zoneId   角色所在区服唯一标示符  必须
 *  @param zoneName 角色所在区服名         必须
 *  @param block    提交结果block         (0:提交失败 1:成功 2:信息不全)
 */
+ (void)SetUserInfoDataWithRoleId:(NSString*)roleId roleName:(NSString*)roleName roleLevel:(NSString*)Level zoneId:(NSString*)zoneId zoneName:(NSString*)zoneName attach:(NSString *)attach block:(void(^)(NSInteger code))block;


/**
 * 支付宝回调处理
 */
+ (void)application:(UIApplication *)application handleOpenURL:(NSURL *)url;

+ (void)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

+ (void)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

@end
