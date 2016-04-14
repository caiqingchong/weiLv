//
//  YXTraveDetailModel.h
//  WelLv
//
//  Created by lyx on 15/4/22.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXCustomTraveModel.h"
@class YXSchedule;
@interface YXTraveDetailModel : NSObject
@property (nonatomic,copy)NSString *order_members;
@property (nonatomic,copy)NSString *members;
@property (nonatomic,copy)NSString *product_id;    //产品id
@property (nonatomic,copy)NSString *parent_id;     //父id
@property (nonatomic,copy)NSString *product_name;  //产品名称
@property (nonatomic,copy)NSString *product_sn;    //
@property (nonatomic,copy)NSString *city_id;       //城市id
@property (nonatomic,copy)NSString *admin_id;      //销售商id
@property (nonatomic,copy)NSString *admin_type;    //添加人类型
@property (nonatomic,copy)NSString *peers_price;   //同行价
@property (nonatomic,copy)NSString *category_id;   //分类id
@property (nonatomic,copy)NSString *sell_price;   //销售价
@property (nonatomic,copy)NSString *verify;        //
@property (nonatomic,copy)NSString *verify_mark;
@property (nonatomic,copy)NSString *thumb;         //缩略图
@property (nonatomic,copy)NSString *status;        //状态
@property (nonatomic,copy)NSString *tags;          //
@property (nonatomic,copy)NSString *is_top;
@property (nonatomic,copy)NSString *click_count;   //点击次数
@property (nonatomic,copy)NSString *is_draft;
@property (nonatomic,copy)NSString *sell_count;    //假销量
@property (nonatomic,copy)NSString *is_delete;     //是否删除
@property (nonatomic,copy)NSString *add_time;      //添加时间
@property (nonatomic,copy)NSString *update_time;   //更新时间
@property (nonatomic,copy)NSString *real_sell_count;  //真销量
@property (nonatomic,copy)NSString *zd_commission;    //
@property (nonatomic,copy)NSString *gj_commission;
@property (nonatomic,copy)NSString *ms_commission;
@property (nonatomic,copy)NSString *route_id;      //旅游产品分类id
@property (nonatomic,copy)NSString *route_type;    //旅游产品分类
@property (nonatomic,copy)NSString *profile;       //简短描述
@property (nonatomic,copy)NSString *child_standard;     //儿童收费标准
@property (nonatomic,copy)NSString *schedule_days;      //行程天数
@property (nonatomic,copy)NSString *f_district;         //出发地id
@property (nonatomic,copy)NSString *f_city_path;        //出发城市
@property (nonatomic,copy)NSString *t_city;             //目的城市id
@property (nonatomic,copy)NSString *t_city_path;        //目的城市id路径
@property (nonatomic,copy)NSString *timetable_range;

@property (nonatomic,copy)NSString *adult_price;        //成人价
@property (nonatomic,copy)NSString *child_price;        //儿童价
@property (nonatomic,copy)NSString *timetable;          //班期循环方式
@property (nonatomic,copy)NSString *timetable_people;   //每班班期的人数
@property (nonatomic,copy)NSString *book_info;          //
@property (nonatomic,copy)NSString *contract_id;        //合同id
@property (nonatomic,copy)NSString *album;              //相册图片id
@property (nonatomic,copy)NSString *feature;            //特色内容
@property (nonatomic,copy)NSString *fee_include;        //费用说明
@property (nonatomic,copy)NSString *fee_not_include;    //费用不含
@property (nonatomic,copy)NSString *notice;             //温馨提示
@property (nonatomic,copy)NSString *visited;            //查看次数
@property (nonatomic,copy)NSString *validdate;          //产品有效期(即报名截止日期)
@property (nonatomic,copy)NSString *b_day;              //限制天数
@property (nonatomic,copy)NSString *b_minute;           //显示分钟
@property (nonatomic,copy)NSString *b_hour;             //限制小时
@property (nonatomic,copy)NSString *js_datetime;        //日历开始时间
@property (nonatomic,copy)NSString *f_continent;        //出发地洲
@property (nonatomic,copy)NSString *f_country;          //出发地国家
@property (nonatomic,copy)NSString *f_province;         //出发地省
@property (nonatomic,copy)NSString *f_city;             //
@property (nonatomic,copy)NSString *t_continent;        //
@property (nonatomic,copy)NSString *t_country;          //目的地国家
@property (nonatomic,copy)NSString *t_province;         //目的地省
@property (nonatomic,copy)NSString *reception_standard; //接待标准
@property (nonatomic,copy)NSString *along_scene;        //沿途景点
@property (nonatomic,copy)NSString *special_limit;      //特殊限制
@property (nonatomic,copy)NSString *safety_prompt;      //安全提示
@property (nonatomic,copy)NSString *warm_prompt;        //温馨提示
@property (nonatomic,copy)NSString *sign_way;           //签约方式
@property (nonatomic,copy)NSString *route_overview;     //行程概览
@property (nonatomic,copy)NSString *import_notice;      //重要提示
@property (nonatomic,copy)NSString *special_privilege;  //特别优惠
@property (nonatomic,copy)NSString *apply_close;        //报名截止
@property (nonatomic,copy)NSString *relative_files;     //相关资料
@property (nonatomic,copy)NSString *category;
@property (nonatomic,strong)NSMutableArray *timetable_custom;   //自定义班期
@property (nonatomic,copy)NSString *preset_time;
@property (nonatomic,copy)NSString *custom_json;        //自定义班期
@property (nonatomic,copy)NSString *loop_json;          //循环班期
@property (nonatomic,strong)NSMutableArray *schedule;        //行程
@property (nonatomic,strong)NSMutableArray *album_list;      //图片
@property (nonatomic,strong)NSMutableArray *departure_info;  //出发信息
@property (nonatomic,copy)NSString *company;              //所属公司
@property (nonatomic,copy)NSString *refund_schema;//退款方案 0标准退订，1自定义，2不支持退订
@property (nonatomic,copy)NSString *custom_schema;//退款自定义内容
@property (nonatomic,copy)NSString *lastest;//最近出发时间
@property (nonatomic,copy)NSString *pay_way;//支付方式状态(立即支付或等待确认)

@end

@interface YXSchedule : NSObject

@property (nonatomic,copy)NSString *schedule_id;           //行程id
@property (nonatomic,copy)NSString *product_id;            //产品id
@property (nonatomic,copy)NSString *product_type;          //产品类型
@property (nonatomic,copy)NSString *day;                   //时间行程或天数行程
@property (nonatomic,copy)NSString *title;                       //行程标题
@property (nonatomic,copy)NSString *breakfast;                   //早餐
@property (nonatomic,copy)NSString *lunch;                       //产品类型
@property (nonatomic,copy)NSString *dinner;                     //晚餐
@property (nonatomic,copy)NSString *room;                      //酒店
@property (nonatomic,copy)NSString *vehicle;                  //车辆
@property (nonatomic,copy)NSString *activities;               //行程详情
@property (nonatomic,copy)NSString *admin_id;                //管理员id
@property (nonatomic,copy)NSString *add_time;                //添加时间
@property (nonatomic,copy)NSString *upd_time;                //更新时间
@property (nonatomic,strong)NSMutableArray *schedule_images; //行程图片列表
@end

@interface YXAlbum_list : NSObject
@property (nonatomic,copy)NSString *album_id;           //相册id
@property (nonatomic,copy)NSString *station_id;            //
@property (nonatomic,copy)NSString *user_id;            //
@property (nonatomic,copy)NSString *continent;          //
@property (nonatomic,copy)NSString *country;            //
@property (nonatomic,copy)NSString *provinde;          //
@property (nonatomic,copy)NSString *city;               //
@property (nonatomic,copy)NSString *district;           //
@property (nonatomic,copy)NSString *picture;            //图片
@property (nonatomic,copy)NSString *created_time;        //

@end


@interface YXDeparture_info : NSObject
@property (nonatomic,copy)NSString *info_id;           //id
@property (nonatomic,copy)NSString *product_id;            //
@property (nonatomic,copy)NSString *time;            //
@property (nonatomic,copy)NSString *f_place;          //
@property (nonatomic,copy)NSString *remark;            //
@property (nonatomic,copy)NSString *t_place;          //
@end
