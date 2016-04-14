//
//  AddCostTravelView.h
//  WelLv
//
//  Created by 张子乾 on 16/2/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TravelChangeCountView;
@class ChangeCountView;

@interface AddCostTravelView : UIView
//成人
@property (nonatomic, strong) UILabel *adultLabel;
//成人价格
@property (nonatomic, strong) UILabel *adultPriceLabel;
//儿童
@property (nonatomic, strong) UILabel *childLabel;
//儿童说明
@property (nonatomic, strong) UIImageView *childActionButton;
//儿童价格
@property (nonatomic, strong) UILabel *childPriceLabel;
//成人背景框
@property (nonatomic, strong) TravelChangeCountView *adultNumberbackView;
//儿童背景框
@property (nonatomic, strong) TravelChangeCountView *childNumberBackView;
//减
@property (nonatomic, strong) UIButton *minusButton;
//加
@property (nonatomic, strong) UIButton *addButton;
//数字
@property (nonatomic, strong) UILabel *numberLabel;
//下一步按钮
@property (nonatomic, strong) UIButton *nextStepButton;
//余位
@property (nonatomic, strong) UILabel *costCountLabel;

//黑线
@property (nonatomic, strong) UIView *blackLineView;

//第二条黑线
@property (nonatomic, strong) UIView *secondBlackView;
@end
