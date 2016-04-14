//
//  UIDefines.h
//  WelLv
//
//  Created by 张发杰 on 15/7/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (CustomObject)

//
- (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font cGSize:(CGSize)cGSize;

//
- (NSString *)transformMandarinToLatin:(NSString *)string;

//
- (NSString *)judgeReturnString:(NSString *)returnStr withReplaceString:(NSString *)replaceStr;

//
- (NSString *)judgeImageURL:(NSString *)urlStr;

//判断
- (id)judgeRetuRnImagesClass:(id)sendr;

- (BOOL)judgeString:(NSString *)returnStr;

//++++
- (BOOL)judgeAllClass:(id)sender;

- (BOOL)judgeHTTPHader:(NSString *)str;

- (BOOL)judgeEmail:(NSString *)email;

- (NSString *)choose_City;

- (NSString *)returnTwoNumStr:(NSString *)str;

@end

@interface UILabel (MyLabel)
+ (UILabel *)labelWithFrame:(CGRect)rect backgrondColor:(UIColor *)backgrondColor textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize;

@end
