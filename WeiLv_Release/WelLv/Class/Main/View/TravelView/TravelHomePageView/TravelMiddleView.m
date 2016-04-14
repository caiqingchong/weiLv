
//
//  TravelMiddleView.m
//  WelLv
//
//  Created by 张子乾 on 16/1/11.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelMiddleView.h"
#import "TravelAllHeader.h"
#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height



#define kProuductLabelHeight 20
#define kItemImageViewWidth 249 / 2 - 20
#define kItemImageViewHeight 60


@implementation TravelMiddleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutAllViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//配置所有视图
- (void)layoutAllViews {
    //    NSInteger *firstX;
    //    NSInteger *secondX;
    //    NSInteger *thirdX;
    NSInteger littleLabelY;
    if (UISCREEN_HEIGHT == 568) {
        littleLabelY = 5;
    } else {
        littleLabelY = 7;
    }
    
    
    
    //第一个
    
    _firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kTravelRecommendBigTitleY, UISCREEN_WIDTH/3, kTravelRecommendBigTitleHeight)];
    //    _firstLabel.textColor = [UIColor cyanColor];
    if (UISCREEN_HEIGHT < 667) {
        _firstLabel.font = [UIFont systemFontOfSize:kTravelRecommendBigTitleHeight5];
    } else {
        _firstLabel.font = [UIFont systemFontOfSize:kTravelRecommendBigTitleHeight];
    }
    _firstLabel.text = @"微旅推荐";
    _firstLabel.textColor = UIColorFromRGB(0xff5b76);
    _firstLabel.userInteractionEnabled = YES;
    _firstLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_firstLabel];
    
    _firstLittleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_firstLabel.frame) + littleLabelY, kTravelRecommendLittleTitleWidth, kTravelRecommendBigTitleHeight)];
    _firstLittleLabel.text = @"性价之王";
    _firstLittleLabel.textAlignment = NSTextAlignmentCenter;
    _firstLittleLabel.textColor = UIColorFromRGB(0x6f7378);
    //    _firstLittleLabel.backgroundColor = [UIColor yellowColor];
    if (UISCREEN_HEIGHT < 667) {
        _firstLittleLabel.font = [UIFont systemFontOfSize:kTravelRecommendLittleTitle5];
    } else {
        _firstLittleLabel.font = [UIFont systemFontOfSize:kTravelRecommendLittleTitle];
    }
    _firstLittleLabel.userInteractionEnabled = YES;
    [self addSubview:_firstLittleLabel];
    
    
    if (UISCREEN_HEIGHT < 667) {
        _firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake( kProuductRecommendGiftX + 10, CGRectGetMaxY(_firstLittleLabel.frame) + 7, kProuductRecommendGiftWidth5, kProuductRecommendGiftHeight5)];
    } else {
        _firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake( kProuductRecommendGiftX , CGRectGetMaxY(_firstLittleLabel.frame) + 7, kProuductRecommendGiftWidth, kProuductRecommendGiftHeight)];
    }
    _firstImageView.image = [UIImage imageNamed:@"礼物"];
    _firstImageView.userInteractionEnabled = YES;
    
    [self addSubview:_firstImageView];
    
    //第一条竖线
    _firstLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(kTravelRecommendLineX, 0, 1, kTravelRecommendHeight)];
    _firstLineLabel.backgroundColor = BgViewColor;
    [self addSubview:_firstLineLabel];
    
    
    //第二个
    _secondlabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/3, kTravelRecommendBigTitleY, UISCREEN_WIDTH/3, kTravelRecommendBigTitleHeight)];
    //    _secondlabel.backgroundColor = [UIColor cyanColor];
    _secondlabel.font = [UIFont systemFontOfSize:kTravelRecommendBigTitleHeight];
    _secondlabel.text = @"踏青登山";
    _secondlabel.textColor = UIColorFromRGB(0x15cb84);
    _secondlabel.textAlignment = NSTextAlignmentCenter;
    if (UISCREEN_HEIGHT < 667) {
        _secondlabel.font = [UIFont systemFontOfSize:kTravelRecommendBigTitleHeight5];
    } else {
        _secondlabel.font = [UIFont systemFontOfSize:kTravelRecommendBigTitleHeight];
    }
    _secondlabel.userInteractionEnabled = YES;
    [self addSubview:_secondlabel];
    
    _secondLittleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kTravelRecommendLittleTitleWidth, CGRectGetMaxY(_secondlabel.frame) + littleLabelY, kTravelRecommendLittleTitleWidth, kTravelRecommendLittleTitleHeight)];
    _secondLittleLabel.text = @"春游好去处";
    _secondLittleLabel.textAlignment = NSTextAlignmentCenter;
    _secondLittleLabel.textColor = UIColorFromRGB(0x6f7378);
    _secondLittleLabel.font = [UIFont systemFontOfSize:kTravelRecommendLittleTitle];
    if (UISCREEN_HEIGHT < 667) {
        _secondLittleLabel.font = [UIFont systemFontOfSize:kTravelRecommendLittleTitle5];
    } else {
        _secondLittleLabel.font = [UIFont systemFontOfSize:kTravelRecommendLittleTitle];
    }
    //    _secondLittleLabel.backgroundColor = [UIColor yellowColor];
    _secondLittleLabel.userInteractionEnabled = YES;
    [self addSubview:_secondLittleLabel];
    
    
    
    if (UISCREEN_HEIGHT < 667) {
        _secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kTravelRecommendSkiingX + 10, CGRectGetMaxY(_secondLittleLabel.frame) + 8, kTravelRecommendSkiingWidth5, kTravelRecommendSkiingHeight5)];
    } else {
        _secondImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kTravelRecommendSkiingX, CGRectGetMaxY(_secondLittleLabel.frame) + 8, kTravelRecommendSkiingWidth, kTravelRecommendSkiingHeight)];
        
    }
    _secondImageView.image = [UIImage imageNamed:@"踏青登山"];
    _secondImageView.userInteractionEnabled = YES;
    [self addSubview:_secondImageView];
    
    
    //第二条竖线
    _secondLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(kTravelRecommendLineX * 2 , 0, 1, kTravelRecommendHeight)];
    _secondLineLabel.backgroundColor = BgViewColor;
    [self addSubview:_secondLineLabel];
    
    
    //第三个
    _thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/3*2, kTravelRecommendBigTitleY, UISCREEN_WIDTH/3, kTravelRecommendBigTitleHeight)];
    _thirdLabel.font = [UIFont systemFontOfSize:kTravelRecommendBigTitleHeight];
    //    _thirdLabel.backgroundColor = [UIColor cyanColor];
    _thirdLabel.textColor = UIColorFromRGB(0x6ab216);
    _thirdLabel.textAlignment = NSTextAlignmentCenter;
    _thirdLabel.text = @"海岛假期";
    if (UISCREEN_HEIGHT < 667) {
        _thirdLabel.font = [UIFont systemFontOfSize:kTravelRecommendBigTitleHeight5];
    } else {
        _thirdLabel.font = [UIFont systemFontOfSize:kTravelRecommendBigTitleHeight];
    }
    _thirdLabel.userInteractionEnabled = YES;
    [self addSubview:_thirdLabel];
    
    _thirdLittleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kTravelRecommendLittleTitleWidth*2, CGRectGetMaxY(_thirdLabel.frame) + littleLabelY, kTravelRecommendLittleTitleWidth, kTravelRecommendLittleTitleHeight)];
    _thirdLittleLabel.text = @"优选全球海岛";
    _thirdLittleLabel.textAlignment = NSTextAlignmentCenter;
    _thirdLittleLabel.textColor = UIColorFromRGB(0x6f7378);
    _thirdLittleLabel.font = [UIFont systemFontOfSize:kTravelRecommendLittleTitle];
    //    _thirdLittleLabel.backgroundColor = [UIColor yellowColor];
    if (UISCREEN_HEIGHT < 667) {
        _thirdLittleLabel.font = [UIFont systemFontOfSize:kTravelRecommendLittleTitle5];
    } else {
        _thirdLittleLabel.font = [UIFont systemFontOfSize:kTravelRecommendLittleTitle];
    }
    _thirdLittleLabel.userInteractionEnabled = YES;
    [self addSubview:_thirdLittleLabel];
    
    if (UISCREEN_HEIGHT < 667) {
        _thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_thirdLittleLabel.frame)+10, CGRectGetMaxY(_thirdLittleLabel.frame)+ 19, kTravelRecommendIslandWidth5, kTravelRecommendIslandHeight5)];
    } else if(UISCREEN_HEIGHT == 667)
    {
        _thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_thirdLittleLabel.frame)+10, CGRectGetMaxY(_thirdLittleLabel.frame)+18, kTravelRecommendIslandWidth, kTravelRecommendIslandHeight)];
    } else {
        _thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_thirdLittleLabel.frame)+20, CGRectGetMaxY(_thirdLittleLabel.frame)+18, kTravelRecommendIslandWidth, kTravelRecommendIslandHeight)];
    }
    _thirdImageView.userInteractionEnabled = YES;
    _thirdImageView.image = [UIImage imageNamed:@"海岛假日"];
    [self addSubview:_thirdImageView];
    
}



@end
