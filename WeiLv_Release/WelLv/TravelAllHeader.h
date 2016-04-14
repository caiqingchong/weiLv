

//
//  TravelAllHeader.h
//  WelLv
//
//  Created by 张子乾 on 16/1/13.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#ifndef TravelAllHeader_h
#define TravelAllHeader_h




//头文件
#import "TravelHeaderView.h"
#import "TravelMiddleView.h"
#import "TravelBoutiqueLineView.h"
#import "TravelBoutiqueLineView.h"
#import "BoutiqueLineTableViewCell.h"
#import "TravelHomePageCycleImageModel.h"
#import "TravelJPLineModel.h"
#import "SDCycleScrollView.h"
#import "BoutiqueTableViewController.h"
#import "TravelNoticeTableViewCell.h"
#import "TravelViewController.h"
#import "FillOrderViewController.h"



//旅游首页相关地址

#define LYHomePageURL [NSString stringWithFormat:@"%@/api/newtravel/index?city_id=",WLHTTP]



//轮播图高度
#define kCycleImageHeight  UISCREEN_HEIGHT/(UISCREEN_HEIGHT/200)
//背景视图高度
#define kBackViewSizeHeight6 UISCREEN_HEIGHT*3+135-100
#define kBackViewSizeHeight6p UISCREEN_HEIGHT*3-70-100
#define kBackViewSizeHeight5 UISCREEN_HEIGHT*4-210-100
#define kBackViewSizeHeight4 UISCREEN_HEIGHT*4+50


/**
 *产品列表
 */

//项目分块
#define kTraverProductItemHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/315)
#define kTraverProductItemHeight5 UISCREEN_HEIGHT/(UISCREEN_HEIGHT/255)
//产品名称字体大小
#define kTravelProductItemTitle UISCREEN_HEIGHT/(UISCREEN_HEIGHT/14)
#define kTravelProductItemTitle5 UISCREEN_HEIGHT/(UISCREEN_HEIGHT/13)
//产品列表字体大小
//产品名称x
#define kkTravelProductItemLabelx UISCREEN_WIDTH/5
#define kItemTitleLabelWidth kItemWidth-10
#define kItemTitleLabelHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/15)



/**
 *推荐模块
 */

#define kTravelRecommendHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/140)
#define kTravelRecommendHeight5 UISCREEN_HEIGHT/(UISCREEN_HEIGHT/120)
#define kTravelRecommendBigTitleHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/15)


//三个大标题的x
#define kTravelRecommendFirstTitleX UISCREEN_WIDTH / 12
#define kTravelRecommendSecondBigTitleX UISCREEN_WIDTH / 3 + UISCREEN_WIDTH / 12
#define kTravelRecommendThirdBigTitleX UISCREEN_WIDTH / 3 * 2 + UISCREEN_WIDTH / 12
//三个大标题的Y
#define kTravelRecommendBigTitleY UISCREEN_HEIGHT/(UISCREEN_HEIGHT/15)
//三个大标题的宽
#define kTravelRecommendBigTitleWidth UISCREEN_WIDTH / 6
//三个大标题的高
#define kTravelRecommendBigTitleHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/15)
#define kTravelRecommendBigTitleHeight5 UISCREEN_HEIGHT/(UISCREEN_HEIGHT/13)
//大标题的文字大小
#define kTravelRecommendBigTitle UISCREEN_HEIGHT/(UISCREEN_HEIGHT/15)



//三个小标题的x
#define kTravelRecommendFirstLilteTitleX UISCREEN_WIDTH / 12
#define kTravelRecommendSecondLilteTitleX UISCREEN_WIDTH / 3 + UISCREEN_WIDTH / 12
#define kTravelRecommendThirdLilteTitleX UISCREEN_WIDTH / 3 * 2 + UISCREEN_WIDTH / 12
//三个小标题的y
#define kTravelRecommendLittleTitleY UISCREEN_HEIGHT/(UISCREEN_HEIGHT/15) + 10
//三个小标题文字的大小
#define kTravelRecommendLittleTitle UISCREEN_HEIGHT/(UISCREEN_HEIGHT/12)
#define kTravelRecommendLittleTitle5 10
//三个小标题的宽
#define kTravelRecommendLittleTitleWidth UISCREEN_WIDTH / 3
//三个小标题的高
#define kTravelRecommendLittleTitleHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/12)


//第一张图片x
#define kProuductRecommendGiftX UISCREEN_WIDTH/6 - kProuductRecommendGiftWidth/2
//第一张图片宽
#define kProuductRecommendGiftWidth UISCREEN_WIDTH/(UISCREEN_WIDTH/75)
#define kProuductRecommendGiftWidth5 UISCREEN_WIDTH/(UISCREEN_WIDTH/55)
//第一张图片高
#define kProuductRecommendGiftHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/80)
#define kProuductRecommendGiftHeight5 UISCREEN_HEIGHT/(UISCREEN_HEIGHT/60)


//第二张图x
#define kTravelRecommendSkiingX UISCREEN_WIDTH/2 - kTravelRecommendSkiingWidth/2
//第二张图片宽
#define kTravelRecommendSkiingWidth UISCREEN_WIDTH/(UISCREEN_WIDTH/121)
#define kTravelRecommendSkiingWidth5 UISCREEN_WIDTH/(UISCREEN_WIDTH/100)
//第二张图片高
#define kTravelRecommendSkiingHeight  UISCREEN_HEIGHT/(UISCREEN_HEIGHT/81)
#define kTravelRecommendSkiingHeight5  UISCREEN_HEIGHT/(UISCREEN_HEIGHT/60)

//第三张图x
#define kTravelRecommendIslandX (UISCREEN_WIDTH * 5 / 6) - kTravelRecommendIslandWidth/2
//第三张图片宽
#define kTravelRecommendIslandWidth UISCREEN_WIDTH/(UISCREEN_WIDTH/105)
#define kTravelRecommendIslandWidth5 UISCREEN_WIDTH/(UISCREEN_WIDTH/85)
//第三张图片高
#define kTravelRecommendIslandHeight  UISCREEN_HEIGHT/(UISCREEN_HEIGHT/70)
#define kTravelRecommendIslandHeight5  UISCREEN_HEIGHT/(UISCREEN_HEIGHT/50)



#define kTravelRecommendLittleTitleX UISCREEN_HEIGHT/(UISCREEN_HEIGHT/12)



#define kTravelRecommendLineX UISCREEN_WIDTH/3
#define kProuductLabelX UISCREEN_WIDTH / 3 / 4
#define kProuductLabelY UISCREEN_HEIGHT/(UISCREEN_HEIGHT/15)


#define kProuductLabelWidth UISCREEN_WIDTH / 6


//RGB颜色转换
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//宏定义

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

/**
 *关于首页精品路线
 */
//精品线路区头高度
#define kLineSectionHeaderHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/37)
#define kLineTableViewRowHeight 300
//精品线路图片高度
#define kLineImageViewHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/200)
//精品线路标题x
#define kLineTitleLabelX UISCREEN_WIDTH/(UISCREEN_WIDTH/8)
//精品线路标题y
#define kLineTitleLabelY kLineImageViewHeight + UISCREEN_HEIGHT/(UISCREEN_HEIGHT/7.5)
//线路标题字体大小
#define kLineTitleLabelTitleSize UISCREEN_WIDTH/(UISCREEN_WIDTH/16)
#define kLineTitleLabelTitleSize5 UISCREEN_WIDTH/(UISCREEN_WIDTH/15)
//第一个标签的宽度
#define kTagLabelWidth UISCREEN_WIDTH/(UISCREEN_WIDTH/60)
#define kTagLabelWidth5 UISCREEN_WIDTH/(UISCREEN_WIDTH/55)

//第一个标签的高度
#define kTagLabelHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/19)
#define kTagLabelHeight5 UISCREEN_HEIGHT/(UISCREEN_HEIGHT/17)
//微旅价格x
#define kWeiLvPriceLabelX UISCREEN_WIDTH/3*2
#define kWeiLvPriceLabelX5 UISCREEN_WIDTH/3*2 - 30

//微旅价格y
#define kWeiLvPriceLabelY CGRectGetMaxY(_firstTagLabel.frame) + kWeiLvPriceLabelDistance
//微旅价格宽度
#define kWeiLvPriceLabelWidth UISCREEN_WIDTH/(UISCREEN_WIDTH/55)
//微旅价格高度
#define kWeiLvPriceLabelHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/15)
//微旅价格与标签之间的距离
#define kWeiLvPriceLabelDistance UISCREEN_HEIGHT/(UISCREEN_HEIGHT/15)
//微旅价格字体大小
#define kWeiLvPriceLabelTitleSize UISCREEN_HEIGHT/(UISCREEN_HEIGHT/14)
//价格宽度
#define kPriceLabelWidth 80
//价格高度
#define kPriceLabelHeight kWeiLvPriceLabelHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/18)
//价格字体大小
#define kWeiLvPriceLabelSize UISCREEN_HEIGHT/(UISCREEN_HEIGHT/17)
#define kCommissionTitleSize UISCREEN_HEIGHT/(UISCREEN_HEIGHT/16)

//佣金x
#define kCommissionLabelX CGRectGetMaxX(_priceLabel.frame) + UISCREEN_WIDTH/(UISCREEN_WIDTH/10)
//佣金y
#define kCommissionLabelY CGRectGetMinY(_priceLabel.frame)

//标签字体大小
#define kProductTagTextSize UISCREEN_HEIGHT/(UISCREEN_HEIGHT/13)
#define kMoreButtonY 1550

//费用&预定须知
#define kCostDetailWidth UISCREEN_WIDTH - CGRectGetMaxX(self.costTitleLabel.frame)
#define kCostDetailHeight UISCREEN_HEIGHT/(UISCREEN_HEIGHT/60)





#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//背景颜色
#define BgViewColor [UIColor colorWithRed:222/255.0 green:229/255.0 blue:235/255.0 alpha:1]


//zr产品列表接口
#define GUINEILINE [NSString stringWithFormat:@"%@/api/newtravel/getlist",WLHTTP]
#define GUINEILINENOASS(city_id,rote_ID) [NSString stringWithFormat:@"%@/api/newtravel/getlist?city_id=%@&route_type=%@&title=%@",WLHTTP,city_id,rote_ID]
//zr综合接口
#define SORTLINE(city_id,sortstr,rote_ID,assistant_id) [NSString stringWithFormat:@"%@/api/newtravel/getlist?city_id=%@&sort=%@&route_type=%@&assistant_id=%@",WLHTTP,city_id,sortstr,rote_ID,assistant_id]
//zr筛选接口
#define SHAIXUAN [NSString stringWithFormat:@"%@/api/newtravel/getlist",WLHTTP]


//通知书
#define TONGZHISHU [NSString stringWithFormat:@"%@/api/orderApi/getOrderInfo",WLHTTP]
//滑雪
#define WENQUAN [NSString stringWithFormat:@"%@/api/newtravel/getlist?",WLHTTP]
//海岛
#define HAIDAO [NSString stringWithFormat:@"%@/api/newtravel/getlist",WLHTTP]

// 目的地接口
#define DESTIONATUION [NSString stringWithFormat:@"%@/api/newtravel/get_t_citys",WLHTTP]
//供通知书下载
#define DOWNLOAD [NSString stringWithFormat:@"%@/api/newtravel/notice_detail",WLHTTP]

#define DESTIONATUION [NSString stringWithFormat:@"%@/api/newtravel/get_t_citys",WLHTTP]

//订单详情

#define ORDERS [NSString stringWithFormat:@"%@/api/orderApi/getOrderInfo",WLHTTP]
//上传服务器ID
#define POSTID [NSString stringWithFormat:@"%@/newtravel/notice/downword",WLHTTP]
// 下载通知书
#define DOWN [NSString stringWithFormat:@"%@/admin/platform/notice%@.doc",WLHTTP,order_id]
// 通知书状态
#define STATUS [NSString stringWithFormat:@"%@/api/orderApi/getOrderInfo",WLHTTP]


//产品详情 接口
#define PRODUCT_DETAIL_NET [NSString stringWithFormat:@"%@/api/newtravel/detail?pid=",WLHTTP]

//收藏与取消收藏接口
#define COLLECT_NET [NSString stringWithFormat:@"%@/api/newtravel/add_attention",WLHTTP]

/**
 *旅游相关
 */
//提交订单接口
#define kTravelPostOrderUrl [NSString stringWithFormat:@"%@/api/orderApi/postOrder",WLHTTP]
//详情须知
#define kTravelNoctioceUrl [NSString stringWithFormat:@"%@/api/newtravel/detail",WLHTTP]
//订单详情页修改出游人接口
#define kChangeTravelerInfoUrl [NSString stringWithFormat:@"%@/api/Updateperson/update_common_userinfo",WLHTTP]

//出游人列表修改出游人接口
#define kChangeTravelListInfoUrl [NSString stringWithFormat:@"%@/api/member/update_common_userinfo",WLHTTP]
//目的地筛选
#define DESTIONATUION [NSString stringWithFormat:@"%@/api/newtravel/get_t_citys",WLHTTP]
//添加出游人
#define kAddCustomInfoUrl [NSString stringWithFormat:@"%@/api/member/add_tourist_information",WLHTTP]
//常用联系人列表
#define DELEPEOPLE [NSString stringWithFormat:@"%@/api/member/del_userinfo",WLHTTP]

#endif /* TravelAllHeader_h */
