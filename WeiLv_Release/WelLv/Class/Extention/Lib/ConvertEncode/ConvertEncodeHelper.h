//
//  ConvertEncodeHelper.h
//  CreateControl
//
//  Created by James on 15/11/26.
//  Copyright © 2015年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertEncodeHelper : NSObject
#pragma mark - Unicode转UTF-8
+ (NSString*) replaceUnicode:(NSString*)aUnicodeString;
#pragma mark - UTF-8转Unicode
+(NSString *) utf8ToUnicode:(NSString *)string;
@end
