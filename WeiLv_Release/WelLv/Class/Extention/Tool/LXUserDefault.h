//
//  LXUserDefault.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXUserDefault : NSObject
+ (void)setObject:(id )infoValue InfoKey:(NSString *)infoKey;
+ (void)setObject:(id)infoValue InfoKey:(NSString *)infoKey FileName:(NSString *)fileName;
+ (id)getObject:(NSString *)infoKey;
+ (id)getObject:(NSString *)infoKey FileName:(NSString *)fileName;
+(NSString *)getTempFilePath:(NSString *)filetName;
+(NSString *)getDownFilePath:(NSString *)filetName;
+(NSString *)currentFileName:(NSString *)na;
+(BOOL)batDownHadFile:(NSString *)str;
+(BOOL)reBatDownHadFile:(NSString *)str;
+(void)deleteBatFile:(NSString *)str;
+(void)deleteCurrentFile:(NSString *)str;
//+(long long) freeSpace;
//+(float)getTotalDiskSpaceInBytes;
@end
