
//
//  TravelHeaderView.m
//  WelLv
//
//  Created by 张子乾 on 16/1/11.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelHeaderView.h"
#import "TravelAllHeader.h"


//搜索框
#define kSearchLableWidth UISCREEN_WIDTH - 20
#define kSearchLableHeight 30
#define kSearchLableX 10
#define kSearchLabelY 5
//轮播图frame
#define kCarouseImageViewX 0
#define kCarouseImageViewY 0
#define kCarouseImageWidth UISCREEN_WIDTH
#define kCarouseImageHeight 200
//项目宽度
#define kItemGapWidth 10
#define kItemY CGRectGetMaxY(_travelCycleScrollView.frame)+UISCREEN_HEIGHT/(UISCREEN_HEIGHT/15)
#define kItemWidth (UISCREEN_WIDTH - (kItemGapWidth * 6)) / 5
#define kItemHeight (UISCREEN_WIDTH - (kItemGapWidth * 6)) / 5



@implementation TravelHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self layoutViews];
    }
    return self;
}

//视图布局方法
- (void)layoutViews {
    
    //轮播图
    if (UISCREEN_HEIGHT < 667) {
    _travelCycleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(kCarouseImageViewX, kCarouseImageViewY, kCarouseImageWidth, 160)];
    } else {
    _travelCycleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(kCarouseImageViewX, kCarouseImageViewY, kCarouseImageWidth, kCarouseImageHeight)];
    }
    
//    _travelCycleScrollView.backgroundColor = [UIColor blueColor];
    _travelCycleScrollView.showsHorizontalScrollIndicator = YES;
    [self addSubview:_travelCycleScrollView];
    
    //项目
    //周边游
    _aroundTravelImageView = [[UIImageView alloc]initWithFrame:CGRectMake( kSearchLableX, kItemY, kItemWidth, kItemHeight)];
//    _aroundTravelImageView.backgroundColor = [UIColor redColor];
    _aroundTravelImageView.layer.masksToBounds = YES;
    _aroundTravelImageView.layer.cornerRadius = kItemWidth / 4;
    _aroundTravelImageView.image = [UIImage imageNamed:@"_周边游"];
    [self addSubview:_aroundTravelImageView];
    
    _aroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_aroundTravelImageView.frame) + 5, CGRectGetMaxY(_aroundTravelImageView.frame) + 10, kItemTitleLabelWidth, kItemTitleLabelHeight)];
//    _aroundLabel.backgroundColor = [UIColor blackColor];
    _aroundLabel.textAlignment = NSTextAlignmentCenter;
    if (UISCREEN_HEIGHT < 667) {
        _aroundLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle5];
    } else {
        _aroundLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle];
    }
    [self addSubview:_aroundLabel];
    
    
    //国内游
    _domestictravelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_aroundTravelImageView.frame) + kItemGapWidth, kItemY, kItemWidth, kItemHeight)];
//    _domestictravelImageView.backgroundColor = [UIColor greenColor];
    _domestictravelImageView.layer.masksToBounds = YES;
    _domestictravelImageView.layer.cornerRadius = kItemWidth / 4;
    _domestictravelImageView.image = [UIImage imageNamed:@"_国内游"];
    [self addSubview:_domestictravelImageView];
    
    _domesticLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_domestictravelImageView.frame) + 5, CGRectGetMaxY(_domestictravelImageView.frame) + 10, kItemTitleLabelWidth, kItemTitleLabelHeight)];
//    _domesticLabel.backgroundColor = [UIColor blackColor];
    _domesticLabel.textAlignment = NSTextAlignmentCenter;
    _domesticLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle];
    if (UISCREEN_HEIGHT < 667) {
        _domesticLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle5];
    } else {
        _domesticLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle];
    }
    [self addSubview:_domesticLabel];
    
    //港澳台
    _HMTTravelImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_domestictravelImageView.frame) + kItemGapWidth, kItemY, kItemWidth, kItemHeight)];
//    _HMTTravelImageView.backgroundColor = [UIColor cyanColor];
    _HMTTravelImageView.layer.masksToBounds = YES;
    _HMTTravelImageView.layer.cornerRadius = kItemWidth / 4;
    _HMTTravelImageView.image = [UIImage imageNamed:@"_港澳台"];
    [self addSubview:_HMTTravelImageView];
    
    _HMTTravelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_HMTTravelImageView.frame) + 5, CGRectGetMaxY(_HMTTravelImageView.frame) + 10, kItemTitleLabelWidth, kItemTitleLabelHeight)];
//    _HMTTravelLabel.backgroundColor = [UIColor blackColor];
    _HMTTravelLabel.textAlignment = NSTextAlignmentCenter;
    _HMTTravelLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle];
    if (UISCREEN_HEIGHT < 667) {
        _HMTTravelLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle5];
    } else {
        _HMTTravelLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle];
    }
    [self addSubview:_HMTTravelLabel];
    
    //出境游
    _exitTravel = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_HMTTravelImageView.frame) + kItemGapWidth, kItemY, kItemWidth, kItemHeight)];
//    _exitTravel.backgroundColor = [UIColor purpleColor];
    _exitTravel.image = [UIImage imageNamed:@"_出境游"];
    _exitTravel.layer.masksToBounds = YES;
    _exitTravel.layer.cornerRadius = kItemWidth / 4;
    
    [self addSubview:_exitTravel];
    
    _exitLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_exitTravel.frame) + 5, CGRectGetMaxY(_exitTravel.frame) + 10, kItemTitleLabelWidth, kItemTitleLabelHeight)];
//    _exitLabel.backgroundColor = [UIColor blackColor];
    _exitLabel.textAlignment = NSTextAlignmentCenter;
    _exitLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle];
    if (UISCREEN_HEIGHT < 667) {
        _exitLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle5];
    } else {
        _exitLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle];
    }
    [self addSubview:_exitLabel];
    
    //境外参团
    _exitTouristGroup = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_exitTravel.frame) + kItemGapWidth, kItemY, kItemWidth, kItemHeight)];
//    _exitTouristGroup.backgroundColor = [UIColor yellowColor];
    _exitTouristGroup.layer.masksToBounds = YES;
    _exitTouristGroup.image = [UIImage imageNamed:@"_境外参团"];
    _exitTouristGroup.layer.cornerRadius = kItemWidth /4;
    [self addSubview:_exitTouristGroup];
    
    _exitTouristGroupLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_exitTouristGroup.frame), CGRectGetMaxY(_exitTouristGroup.frame) + 10, kItemTitleLabelWidth + 10, kItemTitleLabelHeight)];
//    _exitTouristGroupLabel.backgroundColor = [UIColor blackColor];
    _exitTouristGroupLabel.textAlignment = NSTextAlignmentCenter;
    _exitTouristGroupLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle];
    if (UISCREEN_HEIGHT < 667) {
        _exitTouristGroupLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle5];
    } else {
        _exitTouristGroupLabel.font = [UIFont systemFontOfSize:kTravelProductItemTitle];
    }
    
    
    [self addSubview:_exitTouristGroupLabel];
    
}



@end
