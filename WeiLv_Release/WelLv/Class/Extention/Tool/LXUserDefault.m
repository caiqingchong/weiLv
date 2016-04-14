//
//  LXUserDefault.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXUserDefault.h"
#import "LXUserTool.h"

@implementation LXUserDefault




+(void)setObject:(id)infoValue InfoKey:(NSString *)infoKey{
    NSString *filePath = [LXUserTool  goBackFilePath:infoKey];
    NSDictionary *tempdic = [[NSDictionary alloc] initWithObjectsAndKeys:infoValue,infoKey, nil];
    [tempdic writeToFile:filePath atomically:NO];
}
+ (id)getObject:(NSString *)infoKey{
    NSString *pfilePath = [LXUserTool goBackFilePath:infoKey];
    NSDictionary *ppwdic = [NSDictionary dictionaryWithContentsOfFile:pfilePath];
    if (ppwdic) {
        return [ppwdic objectForKey:infoKey];
    }
    return  nil;
}
+ (void)setObject:(NSString *)infoValue InfoKey:(NSString *)infoKey FileName:(NSString *)fileName{
    NSString *filePath = [LXUserTool  goBackFilePath:fileName];
    NSDictionary *tempdic = [[NSDictionary alloc] initWithObjectsAndKeys:infoValue,infoKey, nil];
    [tempdic writeToFile:filePath atomically:NO];
}
+ (id)getObject:(NSString *)infoKey FileName:(NSString *)fileName{
    NSString *pfilePath = [LXUserTool goBackFilePath:fileName];
    NSDictionary *ppwdic = [NSDictionary dictionaryWithContentsOfFile:pfilePath];
    if (ppwdic) {
        return [ppwdic objectForKey:infoKey];
    }
    return  nil;
}

+(NSString *)getTempFilePath:(NSString *)filetName{
    NSString *tfilePath=[NSString stringWithFormat:@"%@/tmp/%@.temp",NSHomeDirectory(),filetName];
    return tfilePath;
}

+(NSString *)getDownFilePath:(NSString *)filetName{
    NSString *dfilePath=[NSString stringWithFormat:@"%@/Documents/%@.ipa",NSHomeDirectory(),filetName];
    return dfilePath;
}
+(NSString *)currentFileName:(NSString *)na
{
    NSString *nameStr = [[na componentsSeparatedByString:@"/"] lastObject];
    if (nameStr!=nil) {
        return [nameStr substringToIndex:nameStr.length -4];
    }
    return nil;
}
+(BOOL)batDownHadFile:(NSString *)str
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:str]) {
        return  [fileManager copyItemAtPath:str toPath:[NSString stringWithFormat:@"%@.bat",str] error:nil];
    }
    return NO;
}
+(BOOL)reBatDownHadFile:(NSString *)str
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@.bat",str]]) {
        return  [fileManager copyItemAtPath:[NSString stringWithFormat:@"%@.bat",str] toPath:str error:nil];
    }
    return NO;
}
+(void)deleteBatFile:(NSString *)str
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@.bat",str]]) {
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@.bat",str] error:nil];
    }
}
+(void)deleteCurrentFile:(NSString *)str
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:str]) {
        [fileManager removeItemAtPath:str error:nil];
    }
}
@end
