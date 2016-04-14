//
//  WLSingletonClass.h
//  WelLv
//
//  Created by WeiLv on 15/10/30.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WLProductType){
    WLProductTypeTravel,    //旅游
    WLProductTypeShip,      //邮轮
    WLProductTypeStudyTour, //游学
    WLProductTypeTicket,    //门票
    WLProductTypeVisa,      //签证
    WLProductTypeAirTicket, //机票
    WLProductTypeHotel,     //酒店
    WLProductTypeDriveEat   //自驾吃
};
typedef NS_ENUM(NSInteger, WLMemberType){
    WLMemberTypeNone,     //没有登录
    WLMemberTypeMember,   //会员登录
    WLMemberTypeSteward   //管家登录
};

typedef NS_ENUM(NSInteger, WLOrderSource) {
    WLOrderSourceNone,
    WLOrderSourceStewardShop,
};

@interface WLSingletonClass : NSObject
//获取管家model
@property (nonatomic, strong) WLUserStewardModel * modelSteawrd;
//获取用户model
@property (nonatomic, strong) WLUserMemberModel * modelMember;

+ (WLSingletonClass *)defaultWLSingleton;

/**
 *  获取用户的ID。
 *
 *  @return 返回用户的ID。
 */
- (NSString *)wlUserID;

/**
 *  获取用户的类型
 *
 *  @return 看枚举  WLMemberType
 */
- (WLMemberType)wlUserType;

/**
 *  判断会员是否拥有管家
 *
 *  @return
 */
- (BOOL)wlUserIsHaveSteward;

/**
 *  返回会员的管家ID
 *
 *  @return 管家ID
 */
- (NSString *)wlUserStewardID;

/**
 *  根据类型返回但前产品的cat_id。
 *
 *  @param productType 枚举。
 *
 *  @return cat_id字符串。
 */
- (NSString *)wlProductTypeCatId:(WLProductType)productType;

- (NSString *)wlUserSteShopID;


- (BOOL)wlUserIsHaveSteShop;

/**
 *
 *  判断是不是合伙人-->stroe_id
 */
- (BOOL)wlSetHehuo;


//判断Thumb图片的URL
- (NSString *)wlJudgeThumbImageViewURLStr:(NSString *)urlStr;

//判断Album图片URL
- (NSString *)wlJudgeAlbumImageViewURLStr:(NSString *)urlStr;

//判断图片的URL和需要拼接的字符串
- (NSString *)wlJudgeImageViewURLStr:(NSString *)urlStr splicingStr:(NSString *)splicingStr;

//数组转JSON
- (NSString*)wlDictionaryToJson:(NSDictionary *)dic;

//dic转JSON
- (NSString*)wlArrayToJson:(NSArray *)arr;

//JSON转其它
- (id)wlJsonStringToDicOrArr:(NSString *)jsonString;

- (NSString *)wlLocationCityName;

- (NSString *)wlLocationCityId;

- (NSString *)wlChooseCityName;

- (NSString *)wlChooseCityId;

- (NSString *)wlCityId;

- (NSString *)wlCityName;

//判断自驾吃店铺
- (BOOL)wlUserIsHaveDEShop;

//获取自驾吃店铺ID
- (NSString *)wlDEShopID;
//0：申请中  1：审核通过 2:禁用 3：申请失败
- (NSString *)wldeShopStatus;

//yyyy-MM-dd hh:mm
- (NSString *)wlTimeYYYY_MM_dd_hh_mmWith1970Str:(NSString *)timeStr;

//yyyy-MM-dd
- (NSString *)wlTimeYYYY_MM_ddWith1970Str:(NSString *)timeStr;

- (NSString *)wlNowTimeFormatterStr:(NSString *)formatterStr;

- (void)wlAddNoDataViewWithSuperView:(UIView *)superView;

- (void)wlHiddenNoDataView;

@end
