//
//  ZFJVisaModel.h
//  WelLv
//
//  Created by 张发杰 on 15/4/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFJVisaModel : NSObject
@property (nonatomic, copy) NSString * product_id;       //签证产品id
@property (nonatomic, copy) NSString * product_name;     //签证产品名称
@property (nonatomic, copy) NSString * product_sn;       // 签证产品编号
@property (nonatomic, copy) NSString * city_id;          //出发城市id
@property (nonatomic, copy) NSString * sell_price;       //销售价格
@property (nonatomic, copy) NSString * category_id;      //分类id
@property (nonatomic, copy) NSString * thumb;            //缩略图片
@property (nonatomic, copy) NSString * status ;          //上下架状态(1.上架，0.下架)
@property (nonatomic, copy) NSString * visa_id ;         //签证id
@property (nonatomic, copy) NSString * country_id;       //国家id
@property (nonatomic, copy) NSString * list_thumb;       //列表图片
@property (nonatomic, copy) NSString * interview;        //是否需要面试(0.不需要)
@property (nonatomic, copy) NSString * complete_addr;    //办理地址
@property (nonatomic, copy) NSString * enter_times;      //入境次数
@property (nonatomic, copy) NSString * active_times;     //有效时间
@property (nonatomic, copy) NSString * accept_conditions;//受理范围
@property (nonatomic, copy) NSString * unsubscribe;      //退订说明
@property (nonatomic, copy) NSString * book_notice;      //预订须知
@property (nonatomic, copy) NSString * addon;            //附加信息：所需材料说明(资料下载)
@property (nonatomic, copy) NSString * book_date;        //提前天数（暂定为办理天数）
@property (nonatomic, copy) NSString * visa_type;        //签证类型
@property (nonatomic, copy) NSString * index_thumb;      //首页图
@property (nonatomic, copy) NSString * atts;             //附件表
@property (nonatomic, copy) NSString * stay;             //停留时间
@property (nonatomic, copy) NSString * onjob;            //在职人员
@property (nonatomic, copy) NSString * freelance;        //自由职业者
@property (nonatomic, copy) NSString * instudent;        //在校学生
@property (nonatomic, copy) NSString * retiree;          //退休人员
@property (nonatomic, copy) NSString * preschoolers;     //学龄前儿童
@property (nonatomic, copy) NSString * success;          //出签率
@property (nonatomic, copy) NSString * tags;             //标签id
@property (nonatomic, copy) NSString * admin_type;       //供应商类型；
@property (nonatomic, copy) NSString * gj_commission;    //管家返佣；
@property (nonatomic, copy) NSString * deal_time;
@property (nonatomic, copy) NSString * admin_id;         //所属供应商id
@property (nonatomic, copy) NSString * company_name;     //供应商名字；
@property (nonatomic, copy) NSString * commission;       //新管家返佣


/*新版字段*/
@property (nonatomic, copy) NSString * area_province;//领区受理范围
@property (nonatomic, copy) NSString * area_name;//领区名字

- (id)initWithDictionary:(NSDictionary *)dic;


//



@end
