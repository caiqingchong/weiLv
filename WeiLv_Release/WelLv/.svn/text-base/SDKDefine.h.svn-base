//
//  SDKDefine.h
//  WelLv
//
//  Created by lyx on 15/4/2.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
 
#ifndef WelLv_SDKDefine_h
#define WelLv_SDKDefine_h

#define AssistantPhone @"assistant_mobile"     //绑定的管家电话

//各模块分享产品详情-主机域名
#define WXHTTP [NSString stringWithFormat:@"http://m.weilv100.com"]

//#define WLHTTP [NSString stringWithFormat:@"https://www.weilv100.com"]


//#define WLHTTP [NSString stringWithFormat:@"http://42.weilv100.com"]


//#define WLHTTP [NSString stringWithFormat:@"http://112.126.68.22"]

#define WLHTTP [NSString stringWithFormat:@"http://101.201.211.41:8088"]

#define homeBannerUrl  [NSString stringWithFormat:@"%@/p/phoneapi/banner/index.asp",HTTP]
/*s首页数据*/
#define newHomeURL [NSString stringWithFormat:@"%@/api/appHome/getHomeInfo",WLHTTP] 

/*微旅公告*/
#define WeiLvAnnounce [NSString stringWithFormat:@"%@/api/appHome/getWeilvAnnounce",WLHTTP]

/*特权在线*/
#define PriteOnlineUrl @"http://privilege.weilv100.com/tequan/index/index/"

/*管家*/
#define GJServiceRecordUrl [NSString stringWithFormat:@"%@/api/assistant/service_record",WLHTTP]    //管家服务记录
#define houseDetailUrl(code)  [NSString stringWithFormat:@"%@/api/assistant/info/%@",WLHTTP,code]       //管家详情
//#define bindHouseUrl [NSString stringWithFormat:@"%@/api/assistant/attach",WLHTTP]    //绑定管家
#define bindHouseUrl [NSString stringWithFormat:@"%@/api/assistant/attach_member",WLHTTP]    //绑定管家
#define getHouseListUrl [NSString stringWithFormat:@"%@/api/assistant/lists",WLHTTP]    //获取管家详情
#define GJManageSelfInfoUrl [NSString stringWithFormat:@"%@/api/assistant/profile",WLHTTP]  //管家修改自己信息
#define AssitantData @"assitantData"
#define GetHouserSmsUrl [NSString stringWithFormat:@"%@/api/assistant/get_sms",WLHTTP]    //获取管家短信记录
#define SendMsgUrl  [NSString stringWithFormat:@"%@/api/assistant/send_sms",WLHTTP]    //管家发送短信
#define myUrl(code) [NSString stringWithFormat:@"%@/api/assistant/member_info/%@",WLHTTP,code] //管家获取会员信息
#define GjManagMemberURL [NSString stringWithFormat:@"%@/api/assistant/member_info",WLHTTP] //管家修改会员信息
#define membertagUrl [NSString stringWithFormat:@"%@/api/assistant/member_tag",WLHTTP]      //管家添加会员备注   获取get 添加post
#define memberTagUrl(code) [NSString stringWithFormat:@"%@/api/assistant/member_tag/%@",WLHTTP,code] 
#define getHouseAdmin_id(code) [NSString stringWithFormat:@"%@/api/assistant/get_seller_id/%@",WLHTTP,code] //获取管家所属销售商id

/*微信登陆*/
#define WeiLoginUrl [NSString stringWithFormat:@"%@/api/weixin/login",WLHTTP]      //微信第三方登陆
#define WeiBindPhoneUrl [NSString stringWithFormat:@"%@/api/weixin/bind_phone",WLHTTP]      //第三方登陆绑定手机号
#define GetVerficatCodeUrl [NSString stringWithFormat:@"%@/api/sms/send_msg",WLHTTP]      //获取验证码
#define WeiXinCodeUrl  [NSString stringWithFormat:@"%@/api/sms/send_wx_bind_vcode",WLHTTP]     //微信第三方登录专用获取验证码
#define RegisterUrl [NSString stringWithFormat:@"%@/front/member/register_action",WLHTTP]      //新用户注册
/*微信支付*/
#define NOTIFY_URL      [NSString stringWithFormat:@"%@/pay/pay/wxbackurl",WLHTTP]    //支付结果回调页面

/*qq登陆*/
#define QQLoginUrl [NSString stringWithFormat:@"%@/api/qqApi/login",WLHTTP]      //QQ第三方登陆
#define QQBindPhoneUrl [NSString stringWithFormat:@"%@/api/qqApi/bind_phone",WLHTTP]      //qq第三方登陆绑定手机号
#define QQCodeUrl  [NSString stringWithFormat:@"%@/api/sms/send_qq_bind_vcode",WLHTTP]     //QQ第三方登录专用获取验证码

/*支付宝支付*/
#define ZFBNOTIFY_URL   [NSString stringWithFormat:@"%@/pay/pay/alipayNoticeBack",WLHTTP]    //支付结果回调页面


/*旅游*/
#define TraveDetailUrl [NSString stringWithFormat:@"%@/api/route/detail",WLHTTP]      //旅游详情
#define GetCityUrl [NSString stringWithFormat:@"%@/api/route/region",WLHTTP]       //获取城市
#define ListTraveUrl [NSString stringWithFormat:@"%@/api/route/getList",WLHTTP]      //旅游列表
#define PathImagelUrl [NSString stringWithFormat:@"%@/upload/album/",WLHTTP]      //图片路径
#define ORDER_PAY_NOTIFICATION @"OrderPayNotification"


/*个人中心*/
#define DeletePanter_Url   [NSString stringWithFormat:@"%@/api/assistant/cancel_partner",WLHTTP]    //删除合伙人

#define UpdatePhotoUrl [NSString stringWithFormat:@"%@/api/member/save_my_avatar",WLHTTP]         //修改图像
#define UpdateImage @"UpdateImage"      //登陆成功后更新图像通知
#define ISNULL @"(null)"               //返回为空
#define FeedbackUrl [NSString stringWithFormat:@"%@/api/member/add_feedback",WLHTTP]      //意见反馈
#define UpdateUserInfo  [NSString stringWithFormat:@"%@/api/member/update_info",WLHTTP]     //修改个人信息

//#define UpdateCommonInfo [NSString stringWithFormat:@"%@/api/member/update_common_userinfo",WLHTTP]  //修改常用游客,使用这一个
#define UpdateCommonInfo [NSString stringWithFormat:@"%@/api/member/add_tourist_information",WLHTTP] //修改常用游客

#define UpdatePwd  [NSString stringWithFormat:@"%@/api/member/password",WLHTTP]  //修改密码
#define UpdatePhoneGetCode  [NSString stringWithFormat:@"%@/api/sms/send_identify_code",WLHTTP]  //修改手机号时获取验证码
#define UpdatePhone  [NSString stringWithFormat:@"%@/api/member/mobile",WLHTTP]  //修改手机号码
#define GetCommonList  [NSString stringWithFormat:@"%@/api/member/get_tourist_list_action",WLHTTP]  //获取常用联系人
#define DelCommon  [NSString stringWithFormat:@"%@/api/member/del_userinfo",WLHTTP]  //删除常用联系人
//#define ForgetPwdGetPwd  [NSString stringWithFormat:@"%@/api/ajaxMember/checkUserSendRand",WLHTTP]  //忘记密码--获取验证码
#define GetNewPwd  [NSString stringWithFormat:@"%@/api/ajaxMember/repassword",WLHTTP]  //获取新密码
#define AddCommonInfoUrl  [NSString stringWithFormat:@"%@/api/member/add_tourist_information",WLHTTP]  //添加常用游客
#define GetOrderInfoUrl  [NSString stringWithFormat:@"%@/api/orderApi/getOrderInfo",WLHTTP]  //获取订单详情
#define GetOrderListUrl  [NSString stringWithFormat:@"%@/api/orderApi/getFrontList",WLHTTP]  //获取订单列表
#define GetOrderListPhotoUrl  [NSString stringWithFormat:@"%@/api/orderApi/getOrderThumb",WLHTTP]  //获取订单列表图片
#define CancelOrderUrl  [NSString stringWithFormat:@"%@/api/orderApi/cancelOrder",WLHTTP]  //取消订单
#define CancelPlaneOrderUrl  [NSString stringWithFormat:@"%@/flight/flight/setdrawerstatus",WLHTTP]  //取消机票订单
#define houseQrCode(houseId)  [NSString stringWithFormat:@"%@/api/qrcodeApi/qrCode/%@",WLHTTP,houseId]     //管家二维码
#define houseRegirst(houseId)  [NSString stringWithFormat:@"%@/index.php/front/member/recommend_register/6-%@",WLHTTP,houseId]     //扫描二维码后注册

#define getSchoolSources  [NSString stringWithFormat:@"%@/api/assistantclass/get_sources",WLHTTP]  //管家学堂获取一级列表
#define detailSchoolSources  [NSString stringWithFormat:@"%@/api/assistantclass/get_sources_info",WLHTTP]  //管家学堂二级列表
#define commissionOrderList  [NSString stringWithFormat:@"%@/api/assistant/rebatelist",WLHTTP]  //管家返佣订单

#define AnnoucementList  [NSString stringWithFormat:@"%@/api/assistant/notice",WLHTTP]  //系统公告

//个人中心管家修改密码
#define M_USER_CENTER_CHANGE_PSW_STE [NSString stringWithFormat:@"%@/api/assistant/password",WLHTTP]

#define PERSONAL_TRAVELS_BANNER_URL @"http://www.weilv100.com/api/ad/ad_img_show"  //我的旅历－广告
#define PERSONAL_TRAVELS_JOURNEYS_URL [NSString stringWithFormat:@"%@/api/memberJourneyApi/get_journey_source",WLHTTP]  //获取全部景点
#define PERSONAL_TRAVELS_SUBMIT_URL [NSString stringWithFormat:@"%@/api/memberJourneyApi/save_data",WLHTTP]
#define PERSONAL_TRAVELS_MEMBERS_JOURNEYS_URL [NSString stringWithFormat:@"%@/api/memberJourneyApi/get_member_journey",WLHTTP]


/*登录注册*/
#define ordinaryLoginUrl [NSString stringWithFormat:@"%@/api/member/login_action",WLHTTP] //普通登录
#define ordinaryRegisterUrl [NSString stringWithFormat:@"%@/api/member/fast_register_action",WLHTTP]  //普通注册
#define FirstLoginUrl  [NSString stringWithFormat:@"%@/api/member/fast_register_action",WLHTTP]  //快速注册

/*管家登录URL*/
#define M_URL_STEWARD_LOGIN [NSString stringWithFormat:@"%@/api/assistant/login",WLHTTP]

/*签证*/
#define VisaLiveAdd [NSString stringWithFormat:@"%@/api/visaApi/getregions",WLHTTP]  //常用居住地
#define SendEmailUrl [NSString stringWithFormat:@"%@/front/member/update_info",WLHTTP]  //发送邮箱//
#define visaCountryList [NSString stringWithFormat:@"%@/api/visaApi/getVisaRegions",WLHTTP]//签证国家列表;
#define VisaADURL [NSString stringWithFormat:@"%@/%@", WLHTTP, @"api/ad/ad_img_show/85/"]//签证AD
#define VisaListUrl [NSString stringWithFormat:@"%@/api/visaApi/getList",WLHTTP]  //签证列表
#define GetVisaDownLoadUrl [NSString stringWithFormat:@"%@/api/visaApi/getAttachment",WLHTTP]  //获取签证下载资料

#define VisaDetailNeedMateria [NSString stringWithFormat:@"%@/api/visaApi/getVisaList",WLHTTP] //所需材料页面URL;
#define VisaType_URL [NSString stringWithFormat:@"%@/api/visaApi/getVisaType",WLHTTP] //签证——类型URL;

/*提交订单URL*/

#define orderDetailURL [NSString stringWithFormat:@"%@/api/orderApi/postOrder",WLHTTP]  //订单提交
#define testOrderDetailURL [NSString stringWithFormat:@"%@/api/orderApi/postOrder",WLHTTP]  //订单提交
/*我的会员列表*/

#define addMyMemberURL [NSString stringWithFormat:@"%@/api/assistant/member_register",WLHTTP] //管家添加会员列表URL;

#define myMemberListURL [NSString stringWithFormat:@"%@/api/assistant/members",WLHTTP] //管家会员列表URL;
#define myMemberSearchURL [NSString stringWithFormat:@"%@/api/assistant/members",WLHTTP] //搜索管家会员列表URL;

/*获取城市id*/
#define GetCityIDUrl [NSString stringWithFormat:@"%@/api/route/region",WLHTTP]  //获取城市id

/*中环航拍*/
#define zhonghuanHangPai @"http://wx.weilv100.com/index.php?g=Wap&m=Index&a=index&token=tqzvyg1423127896&wecha_id="  

/*社区*/
#define SheQuURL @"http://wsq.qq.com/reflow/263905219?_wv=1"

/**
 获取销售商信息
 **/
#define M_ADMIN_URL [NSString stringWithFormat:@"%@/api/admin/get_admininfo_by_id/",WLHTTP]

/**广告接口*/
#define AdvertUrl(adType,city_id)  [NSString stringWithFormat:@"%@/api/ad/ad_img_show/%@/%@",WLHTTP,adType,city_id]

#define AssitBookMsg  @"非常抱歉，您不能以旅行管家的身份预订该产品，旅行管家只能预订所属销售商的产品，请选择同类产品或联系销售商采购该产品。"
/*周边景点-更多*/
#define ShouYeMoreDestinations(city_id)  [NSString stringWithFormat:@"%@/api/appHome/getChoiceDestAdList/%@",WLHTTP,city_id]

/**
 *  门票接口
 *
 */
//门票首页接口
#define M_TICKET_HOME_URL [NSString stringWithFormat:@"%@/api/ticketAppApi/getIndexList",WLHTTP]
//门票列表接口
#define M_TICKET_LIST_URL [NSString stringWithFormat:@"%@/api/ticketAppApi/getProductList",WLHTTP]
//门票详情接口
#define M_TICKET_DETAIL_URL [NSString stringWithFormat:@"%@/api/ticketAppApi/getProductList",WLHTTP]
//门票热门城市接口
#define M_TICKET_HOTCITY_URL [NSString stringWithFormat:@"%@/api/ticketAppApi/getCityList",WLHTTP]
//门票日历接口
#define M_TICKET_CALENDAR_URL [NSString stringWithFormat:@"%@/api/ticketAppApi/getGoodPriceList",WLHTTP]
/*  门票广告*/
#define M_TICKET_AD [NSString stringWithFormat:@"%@/%@", WLHTTP, @"api/ad/ad_img_show/83/"]

/*邮轮老版4.0*/
//邮轮首页URL
#define M_SHIP_privilege_URL(city_id)  [NSString stringWithFormat:@"%@/api/youlun/index?city_id=%@",WLHTTP,city_id]
//邮轮列表
#define M_SHIP_LIST_URL(city_id)  [NSString stringWithFormat:@"%@/api/youlun/product_list?city_id=%@",WLHTTP,city_id]
//邮轮详情
#define M_SHIP_DETAIL_URL [NSString stringWithFormat:@"%@/api/youlun/product/",WLHTTP]
//邮轮日历产品
#define M_SHIP_calendarProduct(shijianchuo,city_id) [NSString stringWithFormat:@"%@/api/youlun/get_product_by_date?date=%@&city_id=%@",WLHTTP,shijianchuo,city_id]

/*邮轮新版4.2*/
//邮轮 --- 首页URL
#define M_URL_SHIP_HOME  [NSString stringWithFormat:@"%@/api/cruise/index",WLHTTP]
//邮轮 --- 列表URL
#define M_URL_SHIP_LIST  [NSString stringWithFormat:@"%@/api/cruise/product_list",WLHTTP]
//邮轮 --- 详情URL
#define M_URL_SHIP_DETAIL [NSString stringWithFormat:@"%@/api/cruise/product",WLHTTP]
//邮轮 --- 日历产品URL
#define M_URL_SHIP_CALENDAR [NSString stringWithFormat:@"%@/api/cruise/get_product_by_date", WLHTTP]
//邮轮 --- 列表 --- 筛选URL
#define M_URL_SHIP_LIST_FILTER [NSString stringWithFormat:@"%@/api/cruise/search_condition", WLHTTP]
//邮轮 --- 提交订单 URL
#define M_URL_SHIP_SUBMIT_ORDER [NSString stringWithFormat:@"%@/api/orderApi/postOrder", WLHTTP]


/**
 *  详情页面管家咨询列表接口
 */
#define M_CALL_HOUSEKEEPER_LIST_URL [NSString stringWithFormat:@"%@/api/assistant/get_assistant_by_selID/", WLHTTP]

/**游学*/
#define StudyTourUrl [NSString stringWithFormat:@"%@/api/yoosure/get_list",WLHTTP]      //游学
#define StudyTourCityUrl [NSString stringWithFormat:@"%@/api/yoosure/get_city",WLHTTP]      //游学国家
#define StudyTourDetailUrl [NSString stringWithFormat:@"%@/api/yoosure/get_detail",WLHTTP]      //游学国家
#define StudyTourThemeUrl [NSString stringWithFormat:@"%@/api/yoosure/get_type",WLHTTP]      //游学主题

/**
 *  机票
 */
#define ContactPersonList [NSString stringWithFormat:@"%@/api/flightApi/contactPersonList",WLHTTP]      //乘机人列表
#define addContactPerson [NSString stringWithFormat:@"%@/api/flightApi/addContactPerson",WLHTTP]      //添加联系人
#define delContactPerson [NSString stringWithFormat:@"%@/api/flightApi/delperson",WLHTTP]      //删除联系人
#define upDataContactPerson [NSString stringWithFormat:@"%@/api/flightApi/updateperson",WLHTTP]      //修改联系人
#define submitPlaneOrder [NSString stringWithFormat:@"%@/api/flightApi/addflight",WLHTTP]      //提交订单
#define PlaneShoworderinfo [NSString stringWithFormat:@"%@/api/flightApi/showorderinfo",WLHTTP]      //获取航班价格信息
#define PlaneTicketUrl [NSString stringWithFormat:@"%@/api/flightApi/getFlightList?",WLHTTP]    //机票列表
#define PlaneTicketCityUrl [NSString stringWithFormat:@"%@/api/flightApi/getAirportList",WLHTTP]    //城市列表
#define CheckFlightPriceUrl [NSString stringWithFormat:@"%@/api/flightApi/checkFlightPrice",WLHTTP]      //验票接口

// 详情页面的管家列表接口.
#define M_DETAIL_VC_HOUSE_KEEPER_LIST_URL [NSString stringWithFormat:@"%@/api/assistant/get_assistant_by_selID/",WLHTTP]

/*酒店*/
#define HotelCityList [NSString stringWithFormat:@"%@/api/hotel/citys",WLHTTP]      //验票接口
#define HotelList [NSString stringWithFormat:@"%@/api/hotel/lists",WLHTTP]//酒店列表
#define HotelFilter [NSString stringWithFormat:@"%@/api/hotel/filter",WLHTTP]//酒店列表（筛选）
#define HotelFilterArea [NSString stringWithFormat:@"%@/api/hotel/filter_area",WLHTTP]  //酒店列表（区域位置）



/**
 *  管家店铺的URL
 */
/**
 *  管家删除合伙人
 */
#define kGuanjiaDeleteHehuo  [NSString stringWithFormat:@"%@/api/assistant/cancel_partner",WLHTTP]

/*获取合伙人store_id (判断会员是否是合伙人)*/
#define M_SS_URL_JUDGE_SHOP [NSString stringWithFormat:@"%@/api/assistant/judge_member",WLHTTP]
/*店铺首页*/
#define M_SS_URL_SHOP_HOME [NSString stringWithFormat:@"%@/api/assistant/assistant_store_index",WLHTTP]
/*修改店铺头像*/
#define M_SS_URL_SHOP_ICON [NSString stringWithFormat:@"%@/api/assistant/save_store_avatar",WLHTTP]
/*修改店铺名称*/
#define M_SS_URL_SHOP_NAME [NSString stringWithFormat:@"%@/api/assistant/save_store",WLHTTP]
/*管家消息列表*/
#define M_SS_URL_SHOP_MSG [NSString stringWithFormat:@"%@/api/assistant/apply_partner_record",WLHTTP]
/*处理合伙人申请*/
#define M_SS_URL_DEAL_WITH_MSG [NSString stringWithFormat:@"%@/api/assistant/handle_partner_apply",WLHTTP]
/*成为合伙人*/
#define M_SS_URL_ADD_PARTNER [NSString stringWithFormat:@"%@/api/assistant/become_partner",WLHTTP]
/*取消管家分销产品信息*/
#define M_SS_URL_DELETE_GOODS [NSString stringWithFormat:@"%@/api/assistant/update_goods",WLHTTP]
/*合伙人列表*/
#define M_SS_URL_PARTNER_LIST [NSString stringWithFormat:@"%@/api/assistant/manage_partner",WLHTTP]
/*分销接口*/
#define M_SS_URL_DISTRIBUYION_GOODS [NSString stringWithFormat:@"%@/api/assistant/add_distribution_goods",WLHTTP]
/*邮轮获取设置分销舱位*/
#define M_SS_URL_SHIP_ROOMS [NSString stringWithFormat:@"%@/api/assistant/get_cruise_room",WLHTTP]
/*商品列表*/
#define M_SS_URL_GOODS_LIST [NSString stringWithFormat:@"%@/api/assistant/manage_goods",WLHTTP]
/*分销订单 列表接口*/
#define M_SS_URL_ORDER_LIST [NSString stringWithFormat:@"%@/api/assistant/get_distribute_orders",WLHTTP]
/*合伙人店铺首页*/
#define M_SS_URL_PARTNER_HOME [NSString stringWithFormat:@"%@/api/assistant/partner_store_index",WLHTTP]
/*获取管家店铺二维码图片*/
#define M_SS_URL_SHOP_QR [NSString stringWithFormat:@"%@/api/qrcodeApi/store_qr/store_id",WLHTTP]
/*分享的链接*/
#define M_SS_URL_SHOP_SHARE_URL [NSString stringWithFormat:@"%@/assistant/assistant/identify_qr/63-",WLHTTP]
/*获取管家、合伙人sotre_id*/
#define M_SS_URL_SHOP_ID [NSString stringWithFormat:@"%@/api/assistant/get_store_id",WLHTTP]
/*管家明细页面的接口*/
#define M_URL_SS_MONEY_DETAIL [NSString stringWithFormat:@"%@/api/assistant/rebatelist",WLHTTP]
/*合伙人明细页面的接口*/
#define M_URL_SS_PARTNER_MONEY_DETAIL [NSString stringWithFormat:@"%@/api/member/get_rebatelist",WLHTTP]


/*
  自驾吃-管家
*/
/*获取银行接口*/
#define GetBankList [NSString stringWithFormat:@"%@/api/drivingBank/get_bank",WLHTTP]
/*管家查看自驾吃店家列表*/
#define GetMyShopList [NSString stringWithFormat:@"%@/api/drivingAssistant/get_driving_features_eat_list",WLHTTP]
/*管家同意或拒绝店铺申请*/
#define AduitUrl [NSString stringWithFormat:@"%@/api/drivingAssistant/agree_refusal_apply",WLHTTP]
/*商铺管理查看收入*/
#define GetIncomeDetailURL [NSString stringWithFormat:@"%@/api/drivingAssistant/get_assistant_index_income",WLHTTP]
/*管家开户*/
#define DriveOpenShop [NSString stringWithFormat:@"%@/api/drivingAssistant/add_driving_features_eat",WLHTTP]
/*会员申请开户*/
#define DriveMemberApplyShop [NSString stringWithFormat:@"%@/api/drivingMemberApply/apply_driving_features_eat",WLHTTP]
/*管家查看自驾吃明细*/
#define KeeperDriveDetail [NSString stringWithFormat:@"%@/api/drivingAssistant/get_assistant_list_income",WLHTTP]
/*自驾吃 --- 商铺订单列表*/
#define M_URL_DE_ORDER_LIST [NSString stringWithFormat:@"%@/api/orderApi/orderList",WLHTTP]
/*自驾吃 --- 订单详情*/
#define M_URL_DE_ORDER_DETAIL [NSString stringWithFormat:@"%@/api/orderApi/orderInfo",WLHTTP]
/*自驾吃 --- 接单*/
#define M_URL_DE_ORDER_RECEIVING [NSString stringWithFormat:@"%@/api/orderApi/newConfirmOrder",WLHTTP]
/*自驾吃 --- 拒单*/
#define M_URL_DE_ORDER_REJECYING [NSString stringWithFormat:@"%@/api/orderApi/newCancelOrder",WLHTTP]
/*自驾吃 --- 延期*/
#define M_URL_DE_ORDER_POSTPONE [NSString stringWithFormat:@"%@/api/orderApi/orderDelay",WLHTTP]
///*自驾吃 --- 销单*/
//#define M_URL_DE_ORDER_DETAIL [NSString stringWithFormat:@"%@/api/orderApi/orderInfo",WLHTTP]

/*自驾吃 --- 客户端页面*/
#define GetHomePageUrl [NSString stringWithFormat:@"%@/api/drivingApi/get_driving_features_index_list",WLHTTP]
/*自驾吃 --- 店铺展示页面*/
#define RestauantUrl [NSString stringWithFormat:@"%@/api/drivingApi/get_driving_features_product_list",WLHTTP]
/*自驾吃 --- 店家详情*/
#define ShopDetailUrl [NSString stringWithFormat:@"%@/api/drivingApi/get_driving_shop_info",WLHTTP]
/*自驾吃 --- 菜单页面详情*/
#define DishDetailUrl [NSString stringWithFormat:@"%@/api/drivingApi/get_driving_features_product_info",WLHTTP]
/*自驾吃 --- 订单详情*/
#define EatOrderDetailUrl [NSString stringWithFormat:@"%@/api/orderApi/orderInfo",WLHTTP]
/*自驾吃 --- 取消订单接口*/
#define EatCancelUrl [NSString stringWithFormat:@"%@/api/orderApi/newCancelOrder",WLHTTP]
/*自驾吃 --- 订单评价接口*/
#define EatCommentUrl [NSString stringWithFormat:@"%@/api/drivingApi/save_memeber_shop_appraise",WLHTTP]

/*自驾吃 --- 消费券接口*/
#define EatCustomerTicketUrl [NSString stringWithFormat:@"%@/api/drivingApi/get_driving_eat_ticket",WLHTTP]
/*自驾吃 --- 二维码*/
#define Quickmark  [NSString stringWithFormat:@"%@/api/qrcodeApi/driving_ticket_qrcode",WLHTTP]
/*自驾吃 --- 提交订单接口*/
#define EatPostOrderUrl [NSString stringWithFormat:@"%@/api/orderApi/newPostOrder",WLHTTP]

/*自驾吃 --- 个人中心订单接口*/
#define EatMineOrderUrl [NSString stringWithFormat:@"%@/api/orderApi/orderList",WLHTTP]

/*获取会员资料*/
//参数：uid
#define M_URL_MERBER_INFOR [NSString stringWithFormat:@"%@/api/ajaxMember/get_info",WLHTTP]

/*登录校验*/
/*
 username 登录用户名
 password 登录密码
 usergroup 用户角色
 */
#define M_URL_CHECK_LOGIN [NSString stringWithFormat:@"%@/api/assistant/check_login",WLHTTP]

/*管家部落扫描二维码URL*/
#define GET_ASSISTANT_SHOP_QRCODE_URL(houseId)  [NSString stringWithFormat:@"%@/api/qrcodeApi/store_qr/%@",WLHTTP,houseId]

/*管家部落分享跳转URL*/
#define REGISTER_ASSISTANT_SHOP_URL(houseId)  [NSString stringWithFormat:@"%@/assistant/assistant/assistant_index/%@",WLHTTP,houseId]

/*合伙人部落分享跳转URL*/
#define REGISTER_PARTANT_SHOP_URL(houseId)  [NSString stringWithFormat:@"%@/assistant/assistant/partner_index/%@",WLHTTP,houseId]

/*产品详情 分享跳转URL*/
#define GET_PRODUCT_DETAIL_SHARE_URL [NSString stringWithFormat:@"%@/api/share/getShareUrl",WLHTTP]

#endif
//YES:检测更新
//NO：不检查更新
#define isCheckUpage              @"YES"
//1：立即更新
//2：可选更新
#define ForceUpdate                @"1"
#define WeiLvAppID                 @"990860767"
#define WeiLvAppName               @"微旅管家"
#define WeiLvAlertViewTitle        @"检查更新"
#define WeiLvCancelButtonTitle     @"稍后更新"
#define WeiLvUpdateButtonTitle     @"立即更新"

//检测PC端版本
#define CHECK_PC_VERSION_URL [NSString stringWithFormat:@"%@/api/listener/status_report",WLHTTP]

//友盟iOS版APPKEY
#define UMENG_APPKEY @"5690a05167e58e8bcc00335d"

//获取当前APP版本号
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/*个人中心 --- 提现页面*/
#define get_bank_by_card_Url [NSString stringWithFormat:@"%@/api/withdrawal/get_bank_by_card",WLHTTP]

/*个人账户资金*/
#define get_own_money_Url    [NSString stringWithFormat:@"%@/api/withdrawal/get_own_money",WLHTTP]

/*弧度转角度*/
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

/*角度转弧度*/
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

/*提现历史页面*/
#define get_withdrawals_list  [NSString stringWithFormat:@"%@/api/withdrawal/get_withdrawals_list",WLHTTP]
/*提现申请页面*/
#define apply_withdrawals  [NSString stringWithFormat:@"%@/api/withdrawal/apply_withdrawals",WLHTTP]
/*绑定 解绑银行卡*/
#define modify_bank_card    [NSString stringWithFormat:@"%@/api/withdrawal/modify_bank_card",WLHTTP]
/*是否显示提现*/
#define get_visit_allow     [NSString stringWithFormat:@"%@/api/withdrawal/get_visit_allow",WLHTTP]
/*获取已绑定银行卡列表 */
#define get_card_list    [NSString stringWithFormat:@"%@/api/withdrawal/get_card_list",WLHTTP]

/*忘记密码—获取验证码*/
#define ForgetPwdGetPwd  [NSString stringWithFormat:@"%@/api/assistant/check_phone",WLHTTP]

/*判断验证码是否正确*/
#define JudgeAuthCode  [NSString stringWithFormat:@"%@/api/assistant/check_code",WLHTTP]

/*判断修改密码*/
#define JudgeNewPwd  [NSString stringWithFormat:@"%@/api/assistant/change_pwd",WLHTTP]

/*删除合伙人*/
#define DeletePanter_Url   [NSString stringWithFormat:@"%@/api/assistant/cancel_partner",WLHTTP]

#define zxdIdtoCityUrl [NSString stringWithFormat:@"%@/api/assistant/code_or_name",WLHTTP]//城市id和姓名互转
#define zxdTourEdittUrl [NSString stringWithFormat:@"%@/api/assistant/edit_visitor",WLHTTP]
#define zxdTourAddtUrl [NSString stringWithFormat:@"%@/api/assistant/add_visitor",WLHTTP]
#define zxdTourdelectUrl [NSString stringWithFormat:@"%@/api/assistant/delete_visitor",WLHTTP]
#define zxdTourUrl [NSString stringWithFormat:@"%@/api/assistant/add_visitor",WLHTTP]    //常用游客资料
#define zxddelectMemberUrl [NSString stringWithFormat:@"%@/api/assistant/delete_member_tag",WLHTTP]
#define zxdAddMemberUrl [NSString stringWithFormat:@"%@/api/assistant/member_tag",WLHTTP]

/*管家*/
#define zxdIdtoCityUrl [NSString stringWithFormat:@"%@/api/assistant/code_or_name",WLHTTP]//城市id和姓名互转
#define zxdTourEdittUrl [NSString stringWithFormat:@"%@/api/assistant/edit_visitor",WLHTTP]
#define zxdTourAddtUrl [NSString stringWithFormat:@"%@/api/assistant/add_visitor",WLHTTP]
#define zxdTourdelectUrl [NSString stringWithFormat:@"%@/api/assistant/delete_visitor",WLHTTP]
#define zxdTourUrl [NSString stringWithFormat:@"%@/api/assistant/add_visitor",WLHTTP]    //常用游客资料
#define zxddelectMemberUrl [NSString stringWithFormat:@"%@/api/assistant/delete_member_tag",WLHTTP]
#define zxdAddMemberUrl [NSString stringWithFormat:@"%@/api/assistant/member_tag",WLHTTP]


/*目的地参团*/
//调取地区接口
#define DESTINATION_TYPE_DETAIL_URL(type, areaId, assistantId, page) [NSString stringWithFormat:@"%@/api/destination/index?type=%li&area_id=%li&assistant_id=%i&offset=%li", WLHTTP, type, areaId, assistantId, page]

//调取“目的地旅游”和“目的地游轮”区头接口，返回全部“旅游”或者“游轮”数据
#define DESTINATION_TYPE_ALL_URL(type,assistantId,page) [NSString stringWithFormat:@"%@/api/destination/index?type=%li&assistant_id=%i&offset=%li", WLHTTP, type,assistantId,page]

//搜索后，带有搜索地址的接口，返回该城市地区的数据
#define DESTINATION_SEARCH_URL(type,assistantId,dname) [NSString stringWithFormat:@"%@/api/destination/index?type=%li&assistant_id=%i&d_name=%@", WLHTTP, type,assistantId,dname]

//目的地参团-筛选城市地址
#define DESTINATION_CITY_URL [NSString stringWithFormat:@"%@/api/destination/d_citys",WLHTTP]


/*清理用户名相同登录的冗余数据*/
#define CLEAN_SAME_USERNAME_RUL [NSString stringWithFormat:@"%@/front/member/upgrade?AType=ios",WLHTTP]

/*各模块分享产品详情*/

//签证分享链接
#define VISAS_SHARE_URL(parm) [NSString stringWithFormat:@"%@/front/visas/content?product_id=%@",WXHTTP,parm]

//门票分享链接
#define TICKET_SHARE_URL(parm) [NSString stringWithFormat:@"%@/front/ticket/content?productid=%@",WXHTTP,parm]

//邮轮分享链接
#define CRUIS_SHARE_URL(parm) [NSString stringWithFormat:@"%@/front/cruise/cruise_detail/%@",WXHTTP,parm]

//游学分享链接
#define YOOSURE_SHARE_URL(parm) [NSString stringWithFormat:@"%@/front/yoosure/detail/%@",WXHTTP,parm]

//旅游度假分享链接
#define TRAVEL_SHARE_URL(parm) [NSString stringWithFormat:@"%@/front/newtravel/detail/%@",WXHTTP,parm]

/*邮轮新版4.2  3月16日*/
//邮轮 --- 详情URL
#define M_URL_SHIP_PRODUCT_DETAIL  [NSString stringWithFormat:@"%@/api/cruisenew/product",WLHTTP]



