//
//  YXDetailTraveViewController.h
//  WelLv
//
//  Created by lyx on 15/4/20.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#import "IamgeAndLabelView.h"
#import "YXTabbarBtn.h"
#import "YXCommitView.h"
#import "YXTraveDetailModel.h"
#import "XCLoadMsg.h"
#import "YXTraveAutoView.h"
#import "TraveCalendarViewController.h"
#import "ZFJImageAndTitleButton.h"
#import "ZFJCallStewardVC.h"
#import "YXHouseModel.h"
#import "YXTopImageView.h"
#import <ShareSDK/ShareSDK.h>

@interface YXDetailTraveViewController : XCSuperObjectViewController<UIWebViewDelegate,UIScrollViewDelegate,YXButtonViewDelegate>
{
    NSArray *_commitArr;
}
@property (nonatomic,strong)YXTopImageView *headerImageVIew;

@property (nonatomic, strong) UIView *callStewardView;//拨打管家列表页面；
@property (nonatomic, strong) UIView *blurView;//模糊页面；
@property (nonatomic,copy)NSString *productId;
@property (nonatomic,copy)NSString *productPrice;
@property (nonatomic,copy)NSString *realBeginDate;//日期开始的第一天
//新添加的判断支付方式
@property (nonatomic, assign) WLOrderSource orderSource;
@property (nonatomic, copy) NSString * store_id;  //管家店铺ID

@end


