//
//  Macro.h
//  Rainbow
//
//  Created by david on 2019/1/3.
//  Copyright © 2019 gwh. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#pragma mark - 尺寸
#define NAV_BAR_HEIGHT (44.f)
#define STATUS_AND_NAV_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAV_BAR_HEIGHT)

// APP_STATUSBAR_HEIGHT=SYS_STATUSBAR_HEIGHT+[HOTSPOT_STATUSBAR_HEIGHT]
#define STATUS_BAR_HEIGHT (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
//// 标准系统状态栏高度
//#define SYS_STATUSBAR_HEIGHT     (CGRectGetHeight([UIApplication sharedApplication].statusBarFrame))
//// 热点栏高度
//#define HOTSPOT_STATUSBAR_HEIGHT  SYS_STATUSBAR_HEIGHT-20
//
//// 根据APP_STATUSBAR_HEIGHT判断是否存在热点栏
//#define IS_HOTSPOT_CONNECTED  (APP_STATUSBAR_HEIGHT==(SYS_STATUSBAR_HEIGHT+HOTSPOT_STATUSBAR_HEIGHT)?YES:NO)







#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)
#define STATUSBAR_ADD_NAVIGATIONBARHEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
/// 通讯录索引高度
#define KKSECTION_INDEX_HEIGHT 40.f


#pragma mark - scale
#define SCREEN_WIDTH_SCALE_5      (MIN(SCREEN_WIDTH,SCREEN_HEIGHT)/320.0*0.8+0.2)
#define SCREEN_WIDTH_SCALE_6      (MIN(SCREEN_WIDTH,SCREEN_HEIGHT)/375.0)
#define SCREEN_WIDTH_SCALE_6P     (MIN(SCREEN_WIDTH,SCREEN_HEIGHT)/414.0*0.8+0.2)
#define SCREEN_HEIGHT_SCALE_6P    (MAX(SCREEN_WIDTH,SCREEN_HEIGHT)/736.0*0.8+0.2)
#define ScreenWidthFullScale      (MIN(SCREEN_WIDTH,SCREEN_HEIGHT)/414)
#define ScreenWidthScaleWith(a)   (a/414.0*0.8+0.2)


#pragma mark - color
//RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define rgba(r,g,b,a) RGBA(r,g,b,a)
#define RGB(r,g,b)    RGBA(r,g,b,1.0f)
/** 常用颜色*/
#define COLOR_WHITE             RGB(255, 255, 255) //白色
#define COLOR_BLACK             RGB(0, 0, 0)       //黑色
#define COLOR_NAV               RGB(255, 255, 255) //导航背景色
#define COLOR_BG                RGB(244, 244, 244) //背景色
#define COLOR_BLUE              RGB(42, 62, 255)   //蓝色
#define COLOR_LIGHT_BLUE        RGB(204, 217, 252) //浅蓝色
#define COLOR_GRAY_LINE         RGB(238, 238, 238) //灰色分割线
#define COLOR_TABLE_HEADER      RGB(244, 244, 244) //浅灰色
#define COLOR_BLACK_TEXT        RGB(51, 51, 51)
#define COLOR_GRAY_TEXT         RGB(153, 153, 153)
#define COLOR_DARK_GRAY_TEXT    RGB(102, 102, 102)
#define COLOR_RANDOM            RGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 0.5)
//二进制颜色
#define COLOR_HEX(hex) [UIColor colorWithRed:((float)((hex & 0x00FF0000) >> 16)) / 255.0     \
green:((float)((hex & 0x0000FF00) >>  8)) / 255.0     \
blue:((float)((hex & 0x000000FF) >>  0)) / 255.0     \
alpha:1.0]


#pragma mark - 设备/版本
//系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define CurrentAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define CurrentAppBundleId [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
// 判断iPhone
#define iPhone4 (MAX(SCREEN_WIDTH, SCREEN_HEIGHT) == 480)
#define iPhone5 (MAX(SCREEN_WIDTH, SCREEN_HEIGHT) == 568)
#define iPhoneX (MAX(SCREEN_WIDTH, SCREEN_HEIGHT) >= 812)


#pragma mark - 简写
//缩写
#define New(T)     ([[T alloc] init])
#define Img(T)     ([UIImage imageNamed:T])
#define Url(T)     ([NSURL URLWithString:T])
#define Font(T)    ([UIFont systemFontOfSize:T])
#define FontB(T)   ([UIFont boldSystemFontOfSize:T])

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf)  __strong __typeof(&*weakSelf)strongSelf = weakSelf;

#pragma mark - log
#ifdef DEBUG
#   define BBLOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define BBLOG(...)
#endif

#endif /* Macro_h */
