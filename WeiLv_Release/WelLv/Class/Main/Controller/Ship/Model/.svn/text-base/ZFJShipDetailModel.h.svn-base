//
//  ZFJShipDetailModel.h
//  WelLv
//
//  Created by 张发杰 on 15/5/19.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZFJShipDetailModel : NSObject
@property (nonatomic, copy)NSString *product_id;       //产品id
@property (nonatomic, copy)NSString *line_id;          //路线id
@property (nonatomic, copy)NSString *company_id;       //公司id
@property (nonatomic, copy)NSString *cruise_id;        //所属邮轮id
@property (nonatomic, copy)NSString *product_name;     //产品名称
@property (nonatomic, copy)NSString *line_thumb;       //线路缩略图
@property (nonatomic, copy)NSString *thumb;            //
@property (nonatomic, copy)NSString *setoff_date;      //出发日期
@property (nonatomic, copy)NSString *return_date;      //返程日期
@property (nonatomic, copy)NSString *port;             //
@property (nonatomic, copy)NSString *pass_city;        //途经城市
@property (nonatomic, copy)NSString *last_days;        //形成总时间
@property (nonatomic, copy)NSString *book_date;        //预订提前天数
@property (nonatomic, copy)NSString *cost_include;     //费用包含         html标签字符串
@property (nonatomic, copy)NSString *cost_exclusive;   //费用不含         html标签字符串
@property (nonatomic, copy)NSString *features;         //特色            html标签字符串
@property (nonatomic, copy)NSString *notice;           //注意事项         html标签字符串
@property (nonatomic, copy)NSString *status;           //
@property (nonatomic, copy)NSString *product_sn;       //产品编号
@property (nonatomic, copy)NSString *recommended;      //
@property (nonatomic, copy)NSString *admin_id;         //产品添加人id
@property (nonatomic, copy)NSString *admin_type;       //产品添加人分类
@property (nonatomic, copy)NSString *parent_id;        //
@property (nonatomic, copy)NSString *line_name;        //路线名称
@property (nonatomic, copy)NSString *brand_name;       //
@property (nonatomic, copy)NSString *ship_name;        //邮轮名称
@property (nonatomic, copy)NSString *port_name;        //
@property (nonatomic, copy)NSString *features_sub;     //
@property (nonatomic, copy)NSString *min_price;        //起价
@property (nonatomic, copy)NSString *company_name;     //公司名
@property (nonatomic, copy)NSString *supplier_name;    //供应商名字
@property (nonatomic, copy)NSString *book_notice;     //预订须知
@property (nonatomic, copy)NSString *harbor_name;     //出发港口
@property (nonatomic, copy)NSString *license;//经营许可证号
@property (nonatomic, strong)NSMutableArray *roomModelArr;     //房间信息
@property (nonatomic, strong)NSMutableArray *scheduleModelArr; //行程安排
@property (nonatomic, strong)NSMutableArray *albumModelArr;    //相册

//4.2 03-21 新版游轮
@property (nonatomic, strong)NSDictionary *room;     //房间信息

@property (nonatomic, strong)NSDictionary *schedule; //行程安排
@property (nonatomic, strong)NSArray *album_list;    //相册

- (id)initWithDictionary:(NSDictionary *)dic;




@end

@interface ZFJShipRoom : NSObject

@property (nonatomic, copy)NSString *cabin_id;             //船舱id
@property (nonatomic, copy)NSString *cruise_id;            //所属邮轮id
@property (nonatomic, copy)NSString *supplier_id;          //添加供应商的id
@property (nonatomic, copy)NSString *type_id;              //船舱类型id
@property (nonatomic, copy)NSString *cabin_name;           //船舱名称
@property (nonatomic, copy)NSString *cabin_price;          //船舱价格
@property (nonatomic, copy)NSString *profile;              //邮轮船舱介绍
@property (nonatomic, copy)NSString *size;                 //船舱大小
@property (nonatomic, copy)NSString *num;                  //单舱可住人数
@property (nonatomic, copy)NSString *notice;               //提示信息
@property (nonatomic, copy)NSString *thumb;                //船舱缩略图
@property (nonatomic, copy)NSString *verified;             //审核状态
@property (nonatomic, copy)NSString *verify_mark;          //审核注释信息
@property (nonatomic, copy)NSString *is_draft;             //是否草稿      0不是草稿
@property (nonatomic, copy)NSString *sharing;              //分成信息
@property (nonatomic, copy)NSString *recommend;            //是否推荐      0不推荐
@property (nonatomic, copy)NSString *sell_count;           //销量
@property (nonatomic, copy)NSString *is_delete;            //是否已删除    0未删除
@property (nonatomic, copy)NSString *floor;                //所在层数
@property (nonatomic, copy)NSString *check_in;             //已住人数
@property (nonatomic, copy)NSString *rooms;                //此类船舱总数量
@property (nonatomic, copy)NSString *click;                //点击量
@property (nonatomic, copy)NSString *add_time;             //创建时间
@property (nonatomic, copy)NSString *upd_time;             //更新时间
@property (nonatomic, copy)NSString *room_id;              //房间id
@property (nonatomic, copy)NSString *room_name;            //房间名称
@property (nonatomic, copy)NSString *room_price;           //同行价
@property (nonatomic, copy)NSString *room_price2;          //市场价
@property (nonatomic, copy)NSString *room_34_price;        //第3/4人同行价
@property (nonatomic, copy)NSString *room_34_price2;       //第3/4人市场价
@property (nonatomic, copy)NSString *seller_s;             //
@property (nonatomic, copy)NSString *store_s;              //
@property (nonatomic, copy)NSString *butler_s;             //
@property (nonatomic, copy)NSString *product_id;           //产品id
@property (nonatomic, copy)NSString *sort;                 //
@property (nonatomic, copy)NSString *stock;                //库存
@property (nonatomic, copy)NSString *sell;                 //已售出的数量
@property (nonatomic, copy)NSString *line_id;              //线路id

@property (nonatomic, copy)NSString *c_id;              //
//@property (nonatomic, copy)NSString *product_id;              //
@property (nonatomic, copy)NSString *type_name;              //
@property (nonatomic, copy)NSString *first_price;              //
@property (nonatomic, copy)NSString *second_price;              //
@property (nonatomic, copy)NSString *third_price;              //
@property (nonatomic, copy)NSString *rebate;              //
//@property (nonatomic, copy)NSString *sell;              //
//@property (nonatomic, copy)NSString *stock;              //
//@property (nonatomic, copy)NSString *cabin_id;              //
//@property (nonatomic, copy)NSString *cabin_name;              //
@property (nonatomic, copy)NSString *album;              //
//@property (nonatomic, copy)NSString *size;              //
//@property (nonatomic, copy)NSString *num;              //
@property (nonatomic, copy)NSString *floors;              //
//@property (nonatomic, copy)NSString *profile;              //
@property (nonatomic, copy)NSString *album_list;              //
@property (nonatomic, copy)NSString *cabin_thumb;              //



- (id)initWithDictionary:(NSDictionary *)dic;

@end

@interface ZFJshipSchedule : NSObject

@property (nonatomic, copy)NSString *schedule_id;        //行程id
@property (nonatomic, copy)NSString *product_id;         //产品id
@property (nonatomic, copy)NSString *product_type;       //产品分类
@property (nonatomic, copy)NSString *day;                //行程天数
@property (nonatomic, copy)NSString *title;              //行程标题
@property (nonatomic, copy)NSString *breakfast;          //是否含早餐
@property (nonatomic, copy)NSString *lunch;              //是否含午餐
@property (nonatomic, copy)NSString *dinner;             //是否含晚餐
@property (nonatomic, copy)NSString *room;               //住宿
@property (nonatomic, copy)NSString *vehicle;            //交通工具
@property (nonatomic, copy)NSString *admin_type;         //添加人id
@property (nonatomic, copy)NSString *add_time;           //添加时间
@property (nonatomic, copy)NSString *upd_time;           //更新时间
@property (nonatomic, copy)NSString *schedule_type;      //
@property (nonatomic, copy)NSString *type;               //
@property (nonatomic, copy)NSString *detail;             //
@property (nonatomic, strong)NSArray * album;              //


@property (nonatomic, strong)NSMutableArray *scenesMoelArr;     //
- (id)initWithDictionary:(NSDictionary *)dic;

@end

@interface ZFJShipScenes : NSObject

@property (nonatomic, copy)NSString *scene_id;            //
@property (nonatomic, copy)NSString *time;                //
@property (nonatomic, copy)NSString *schedule_id;         //行程id
@property (nonatomic, copy)NSString *time_type;           //
@property (nonatomic, copy)NSString *details;             //
@property (nonatomic, copy)NSString *scene_type;          //信息类别
@property (nonatomic, copy)NSString *imgs;                //图片id
@property (nonatomic, copy)NSString *product_id;          //产品id
@property (nonatomic, copy)NSString *scenes_album;        //
- (id)initWithDictionary:(NSDictionary *)dic;


@end

@interface ZFJShipAlbum : NSObject
@property (nonatomic, copy)NSString *album_id;              //相册id
@property (nonatomic, copy)NSString *picture;               //
@property (nonatomic, copy)NSString *breakfast;          //是否含早餐
@property (nonatomic, copy)NSString *product_id;            //
- (id)initWithDictionary:(NSDictionary *)dic;

@end

@interface ZFJShoreTraveModel : NSObject
@property (nonatomic, copy)NSString *schedule_id;         //行程id
@property (nonatomic, copy)NSString *tour_name;           //
@property (nonatomic, copy)NSString *breakfast;           //是否含早餐
@property (nonatomic, copy)NSString *lunch;               //是否含午餐
@property (nonatomic, copy)NSString *dinner;              //是否含晚餐
@property (nonatomic, copy)NSString *room;                //住宿
@property (nonatomic, copy)NSString *detail;              //
@property (nonatomic, copy)NSArray *album;               //
@property (nonatomic, copy)NSString *day;                 //
@property (nonatomic, copy)NSString *destination;         //
@property (nonatomic, copy)NSString *tour_price;          //
@property (nonatomic, copy)NSString *fee_status;          //
@property (nonatomic, copy)NSString *arrival_time;        //
@property (nonatomic, copy)NSString *sail_time;           //
@property (nonatomic, copy)NSString *tour_id;           //

- (id)initWithDictionary:(NSDictionary *)dic;

@end



