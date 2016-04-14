//
//  LXUserTool.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLUserStewardModel.h"
#import "WLUserMemberModel.h"

@interface LXUserTool : NSObject

+ (LXUserTool *)sharedUserTool;

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
           andIs_withdraw:(NSString *)is_withdraw;


-(void)setPhoto:(NSString *)UserPhoto;
-(void)setPwd:(NSString *)pwd;
-(void)setPwd2:(NSString *)pwd2;
-(NSString *)getUserName;
-(NSString *)getBalance;
-(NSString *)getPwd;
//修改密码时 用getPwd2;
-(NSString *)getPwd2;
-(NSString *)getIs_withdraw;
-(NSString *)getBirthday;
-(NSString *)getCreatetime;
-(NSString *)getDiqu;
-(NSString *)getEmail;
-(NSString *)getIdnumber;
-(NSString *)getIdtype;
-(NSString *)getLevel;
-(NSString *)getLevels;
-(NSString *)getLogintime;
-(NSString *)getMtype;
-(NSString *)getPhone;
-(NSString *)getRealname;
-(NSString *)getSalt;
-(NSString *)getSex;
-(NSString *)getAddress;
-(NSString *)getUid;
-(NSString *)getKeeper;
-(NSString *)getis_is_detachable;//获取是否有解绑权限
-(void)saveUserLiveAddress:(NSString *)liveAddress cityID:(NSString *)cityID;
-(NSString *)getUserLiveAddress;
-(NSString *)getLiveCityID;
-(NSString *)getuserGroup;
-(NSString *)getAvater;

-(void)saveUserEmail:(NSString *)email;

-(void)deleteUser;
+(NSString *)goBackFilePath:(NSString *)fileName;
+(NSArray *)readCompententsFiles:(NSString *)pathStr;
+(NSString *)getFileSavePath:(NSString *)fileName  fileType:(NSString *)fileType;



/**
 管家所属销售商id
*/
-(void)saveHouseAdmin:(NSString *)admin_id;
-(NSString *)getHouseAdmin_id;


-(void)setMember_count:(NSString *)member_count;
-(NSString *)getMember_count;

- (void)addUserMemberWithDic:(NSDictionary *)dic;

- (void)deleteUserMemberDic;

- (void)addUserStewardWithDic:(NSDictionary *)dic;

- (void)deleteUserStewardDic;

- (WLUserMemberModel *)modelMember;

- (WLUserStewardModel *)modelSteward;
@end
