//
//  PayTopView.h
//  FillOrder
//
//  Created by WeiLv on 16/1/14.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TravelOrderDetailModel;

@interface PayTopView : UIView

@property (nonatomic,strong) UILabel *titleLable;

@property (nonatomic, strong) UILabel *numberLable;

@property (nonatomic, strong) UILabel *cityLable;

@property (nonatomic,strong) UILabel *dateLable;

@property (nonatomic,strong) UILabel *peopleLable;

@property (nonatomic, strong) UILabel *priceLable;

@property (nonatomic, strong) UILabel *countLable;

- (void)assignValueWithModel:(TravelOrderDetailModel *)model;


@end
