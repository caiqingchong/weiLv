//
//  MyOrderTableViewCell.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyOrderModel;
@interface MyOrderTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *leftImageView;
@property (nonatomic,strong)UILabel *titleLab; //标题
@property (nonatomic,strong)UILabel *NumberLab;//出行人数
@property (nonatomic,strong)UILabel *priceLab;//总价
@property (nonatomic,strong)UILabel *orderStateLab;//订单状态
@property (nonatomic,strong)UILabel *catLabel; //分类
@property (nonatomic,strong)UILabel *timeStringLab;//出发日期
@property (nonatomic,strong)UILabel *constactsLab;//联系人
@property (nonatomic,strong)UILabel *phoneLab;//电话

@property (nonatomic,strong)MyOrderModel *item;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
