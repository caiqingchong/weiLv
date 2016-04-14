//
//  CommissionTableViewCell.h
//  WelLv
//
//  Created by mac for csh on 15/9/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyOrderModel;
@interface CommissionTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *leftImageView;
@property (nonatomic,strong)UILabel *titleLab; //标题
@property (nonatomic,strong)UILabel *catLabel; //分类
@property (nonatomic,strong)UILabel *timeStringLab;//出发日期
@property (nonatomic,strong)UILabel *orderSNLab;//订单号
@property (nonatomic,strong)UILabel *commissionLab;//返佣

@property (nonatomic,strong)MyOrderModel *item;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
