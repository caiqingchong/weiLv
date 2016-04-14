//
//  ShipListModel.h
//  WelLv
//  首页使用-邮轮-Cell自定义
//  Created by James on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipListModel : NSObject
@property (nonatomic, copy) NSString * product_id;          //产品id
@property (nonatomic, copy) NSString * parent_id;           //父id
@property (nonatomic, copy) NSString * product_name;        //产品名称
@property (nonatomic, copy) NSString * product_sn;          //产品编号
@property (nonatomic, copy) NSString * city_id;             //出发城市id
@property (nonatomic, copy) NSString * admin_id;            //所属供应商id
@property (nonatomic, copy) NSString * admin_type;          //所属供应商分类
@property (nonatomic, copy) NSString * perrs_price;         //同行价
@property (nonatomic, copy) NSString * sell_price;          //销售价
@property (nonatomic, copy) NSString * child_peers_price;   //
@property (nonatomic, copy) NSString * child_sell_price;    //
@property (nonatomic, copy) NSString * category_id;         //分类id
@property (nonatomic, copy) NSString * verify;              //备注
@property (nonatomic, copy) NSString * verify_mark;         //审核状态
@property (nonatomic, copy) NSString * thumb;               //缩略图片
@property (nonatomic, copy) NSString * status;              //上下架状态   1.上架；0.下架
@property (nonatomic, copy) NSString * tags;                //标签id
@property (nonatomic, copy) NSString * is_top;              //
@property (nonatomic, copy) NSString * click_count;         //点击次数
@property (nonatomic, copy) NSString * is_draft;            //是否草稿     1.草稿；0.非草稿
@property (nonatomic, copy) NSString * sell_count;          //假销量
@property (nonatomic, copy) NSString * is_delete;           //是否删除     1.删除；0.正常
@property (nonatomic, copy) NSString * add_time;            //添加时间
@property (nonatomic, copy) NSString * update_time;         //更新时间
@property (nonatomic, copy) NSString * real_sell_count;     //真销量
@property (nonatomic, copy) NSString * zd_commission;       //总店返佣
@property (nonatomic, copy) NSString * gj_commission;       //管家返佣
@property (nonatomic, copy) NSString * ms_commission;       //运营商返佣
@property (nonatomic, copy) NSString * line_id;             //航线id
@property (nonatomic, copy) NSString * company_id;          //公司id
@property (nonatomic, copy) NSString * cruise_id;           //所属邮轮id
@property (nonatomic, copy) NSString * line_thumb;          //航线缩略图
@property (nonatomic, copy) NSString * setoff_date;         //出发日期
@property (nonatomic, copy) NSString * return_date;         //返程日期
@property (nonatomic, copy) NSString * prot;                //
@property (nonatomic, copy) NSString * pass_city;           //途经城市
@property (nonatomic, copy) NSString * last_days;           //行程总时间
@property (nonatomic, copy) NSString * book_date;           //预订提前天数
@property (nonatomic, copy) NSString * cost_include;        //费用包含
@property (nonatomic, copy) NSString * cost_exclusive;      //费用不含
@property (nonatomic, copy) NSString * features;            //特色
@property (nonatomic, copy) NSString * notice;              //提示信息
@property (nonatomic, copy) NSString * recommended;         //
@property (nonatomic, copy) NSString * line_name;           //
@property (nonatomic, copy) NSString * profile;             //
@property (nonatomic, copy) NSString * upd_time;            //
@property (nonatomic, copy) NSString * characteristic;      //
@property (nonatomic, copy) NSString * keywords;            //
@property (nonatomic, copy) NSString * ID;                  //
@property (nonatomic, copy) NSString * name;                //
@property (nonatomic, copy) NSString * loge;                //
@property (nonatomic, copy) NSString * intro;               //
@property (nonatomic, copy) NSString * sn_cruise;           //
@property (nonatomic, copy) NSString * lib_id;              //
@property (nonatomic, copy) NSString * area_id1;            //
@property (nonatomic, copy) NSString * area_id2;            //
@property (nonatomic, copy) NSString * area_id3;            //
@property (nonatomic, copy) NSString * cruise_company_id;   //
@property (nonatomic, copy) NSString * supplier_id;         //
@property (nonatomic, copy) NSString * product_type_id;     //
@property (nonatomic, copy) NSString * cruise_name;         //
@property (nonatomic, copy) NSString * tonnage;             //
@property (nonatomic, copy) NSString * rooms;               //
@property (nonatomic, copy) NSString * floors;              //
@property (nonatomic, copy) NSString * harbor;              //
@property (nonatomic, copy) NSString * score;               //
@property (nonatomic, copy) NSString * label;               //
@property (nonatomic, copy) NSString * verified;            //
@property (nonatomic, copy) NSString * click;               //
@property (nonatomic, copy) NSString * sort;                //
@property (nonatomic, copy) NSString * min_price;           //成人价
@property (nonatomic, copy) NSString * brand_name;          //
@property (nonatomic, copy) NSString * ship_name;           //
@property (nonatomic, copy) NSString * port_name;           //
@property (nonatomic, copy) NSString * max_butler_s;        //返佣

- (id)initWithDictionary:(NSDictionary *)dic;


@end
