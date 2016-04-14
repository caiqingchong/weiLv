//
//  YXTools.h
//  WelLv
//
//  Created by lyx on 15/4/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface YXTools : NSObject

+ (AppDelegate *)getApp;
+ (UIWindow *)getAppWindow;
+ (void)autohideKeyBoard:(UIView *)view;
//UIView 动画
+ (void)uiViewAnimationTransition:(UIView *)toView typeIndex:(NSInteger)typeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation;

+ (void)cATransitionAnimation:(UIView *)toView typeIndex:(NSInteger)typeIndex subTypeIndex:(NSInteger)subTypeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation;

+ (UILabel *)allocLabel:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment;
+ (UIButton *)allocButton:(NSString *)title textColor:(UIColor *)textColor nom_bg:(UIImage *)nom_bg hei_bg:(UIImage *)hei_bg frame:(CGRect)frame;
+ (UIImageView *)allocImageView:(CGRect)frame image:(UIImage *)image;
//解析plist文件
+ (NSArray *)getPlistFileArray:(NSString *)fileName;

//验证字符串是否为空
+ (BOOL)stringIsNotNullTrim:(NSString *)s;

//验证返回的字符串是否为空
+ (BOOL)stringReturnNull:(NSString *)s;

//过滤特殊字符
+ (NSString *)filterSpecialString:(NSString *)string;

+ (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font;

+ (void)deleteWebViewBord:(UIWebView *)webView;

//时间戳转换
+ (NSString *)getDate:(NSString *)date;
//json解析
id JsonStringTransToObject(id json ,id className);
extern NSMutableDictionary * ObjectTransToDictionary(id object);
extern NSString * ObjectTransToJsonString(id object);

+(BOOL) isBlankString:(NSString *)string;
+ (BOOL) isValidateMobile:(NSString *)mobile;
//  将数组重复的对象去除，只保留一个
+ (NSMutableArray *)arrayWithMemberIsOnly:(NSArray *)array;


#pragma mark -
#pragma mark - 将xml(数组)转换成NSMutableArray (List<String>)
/**
 * 将xml(数组)转换成NSMutableArray
 * @param xml
 <string>fs</string>
 <string>fs</string>
 ...
 * @return NSMutableArray (List<String>)
 */
+(NSMutableArray*)xmlToArray:(NSString*)xml;

#pragma mark -
#pragma mark - 将标准的xml(实体)转换成NSMutableArray (List<class>)
/**
 * 把标准的xml(实体)转换成NSMutableArray
 * @param xml:
 <data xmlns="">
 <row><UserID>ff0f0704</UserID><UserName>fs</UserName></row>
 <row><UserID>ff0f0704</UserID><UserName>fs</UserName></row>
 ......
 </data>
 * @param class:
 User
 * @param rowRootName:
 row
 * @return NSMutableArray (List<class>)
 */
+(NSMutableArray*)xmlToArray:(NSString*)xml class:(Class)cclass rowRootName:rowRootName;

#pragma mark -
#pragma mark - 将标准的Json(实体)转换成NSMutableArray (List<class>)
/**
 * 把标准的xml(实体)转换成NSMutableArray
 * @param xml:
 [{"UserID":"ff0f0704","UserName":"fs"},
 {"UserID":"ff0f0704","UserName":"fs"},...]
 * @param class:
 User
 * @return NSMutableArray (List<class>)
 */
+(NSMutableArray*)jsonToArray:(NSString*)json class:(Class)cclass;

#pragma mark - 颜色十六进制转换成UIColor
+(UIColor *) stringToColor:(NSString *)str;

@end
