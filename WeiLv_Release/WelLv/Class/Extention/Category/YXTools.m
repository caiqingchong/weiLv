//
//  YXTools.m
//  WelLv
//
//  Created by lyx on 15/4/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXTools.h"
#import <objc/runtime.h>
#import "GDataXMLNode.h"
@implementation YXTools
+ (AppDelegate *)getApp
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return app;
}
+ (UIWindow *)getAppWindow
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return app.window;
}
#pragma mark -
#pragma mark 隐藏键盘
+ (void)autohideKeyBoard:(UIView *)view
{
    for (UIView *inView in [view subviews])
    {
        if ([inView isKindOfClass:[UITextField class]] || [inView isKindOfClass:[UITextView class]])
        {
            [inView resignFirstResponder];
        }
        if (inView.subviews.count > 0) {
            [self autohideKeyBoard:inView];
        }
    }
}


+ (void)uiViewAnimationTransition:(UIView *)toView typeIndex:(NSInteger)typeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation;
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:duration];
    switch (typeIndex)
    {
        case 0:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:toView cache:YES];
            break;
        case 1:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:toView cache:YES];
            break;
        case 2:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:toView cache:YES];
            break;
        case 3:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:toView cache:YES];
            break;
        default:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:toView cache:YES];
            break;
    }
    animation();
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark ------
+ (void)cATransitionAnimation:(UIView *)toView typeIndex:(NSInteger)typeIndex subTypeIndex:(NSInteger)subTypeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation
{
    @try {
        CATransition *transtion = [CATransition animation];
        transtion.duration = duration;
        transtion.timingFunction = UIViewAnimationCurveEaseInOut;
        switch (typeIndex) {
            case 0:
                transtion.type = kCATransitionFade;
                break;
            case 1:
                transtion.type = kCATransitionPush;
                break;
            case 2:
                transtion.type = kCATransitionReveal;
                break;
            case 3:
                transtion.type = kCATransitionMoveIn;
                break;
            case 4:
                transtion.type = @"cube";
                break;
            case 5:
                transtion.type = @"suckEffect";
                break;
            case 6:
                transtion.type = @"oglFlip";
                break;
            case 7:
                transtion.type = @"rippleEffect";
                break;
            case 8:
                transtion.type = @"pageCurl";
                break;
            case 9:
                transtion.type = @"pageUnCurl";
                break;
            case 10:
                transtion.type = @"cameraIrisHollowOpen";
                break;
            case 11:
                transtion.type = @"cameraIrisHollowClose";
                break;
            default:
                transtion.type = kCATransitionFade;
                break;
        }
        switch (subTypeIndex) {
            case 0:
                transtion.subtype = kCATransitionFromLeft;
                break;
            case 1:
                transtion.subtype = kCATransitionFromRight;
                break;
            case 2:
                transtion.subtype = kCATransitionFromBottom;
                break;
            case 3:
                transtion.subtype = kCATransitionFromTop;
                break;
            default:
                transtion.subtype = kCATransitionFromLeft;
                break;
        }
        animation();
        if (toView.layer != nil && (id)toView.layer != [NSNull null])
        {
            [[toView layer] addAnimation:transtion forKey:@"animation"];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

+ (UILabel *)allocLabel:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor frame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    return label;
}


+ (UIButton *)allocButton:(NSString *)title textColor:(UIColor *)textColor nom_bg:(UIImage *)nom_bg hei_bg:(UIImage *)hei_bg frame:(CGRect)frame
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:nom_bg forState:UIControlStateNormal];
    [btn setBackgroundImage:hei_bg forState:UIControlStateHighlighted];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    return btn;
}
+ (UIImageView *)allocImageView:(CGRect)frame image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor clearColor];
    return imageView;
}

//解析plist文件
+ (NSArray *)getPlistFileArray:(NSString *)fileName
{
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    return [[NSArray alloc] initWithContentsOfFile:filePath];
}

//验证字符串不为空切不是空格
+ (BOOL)stringIsNotNullTrim:(NSString *)s
{
    NSString *ss = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (ss == nil || ss.length == 0 || [ss isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

//验证返回的字符串是否为空
+ (BOOL)stringReturnNull:(NSString *)s
{
//    NSString *ss = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([s isEqual: [NSNull null]] || s == nil || [s isEqualToString: @""] || [s isEqualToString: @"<null>"]||s.length == 0 )
    {
        return YES;
    }
    return NO;
}

//过滤特殊字符
+ (NSString *)filterSpecialString:(NSString *)string
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@/：；（）¥「」＂、[]{}#%-*+=_\\|~<>$€^•'@#$%^&*()_+'\""];
    NSString *body=@"";
    for (int i=0; i<string.length; i++) {
        NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
        NSRange userNameRange = [s rangeOfCharacterFromSet:set];
        if (userNameRange.location != NSNotFound)
        {
            s = @"";
        }
        body = [body stringByAppendingString:s];
    }
    return body;
}

//计算字符高度和宽度
+ (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(windowContentWidth - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return rect;
}

//删除webView 的黑色边框
+ (void)deleteWebViewBord:(UIWebView *)webView
{
    for(id subview in webView.subviews)
    {
        if ([[subview  class] isSubclassOfClass: [UIScrollView  class]])
            
        {
            ((UIScrollView *)subview).bounces = NO;
        }
        
        webView.scrollView.bounces=NO;
    }
    
}

//时间戳转换
+ (NSString *)getDate:(NSString *)date
{
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",detaildate);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;

}
id JsonStringTransToObject(id json ,id className)
{
    if ([json isKindOfClass:[NSDictionary class]])
    {
        id object = nil;
        if ([className isKindOfClass:[NSString class]])
        {
            Class isClass = NSClassFromString(className);
            
            object = [[isClass alloc] init];
        }
        else
            object = className;
        
        for (NSString *key in [json allKeys])
        {
            id value = [json objectForKey:key];
            if (value == nil || value == [NSNull null])
            {
                continue;
            }
            
            if (![value isKindOfClass:[NSString class]])
            {
                if ([value isKindOfClass:[NSDictionary class]])
                {
                    SEL sel = NSSelectorFromString(key);  //获取对象引用方法
                    if ([object respondsToSelector:sel])
                    {
                        id i = [object performSelector:sel];   //获取对象
                        if ([i isKindOfClass:[NSDictionary class]])
                        {
                            NSString *setSel = [NSString stringWithFormat:@"set%@:",[NSString stringWithFormat:@"%@%@",[[key substringToIndex:1] uppercaseString],[key substringFromIndex:1]]];
                            SEL sel = NSSelectorFromString(setSel);
                            if ([object respondsToSelector:sel])
                            {
                                [object performSelector:sel withObject:value];
                            }
                            
                            continue;
                        }
                        JsonStringTransToObject(value, i);
                    }
                    continue;
                }
                else if ([value isKindOfClass:[NSArray class]])
                {
                    NSString *setSel = [NSString stringWithFormat:@"set%@:",[NSString stringWithFormat:@"%@%@",[[key substringToIndex:1] uppercaseString],[key substringFromIndex:1]]];
                    SEL sel = NSSelectorFromString(setSel);
                    if ([object respondsToSelector:sel])
                    {
            
                        [object performSelector:sel withObject:value];
                    }
                    continue;
                }
            }
            if ([value respondsToSelector:@selector(isEqualToString:)])
            {
                if ([value isEqualToString:@"null"])
                    continue;
            }
            
            NSString *setSel = [NSString stringWithFormat:@"set%@:",[NSString stringWithFormat:@"%@%@",[[key substringToIndex:1] uppercaseString],[key substringFromIndex:1]]];
            SEL sel = NSSelectorFromString(setSel);
            if ([object respondsToSelector:sel])
            {
                [object performSelector:sel withObject:value];
            }
            
        }
        
        return object;
    }
    else if ([json isKindOfClass:[NSArray class]])
    {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in json)
        {
            id object = JsonStringTransToObject(dic, className);
            [array addObject:object];
        }
        
        return array;
        
    }
    return nil;
}

//对象转换为 json字符串  暂只支持 string 类型属性
//  property_getAttributes 属性类型 T@"NSString",C,N,V_entryTime  以T开头@代表引用类型(c bool类型  i 整形) C(copy)/&(retain) N(nonatomic 非线程安全) V属性名
NSString * ObjectTransToJsonString(id object)
{
    NSString *className = NSStringFromClass([object class]);
    const char *xcClassName = [className UTF8String];
    id isClass = objc_getClass(xcClassName);
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(isClass, &outCount);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        
        NSString *propertyNameString = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];  //获取属性名
        
        NSString *propertyAttributsString = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];  //获取属性类型值
        
        NSString *type = [propertyAttributsString substringWithRange:NSMakeRange(1, 1)];
        if (![type isEqualToString:@"@"])   //不是对象类型跳出
            continue;
        
        SEL selector = NSSelectorFromString(propertyNameString);  //反射get方法
        id value = [object performSelector:selector];  //调用属性get方法
        
        //NSLog(@"%s ----  %s",property_getName(property), property_getAttributes(property));
        if (value == nil || value == [NSNull null])
            continue;
        
        
        if ([value isKindOfClass:[NSString class]])
        {
            [dic setObject:value forKey:propertyNameString];
            continue;
        }
        if ([value isKindOfClass:[NSArray class]])
        {
            NSMutableArray *array = nil;
            for (id o in value)
            {
                if ([o isKindOfClass:[NSString class]])
                {
                    [dic setObject:value forKey:propertyNameString];
                    break;
                }
                else
                {
                    if (array == nil)
                        array = [NSMutableArray array];
                    [array addObject:ObjectTransToDictionary(o)];
                }
            }
            if (array != nil)
            {
                [dic setObject:array forKey:propertyNameString];
            }
            continue;
        }
        [dic setObject:ObjectTransToDictionary(value) forKey:propertyNameString];
        continue;
    }
    
    return [dic JSONString];
}

NSMutableDictionary * ObjectTransToDictionary(id object)
{
    NSString *className = NSStringFromClass([object class]);
    const char *xcClassName = [className UTF8String];
    id isClass = objc_getClass(xcClassName);
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(isClass, &outCount);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        
        NSString *propertyNameString = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];  //获取属性名
        
        NSString *propertyAttributsString = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];  //获取属性类型值
        
        NSString *type = [propertyAttributsString substringWithRange:NSMakeRange(1, 1)];
        if (![type isEqualToString:@"@"])   //不是对象类型跳出
            continue;
        
        SEL selector = NSSelectorFromString(propertyNameString);  //反射get方法
        id value = [object performSelector:selector];  //调用属性get方法
        
        if (value == nil || value == [NSNull null])
            continue;
        
        if ([propertyAttributsString rangeOfString:@"&"].location != NSNotFound)
        {
            [dic setObject:ObjectTransToDictionary(value) forKey:propertyNameString];
            continue;
        }
        
        [dic setObject:value forKey:propertyNameString];
        
    }
    return dic;
}

+(BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    return NO;
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    //^1(3[0-9]|4[57]|5[012356789]|8[0-9]|7[0-7])\\d{8}$
    //手机号以13， 15，18开头，八个 \d 数字字符
    //NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[012356789]|8[0-9]|7[0-7])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
    
}

//  将数组重复的对象去除，只保留一个
+ (NSMutableArray *)arrayWithMemberIsOnly:(NSArray *)array
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [array count]; i++)
    {
        @autoreleasepool
        {
            if ([categoryArray containsObject:[array objectAtIndex:i]] == NO)
            {
                [categoryArray addObject:[array objectAtIndex:i]];
            }
        }
    }
    return categoryArray;
}



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
+(NSMutableArray*)xmlToArray:(NSString*)xml{
    
    NSMutableArray *retVal = [[NSMutableArray alloc] init];
    xml = [NSString stringWithFormat:@"<data>%@</data>",xml];
    GDataXMLDocument *root = [[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:nil];
    GDataXMLElement *rootEle = [root rootElement];
    for (int i=0; i <[rootEle childCount]; i++) {
        GDataXMLNode *item = [rootEle childAtIndex:i];
        [retVal addObject:item.stringValue];
    }
    return retVal;
}

#pragma mark -
#pragma mark - 将标准的xml(实体)转换成NSMutableArray (List<class>)
/**
 * 将标准的xml(实体)转换成NSMutableArray
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
+(NSMutableArray*)xmlToArray:(NSString*)xml class:(Class)class rowRootName:rowRootName{
    
    NSMutableArray *retVal = [[NSMutableArray alloc] init];
    GDataXMLDocument *root = [[GDataXMLDocument alloc] initWithXMLString:xml options:0 error:nil];
    GDataXMLElement *rootEle = [root rootElement];
    NSArray *rows = [rootEle elementsForName:rowRootName];
    for (GDataXMLElement *row in rows) {
        id object = [[class alloc] init];
        object = [self initWithXMLString:row.XMLString object:object];
        [retVal addObject:object];
    }
    return retVal;
}

/**
 * 将传递过来的实体赋值
 * @param xml(忽略实体属性大小写差异):
 <row><UserID>ff0f0704</UserID><UserName>fs</UserName></row>
 * @param class:
 User @property userName,userID;
 * @return class
 */
+(id)initWithXMLString:(NSString*)xml object:(id)object{
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        NSString *value = [self setXMLProperty:xml propertyName:propertyName];
        [object setValue:value forKey:propertyName];
    }
    free(properties);
    
    return object;
}

/**
 * 通过正则将传递过来的实体赋值
 * @param content(忽略实体属性大小写差异):
 <row><UserID>ff0f0704</UserID><UserName>fs</UserName></row>
 * @param propertyName:
 userID
 * @return NSString
 ff0f0704
 */
+(NSString*)setXMLProperty:(NSString*)value propertyName:(NSString*)propertyName {
    
    NSString *retVal = @"";
    NSString *patternString = [NSString stringWithFormat:@"(?<=<%@>)(.*)(?=</%@>)",propertyName,propertyName];
    // CaseInsensitive:不区分大小写比较
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patternString options:NSRegularExpressionCaseInsensitive error:nil];
    if (regex) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:value options:NSCaseInsensitiveSearch range:NSMakeRange(0, [value length])];
        if (firstMatch) {
            retVal = [value substringWithRange:firstMatch.range];
        }
    }
    return retVal;
}

#pragma mark -
#pragma mark - 将标准的Json(实体)转换成NSMutableArray (List<class>)
/**
 * 将标准的Json(实体)转换成NSMutableArray
 * @param xml:
 [{"UserID":"ff0f0704","UserName":"fs"},
 {"UserID":"ff0f0704","UserName":"fs"},...]
 * @param class:
 User
 * @return NSMutableArray (List<class>)
 */
+(NSMutableArray*)jsonToArray:(NSString*)json class:(Class)class {
    
    NSMutableArray *retVal = [[NSMutableArray alloc] init];
    NSString *patternString = @"\\{.*?\\}";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patternString options:0 error:nil];
    if (regex) {
        NSArray *match = [regex matchesInString:json options:0 range:NSMakeRange(0, [json length])];
        if (match) {
            for (NSTextCheckingResult *result in match) {
                NSString *jsonRow = [json substringWithRange:result.range];
                id object = [[class alloc] init];
                object = [self initWithJsonString:jsonRow object:object];
                [retVal addObject:object];
            }
        }
    }
    return retVal;
}

/**
 * 将传递过来的实体赋值
 * @param xml(忽略实体大小写差异):
 {"UserID":"ff0f0704","UserName":"fs"}
 * @param class:
 User @property userName,userID;
 * @return class
 */
+(id)initWithJsonString:(NSString*)json object:(id)object{
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        NSString *value = [self setJsonProperty:json propertyName:propertyName];
        [object setValue:value forKey:propertyName];
    }
    free(properties);
    
    return object;
}

/**
 * 通过正则将传递过来的实体赋值
 * @param content(忽略实体大小写差异):
 {"UserID":"ff0f0704","UserName":"fs"}
 * @param propertyName:
 userID
 * @return NSString
 ff0f0704
 */
+(NSString*)setJsonProperty:(NSString*)value propertyName:(NSString*)propertyName {
    
    NSString *retVal = @"";
    NSString *patternString = [NSString stringWithFormat:@"(?<=\"%@\":\")[^\",]*",propertyName];
    // CaseInsensitive:不区分大小写比较
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:patternString options:NSRegularExpressionCaseInsensitive error:nil];
    if (regex) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:value options:NSCaseInsensitiveSearch range:NSMakeRange(0, [value length])];
        if (firstMatch) {
            retVal = [value substringWithRange:firstMatch.range];
        }
    }
    return retVal;
}

#pragma mark - 颜色十六进制转换成UIColor
+(UIColor *) stringToColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

@end
