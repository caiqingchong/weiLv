//
//  TopView.h
//  TraveDetail
//
//  Created by WeiLv on 16/1/11.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SDCycleScrollView.h"
@class ProductModel;
@interface TopView : UIView


//轮播图
@property (nonatomic,strong) SDCycleScrollView *cycle;
//标题
@property (nonatomic,strong) UILabel *titleLable;
//标签
@property (nonatomic,strong) UILabel *markLable;
@property (nonatomic,strong) UIImageView *markImage;
//微旅价
@property (nonatomic,strong) UILabel *priceLable;
//返佣
@property (nonatomic, strong) UILabel *commissionLable;
//编号
@property (nonatomic,strong) UILabel *numberLable;
//提供方
@property (nonatomic,strong) UILabel *offerLable;
//许可证
@property (nonatomic,strong) UILabel *businesslicLable;
//最近团期
@property (nonatomic,strong) UILabel *newlyLable;
//查看团期
@property (nonatomic,strong) UIButton *button;

@property (nonatomic,strong) UIImageView *moreImage;



//写一个接口为模块上的控件赋值
- (void)assignValueWithModel:(ProductModel *)model;

@end
