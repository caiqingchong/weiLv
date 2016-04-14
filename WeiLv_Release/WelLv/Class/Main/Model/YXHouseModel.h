//
//  YXHouseModel.h
//  WelLv
//
//  Created by lyx on 15/4/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHouseModel : NSObject
   
@property (nonatomic,copy)NSString *id;
@property (nonatomic,copy)NSString *name;                            //姓名
@property (nonatomic,copy)NSString *avatar;                         //头像
@property (nonatomic,copy)NSString *mobile;                        //手机号
@property (nonatomic,copy)NSString *birth_date;                   //出生日期
@property (nonatomic,copy)NSString *horoscope;                   //星座
@property (nonatomic,copy)NSString *level;                      //评分
@property (nonatomic,copy)NSString *order_count;               //方案数
@property (nonatomic,copy)NSString *advantage;                //精通业务
@property (nonatomic,copy)NSString *motto;                   //格言
@property (nonatomic,copy)NSString * goods_count;           //部落产品数量
@property  (nonatomic,copy)NSString *partner_count ;        // 合伙人 数量


@property (nonatomic,copy)NSString *region_id;                      //
@property (nonatomic,copy)NSString *region;                         //
@property (nonatomic,copy)NSString *address;                      //地址
@property (nonatomic,copy)NSString *create_time;                 //创建时间
@property (nonatomic,copy)NSString *email;                      //邮箱
@property (nonatomic,copy)NSString *gender;                    //性别
@property (nonatomic,copy)NSString *amount;                    //分成总金额
@property (nonatomic,copy)NSString *bank_account;              //银行账号
@property (nonatomic,copy)NSString *bank_name;                 //开户行名字
@property (nonatomic,copy)NSString *closed;                    //暂停接待
@property (nonatomic,copy)NSString *company;                    //公司
@property (nonatomic,copy)NSString *education_background;       //教育背景
@property (nonatomic,copy)NSString *froze;                    //冻结
@property (nonatomic,copy)NSString *group_id;                    //分组id
@property (nonatomic,copy)NSString *native_place;                    //籍贯
@property (nonatomic,copy)NSString *nickname;                    //昵称
@property (nonatomic,copy)NSString *occupation;                    //职业
@property (nonatomic,copy)NSString *position;                    //职位
@property (nonatomic,copy)NSString *qq;                    //qq
@property (nonatomic,copy)NSString *residence;                    //居住地id
@property (nonatomic,copy)NSString *school;                    //学校
@property (nonatomic,copy)NSString *signature;                    //个性签名
@property (nonatomic,copy)NSString *telephone;                    //固定电话
@property (nonatomic,copy)NSString *trash;                    //回收站
@property (nonatomic,copy)NSString *wechat;                    //微信号

@property (nonatomic,strong)NSMutableArray *sellers;
@end


@interface YXMemberHouseData : NSObject

@property (nonatomic,copy)NSString *AT;
@property (nonatomic,copy)NSString *CT;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *admin_id;
@property (nonatomic,copy)NSString *bank_dir;
@property (nonatomic,copy)NSString *bank_name;
@property (nonatomic,copy)NSString *bank_num;
@property (nonatomic,copy)NSString *bank_open_name;
@property (nonatomic,copy)NSString *city_id;
@property (nonatomic,copy)NSString *company_id;
@property (nonatomic,copy)NSString *county_id;
@property (nonatomic,copy)NSString *duty_id;
@property (nonatomic,copy)NSString *email;
@property (nonatomic,copy)NSString *fax;
@property (nonatomic,copy)NSString *mark;
@property (nonatomic,copy)NSString *mobile;
@property (nonatomic,copy)NSString *mobile_short;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *parent_id;
@property (nonatomic,copy)NSString *principal;
@property (nonatomic,copy)NSString *principal_tel;
@property (nonatomic,copy)NSString *province_id;
@property (nonatomic,copy)NSString *qq;
@property (nonatomic,copy)NSString *realname;
@property (nonatomic,copy)NSString *sex;
@property (nonatomic,copy)NSString *status;
@property (nonatomic,copy)NSString *tel;
@property (nonatomic,copy)NSString *username;


@end
