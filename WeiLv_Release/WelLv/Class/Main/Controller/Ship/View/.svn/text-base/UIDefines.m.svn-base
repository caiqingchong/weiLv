//
//  UIDefines.m
//  WelLv
//
//  Created by 张发杰 on 15/7/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "UIDefines.h"
#import "YXLocationManage.h"

@implementation NSObject (CustomObject)

/**
 *  获取NSString的Rect
 *
 *  @param str    需要计算的NSString
 *  @param font   字符串的大小Font
 *  @param cGSize 字符串所在的Size
 *
 *  @return CGRect
 */
- (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font cGSize:(CGSize)cGSize
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:cGSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return rect;
}




/*将汉字转换为不带音调的拼音
 *string是要转换的字符串*/
- (NSString *)transformMandarinToLatin:(NSString *)string
{
    /*复制出一个可变的对象*/
    NSMutableString *preString = [string mutableCopy];
    /*转换成成带音 调的拼音*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformMandarinLatin, NO);
    /*去掉音调*/
    CFStringTransform((CFMutableStringRef)preString, NULL, kCFStringTransformStripDiacritics, NO);
    
    /*多音字处理*/
    if ([[(NSString *)string substringToIndex:1] compare:@"长"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"沈"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"厦"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"地"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
    }
    if ([[(NSString *)string substringToIndex:1] compare:@"重"] == NSOrderedSame)
    {
        [preString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    return preString;
}

/**
 *  判断请求返回的String
 *
 *  @param returnStr  获取的String
 *  @param replaceStr 如果需要改变时替代的Sting
 *
 *  @return NSSing
 */
- (NSString *)judgeReturnString:(NSString *)returnStr withReplaceString:(NSString *)replaceStr {
    
    if (returnStr) {
        returnStr = [NSString stringWithFormat:@"%@", returnStr];
    }
    if (returnStr.length == 0|| [returnStr isEqual:[NSNull null]] || returnStr == nil || [returnStr isEqualToString:@""] || !returnStr || [returnStr isEqualToString: @"<null>"]||[returnStr isEqualToString: @"(null)"]||[returnStr isEqualToString:@"0"]) {
        return replaceStr;
    }
    return returnStr;
}
/**
 *  判断图片请求时是否需要拼接  WLHTTP
 *
 *  @param urlStr 需要判断的URL
 *
 *  @return 返回NSString
 */
- (NSString *)judgeImageURL:(NSString *)urlStr {
    if ([urlStr hasPrefix:@"http"]) {
        return urlStr;
    }
    return [NSString stringWithFormat:@"%@/%@", WLHTTP, urlStr];
}



- (id)judgeRetuRnImagesClass:(id)sendr {
    if ([sendr isKindOfClass:[NSArray class]]) {
        NSArray * arr = sendr;
        return [arr objectAtIndex:0];
    } else {
        return sendr;
    }
}




/**
 *  <#Description#>
 *
 *  @param returnStr <#returnStr description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)judgeString:(NSString *)returnStr {
    
    if (returnStr) {
        returnStr = [NSString stringWithFormat:@"%@", returnStr];
    }
    if ([returnStr isEqual:[NSNull null]] || returnStr.length == 0 || returnStr == nil || [returnStr isEqualToString:@""] || !returnStr || [returnStr isEqualToString: @"<null>"]||[returnStr isEqualToString: @"(null)"]||[returnStr isEqualToString: @"null"]) {
        return NO;
    }
    return YES;
}
/**
 *  <#Description#>
 *
 *  @param sender <#sender description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)judgeAllClass:(id)sender {
    if ([sender isEqual:[NSNull null]] || sender == nil || [sender isEqualToString:@""] || !sender || [sender isEqualToString: @"<null>"]||[sender isEqualToString: @"(null)"]) {
        return NO;
    }
    return YES;

}
- (NSString *)choose_City {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"chooseCityName"]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseCityName"];
    } else {
        if ([self judgeString:[[YXLocationManage shareManager].city stringByReplacingOccurrencesOfString:@"市" withString:@""]]) {
            return [[YXLocationManage shareManager].city stringByReplacingOccurrencesOfString:@"市" withString:@""];

        }
        return @"郑州";
    }
    return @"郑州";
}

/**
 *  判断是否是网址
 *
 *  @param str 判断的str
 *
 *  @return BOOL类型
 */
- (BOOL)judgeHTTPHader:(NSString *)str {
    if ([str hasPrefix:@"https://"] || [str hasPrefix:@"http://"]) {
        return YES;
    }
    return NO;
}



/**
 *  判断邮箱
 *
 *  @param email 需要判断的邮箱
 *
 *  @return 返回BOOL
 */
- (BOOL)judgeEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (NSString *)returnTwoNumStr:(NSString *)str {
    return [NSString stringWithFormat:@"%.2f", [str floatValue]];
}

@end






@implementation UILabel (CustomLabel)

+ (UILabel *)labelWithFrame:(CGRect)rect backgrondColor:(UIColor *)backgrondColor textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize
{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    label.backgroundColor = backgrondColor;
    label.textAlignment = textAlignment;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}


@end
