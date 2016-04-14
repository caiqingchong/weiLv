//
//  LXUserTool.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXUserTool.h"
#import "AESCrypt.h"
static LXUserTool *sharedSVC;

@implementation LXUserTool


+ (LXUserTool *)sharedUserTool
{
    
    if (sharedSVC == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedSVC = [[self alloc] init];
        });

    }
     return sharedSVC;
}

-(void)saveUserNameAndPwd:(NSString *)username
                   andPwd:(NSString *)password
               andBalance:(NSString *)balance//余额
              andBirthday:(NSString *)birthday//生日
            andCreatetime:(NSString *)createtime//创建日期
                  andDiqu:(NSString *)diqu
                 andEmail:(NSString *)email
              andIdnumber:(NSString *)idnumber
                andIdtype:(NSString *)idtype
                 andLevel:(NSString *)level
                andLevels:(NSString *)levels
             andLogintime:(NSString *)logintime
                 andMtype:(NSString *)mtype
                 andPhone:(NSString *)phone
              andRealname:(NSString *)realname//真实姓名
                  andSalt:(NSString *)salt
                   adnSex:(NSString *)sex
        andShengshiquxian:(NSString *)address
                   andUid:(NSString *)uid
          adnAssistant_id:(NSString *)assistant_id//绑定管家的id，0未绑定
         andIs_detachable:(NSString *)is_detachable//是否有解绑权限,0没有解绑权限
             andUsergroup:(NSString *)usergroup
                andAvater:(NSString *)avater
          andMember_count:(NSString *)member_count
                  andPwd2:(NSString *)password2
           andIs_withdraw:(NSString *)is_withdraw

{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"username"];
    [settings removeObjectForKey:@"password"];
    [settings removeObjectForKey:@"balance"];
    [settings removeObjectForKey:@"birthday"];
    [settings removeObjectForKey:@"createtime"];
    [settings removeObjectForKey:@"diqu"];
    [settings removeObjectForKey:@"email"];
    [settings removeObjectForKey:@"idnumber"];
    [settings removeObjectForKey:@"idtype"];
    [settings removeObjectForKey:@"level"];
    [settings removeObjectForKey:@"levels"];
    [settings removeObjectForKey:@"logintime"];
    [settings removeObjectForKey:@"mtype"];
    [settings removeObjectForKey:@"phone"];
    [settings removeObjectForKey:@"realname"];
    [settings removeObjectForKey:@"salt"];
    [settings removeObjectForKey:@"sex"];
    [settings removeObjectForKey:@"address"];
    [settings removeObjectForKey:@"uid"];
    [settings removeObjectForKey:@"assistant_id"];
    [settings removeObjectForKey:@"is_detachable"];
    [settings removeObjectForKey:@"usergroup"];
    [settings removeObjectForKey:@"avater"];
    [settings removeObjectForKey:@"member_count"];
    [settings removeObjectForKey:@"password2"];
    [settings removeObjectForKey:@"is_withdraw"];
    if (![username isEqual:[NSNull null]]) {
         [settings setObject:username forKey:@"username"];
     }
    
    [settings setObject:password forKey:@"password"];
    [settings setObject:phone forKey:@"phone"];
    [settings setObject:usergroup forKey:@"usergroup"];
    
    if (![balance isEqual:[NSNull null]]) {
        [settings setObject:balance forKey:@"balance"];
    }
    if (![birthday isEqual:[NSNull null]] && birthday !=NULL) {
        [settings setObject:birthday forKey:@"birthday"];
    }
    if (![createtime isEqual:[NSNull null]] && createtime !=NULL) {
        [settings setObject:createtime forKey:@"createtime"];
    }
    if (![diqu isEqual:[NSNull null]] && diqu !=NULL) {
        [settings setObject:diqu forKey:@"diqu"];
    }
    if (![email isEqual:[NSNull null]] && email !=NULL) {
        [settings setObject:email forKey:@"email"];
    }
    if (![idnumber isEqual:[NSNull null]] && idnumber !=NULL) {
        [settings setObject:idnumber forKey:@"idnumber"];
    }
    if (![idtype isEqual:[NSNull null]] && idtype !=NULL) {
        [settings setObject:idtype forKey:@"idtype"];
    }
    if (![level isEqual:[NSNull null]] && level !=NULL) {
        [settings setObject:level forKey:@"level"];
    }
    if (![levels isEqual:[NSNull null]] && levels !=NULL) {
        [settings setObject:levels forKey:@"levels"];
    }
    if (![logintime isEqual:[NSNull null]] && logintime !=NULL) {
        [settings setObject:logintime forKey:@"logintime"];
    }
    if (![mtype isEqual:[NSNull null]] && mtype !=NULL) {
        [settings setObject:mtype forKey:@"mtype"];
    }
    if (![realname isEqual:[NSNull null]] && realname !=NULL) {
        [settings setObject:realname forKey:@"realname"];
    }
    if (![salt isEqual:[NSNull null]] && salt !=NULL) {
        [settings setObject:salt forKey:@"salt"];
    }
    if (![sex isEqual:[NSNull null]] && sex !=NULL) {
        [settings setObject:sex forKey:@"sex"];
    }
    if (![address isEqual:[NSNull null]] && address !=NULL) {
        [settings setObject:address forKey:@"address"];
    }
    if (![uid isEqual:[NSNull null]] && uid !=NULL) {
        [settings setObject:uid forKey:@"uid"];
    }
    if (![assistant_id isEqual:[NSNull null]] && assistant_id !=NULL) {
        [settings setObject:assistant_id forKey:@"assistant_id"];
    }
    if (![is_detachable isEqual:[NSNull null]] && is_detachable !=NULL) {
        [settings setObject:is_detachable forKey:@"is_detachable"];
    }
    if (![avater isEqual:[NSNull null]] && avater !=NULL) {
        [settings setObject:avater forKey:@"avater"];
    }
    if (![member_count isEqual:[NSNull null]] && member_count !=NULL) {
        [settings setObject:member_count forKey:@"member_count"];
    }
    if (![password2 isEqual:[NSNull null]] && password2 !=NULL) {
        [settings setObject:password2 forKey:@"password2"];
    }
    if (![is_withdraw isEqual:[NSNull null]] && is_withdraw !=NULL) {
        [settings setObject:is_withdraw forKey:@"is_withdraw"];
    }

    [settings synchronize];
}



-(void)setPhoto:(NSString *)UserPhoto{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"phone"];
    [settings setObject:UserPhoto forKey:@"phone"];
    [settings synchronize];
}

//保存密码专用方法
-(void)setPwd:(NSString *)pwd
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"password"];
    [settings setObject:pwd forKey:@"password"];
    [settings synchronize];
}
-(void)setPwd2:(NSString *)pwd2
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"password2"];
    [settings setObject:pwd2 forKey:@"password2"];
    [settings synchronize];
}
-(void)setIs_withdraw:(NSString *)is_withdraw
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"is_withdraw"];
    [settings setObject:is_withdraw forKey:@"is_withdraw"];
    [settings synchronize];
}
-(NSString *)getuserGroup
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"usergroup"];
}

- (NSString *)getAvater
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"avater"];
}
-(NSString *)getUserName
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"username"];
}
-(NSString *)getPwd
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString * temp = [settings objectForKey:@"password"];
    return temp;
}
-(NSString *)getPwd2
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString * temp = [settings objectForKey:@"password2"];
    return temp;
}
-(NSString *)getIs_withdraw
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    NSString * temp = [settings objectForKey:@"is_withdraw"];
    return temp;
}
-(NSString *)getBalance
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"balance"];
}

-(NSString *)getBirthday
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"birthday"];
}
-(NSString *)getCreatetime
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"createtime"];
}
-(NSString *)getDiqu
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"diqu"];
}
-(NSString *)getEmail
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"email"];
}
-(NSString *)getIdnumber
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"idnumber"];
}
-(NSString *)getIdtype
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"idtype"];
}
-(NSString *)getLevel
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"level"];
}
-(NSString *)getLevels
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"levels"];
}
-(NSString *)getLogintime
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"logintime"];
}
-(NSString *)getMtype
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"mtype"];
}
-(NSString *)getPhone
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"phone"];
}
-(NSString *)getRealname
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"realname"];
}
-(NSString *)getSalt
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"salt"];
}
-(NSString *)getSex
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"sex"];
}
-(NSString *)getAddress
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"address"];
}
-(NSString *)getUid
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"uid"];
}

-(NSString *)getKeeper
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"assistant_id"];
    
}

-(NSString *)getis_is_detachable
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"is_detachable"];
}

-(void)saveUserEmail:(NSString *)email
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    
    [settings removeObjectForKey:@"email"];
    
    
    [settings setObject:email forKey:@"email"];
    
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{

    if (sharedSVC == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedSVC = [super allocWithZone:zone];
        });
    }
    return sharedSVC;
}

#pragma mark --存长期居住地
-(void)saveUserLiveAddress:(NSString *)liveAddress cityID:(NSString *)cityID
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    
    [settings removeObjectForKey:@"liveAddress"];
    [settings removeObjectForKey:@"liveCityID"];
    
    [settings setObject:liveAddress forKey:@"liveAddress"];
    [settings setObject:cityID forKey:@"liveCityID"];
}

-(NSString *)getUserLiveAddress
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"liveAddress"];
}

-(NSString *)getLiveCityID
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"liveCityID"];
}
-(void)deleteUser
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"username"];
    [settings removeObjectForKey:@"password"];
    [settings removeObjectForKey:@"balance"];
    [settings removeObjectForKey:@"birthday"];
    [settings removeObjectForKey:@"createtime"];
    [settings removeObjectForKey:@"diqu"];
    [settings removeObjectForKey:@"email"];
    [settings removeObjectForKey:@"idnumber"];
    [settings removeObjectForKey:@"idtype"];
    [settings removeObjectForKey:@"level"];
    [settings removeObjectForKey:@"levels"];
    [settings removeObjectForKey:@"logintime"];
    [settings removeObjectForKey:@"mtype"];
    [settings removeObjectForKey:@"phone"];
    [settings removeObjectForKey:@"realname"];
    [settings removeObjectForKey:@"salt"];
    [settings removeObjectForKey:@"sex"];
    [settings removeObjectForKey:@"address"];
    [settings removeObjectForKey:@"uid"];
    [settings removeObjectForKey:@"assistant_id"];
    [settings removeObjectForKey:@"is_detachable"];
    [settings removeObjectForKey:@"usergroup"];
    [settings removeObjectForKey:@"avater"];
    [settings removeObjectForKey:@"custom"];
    [settings removeObjectForKey:@"member_count"];
    [settings removeObjectForKey:@"ste_shop_ID"];
    [self deleteUserStewardDic];
    [self deleteUserMemberDic];
}
+(NSString *)goBackFilePath:(NSString *)fileName{
    
    NSString *filePath =[NSString stringWithFormat:@"%@/Documents/%@.plist",NSHomeDirectory(),fileName];
    
    return filePath;
}

+(NSString *)getFileSavePath:(NSString *)fileName  fileType:(NSString *)fileType{
    
    NSString *filePath =[NSString stringWithFormat:@"%@/Documents/%@.%@",NSHomeDirectory(),fileName,fileType];
    
    return filePath;
}

+(NSArray *)readCompententsFiles:(NSString *)pathStr{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager contentsOfDirectoryAtPath: pathStr error:nil];;
}


#pragma mark --- 存管家所属销售商id
-(void)saveHouseAdmin:(NSString *)admin_id
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"admin_id"];
    [settings setObject:admin_id forKey:@"admin_id"];
    
}

-(NSString *)getHouseAdmin_id
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"admin_id"];
}

-(void)setMember_count:(NSString *)member_count
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    [settings removeObjectForKey:@"member_count"];
    [settings setObject:member_count forKey:@"member_count"];
    [settings synchronize];
    
}

-(NSString *)getMember_count
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [NSString stringWithFormat:@"%@",[settings objectForKey:@"member_count"]];
}

- (WLUserMemberModel *)modelMember {
    return [[WLUserMemberModel alloc] initWithDictionary:[[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:[[NSUserDefaults standardUserDefaults] objectForKey:@"memberDic"]]];
}

- (WLUserStewardModel *)modelSteward {
    return [[WLUserStewardModel alloc] initWithDictionary:[[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:[[NSUserDefaults standardUserDefaults] objectForKey:@"stewardDic"]]];
}

- (void)addUserMemberWithDic:(NSDictionary *)dic {
    [[NSUserDefaults standardUserDefaults] setObject:[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic] forKey:@"memberDic"];

}

- (void)deleteUserMemberDic{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"memberDic"];
}

- (void)addUserStewardWithDic:(NSDictionary *)dic {
    [[NSUserDefaults standardUserDefaults] setObject:[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic] forKey:@"stewardDic"];
}

- (void)deleteUserStewardDic {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"stewardDic"];
}

- (void)changeMemberKay:(NSString *)keyStr value:(NSString *)valueStr{
    NSMutableDictionary * dic = [[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:[[NSUserDefaults standardUserDefaults] objectForKey:@"memberDic"]];
    [dic setObject:valueStr forKey:keyStr];
    [self addUserMemberWithDic:dic];
}

- (void)changeStewardKay:(NSString *)keyStr value:(NSString *)valueStr {
    NSMutableDictionary * dic = [[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:[[NSUserDefaults standardUserDefaults] objectForKey:@"stewardDic"]];
    [dic setObject:valueStr forKey:keyStr];
    [self addUserMemberWithDic:dic];
}

@end
