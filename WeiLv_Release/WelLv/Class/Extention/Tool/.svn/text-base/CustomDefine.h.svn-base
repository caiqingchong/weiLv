//
//  CustomDefine.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#ifndef WelLv_CustomDefine_h
#define WelLv_CustomDefine_h
//屏幕相关
#define myWindow ([UIApplication sharedApplication].keyWindow)
#define windowContent  ([[UIScreen mainScreen] bounds])
#define windowContentHeight  ([[UIScreen mainScreen] bounds].size.height)
#define windowContentWidth  ([[UIScreen mainScreen] bounds].size.width)
#define NavHeight (self.navigationController.navigationBar.frame.size.height+20)
#define BARVIEW_WIDTH 80
//动画持续时间，该时间与压栈和出栈时间相当
#define SLIDE_ANIMATION_DURATION 0.35
#define urlKey @"www."
//颜色
#define kColor(r,g,b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.0]

//取版本号
#define XcodeAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//use dlog to print while in debug model
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//由角度获取弧度 由弧度获取角度
#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//坐标相关
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewWidth                       self.view.bounds.size.width
#define SelfViewHeight                      self.view.bounds.size.height

#define ViewBelow(v)                        (v.frame.size.height + v.frame.origin.y)
#define ViewRight(v)                        (v.frame.size.width + v.frame.origin.x)

#define ControllerViewHeight              ([[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.navigationController.navigationBar.frame.size.height)

//设置字体
#define systemFont(x) [UIFont fontWithName:@"STHeitiSC-Light" size:x]
#define systemBoldFont(x) [UIFont fontWithName:@"HelveticaNeue-Bold" size:x]

#define bordColor  [UIColor colorWithRed:219/255.0 green:217/255.0 blue:216/255.0 alpha:1]    //灰色边框
#define Begin_X 10             //距离左边距离
#define ImageLink @"imageArray"      //首页图片链接数组


//UITabelVuew
#define TableLineColor [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]

//显示时间轴的绿色
#define TimeGreenColor [UIColor colorWithRed:0/255.0 green:207/255.0 blue:131/255.0 alpha:1]
//红色
#define M_MIAN_RED_CORLOR UIColorFromRGB(0xff5b26)
//灰色
#define M_MIAN_GRAY_CORLOR UIColorFromRGB(0x6f7378)
//背景色
#define M_MIAN_BG_COLOR kColor(240, 246, 251)

//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

//背景颜色
//#define BgViewColor [UIColor colorWithRed:243/255.0 green:248/255.0 blue:252/255.0 alpha:1]
#define BgViewColor [UIColor colorWithRed:222/255.0 green:229/255.0 blue:235/255.0 alpha:1]

//高度比例(以iPhone6为准)
#define  HeightScale windowContentWidth/375



#define iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)




#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)




//微信
/*
#define WeiXinID  @"wx10d30a1bab2ab340"                      //微信开放平台申请得到的 appid, 需要同时添加在 URL schema
#define WeiXinAPPSecret @"b5e3112f5ae05b3c3a8af70bdc36116a"        //微信开放平台和商户约定的密钥
#define WXPartnerKey @"wx10d30a1bab2ab34012382297022015"           //微信开放平台和商户约定的支付密钥
#define WXPartnerId @"1238229702"                                  //微信公众平台商户模块生成的ID
#define PrePayIdKey @"prepayid"
*/

#define WeiXinID  @"wxfeec97b008327f80"                      //微信开放平台申请得到的 appid, 需要同时添加在 URL schema
#define WeiXinAPPSecret @"7a4818311a585eb073d3c8a5da517413"        //微信开放平台和商户约定的密钥
#define WXPartnerKey @"wx8qa2SyQoWDwXvQv2OpHLHFcSYfKeGv"           //微信开放平台和商户约定的支付密钥
#define WXPartnerId @"1304364001"                                  //微信公众平台商户模块生成的ID
#define PrePayIdKey @"prepayid"


#define OrderPayNotic @"OrderPayNotification"            //订单通知
#define WeiCode @"code"

//沙盒路径
#define GetHomePath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define M_STEWARD_SHOP_NAME @"管家部落"
#define M_STEWARD_SHOP_LAST_NAME @"部落"


//各屏幕尺寸比例
#define autoSizeScaleX  (([[UIScreen mainScreen] bounds].size.height)>480 ? ([[UIScreen mainScreen] bounds].size.width)/320 : 1.0)

#define autoSizeScaleY  (([[UIScreen mainScreen] bounds].size.height)>480 ? ([[UIScreen mainScreen] bounds].size.height)/568 : 1.0)

#define RectX(x)                            x*autoSizeScaleX
#define RectY(y)                            y*autoSizeScaleY
#define RectWidth(width)                    width*autoSizeScaleX
#define RectHeight(height)                  height*autoSizeScaleY
#define RectFontSize(x)                    (SCREEN_MAX_LENGTH == 736.0 ? [UIFont systemFontOfSize:x*1.5] : [UIFont systemFontOfSize:x])
#endif
