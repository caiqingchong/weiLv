//
//  JYCorderDishesCell.h
//  WelLv
//
//  Created by lyx on 15/11/12.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestauantModel.h"



@interface JYCorderDishesCell : UITableViewCell
typedef void(^ChooseBlock)(int totolNumeBer,RestauantModel *model,NSIndexPath *indexPath2);

@property(nonatomic,strong)UILabel *dishNameLabel;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)UILabel *salesLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *originPriceLabel;
@property(nonatomic,strong)UIButton *minusBtn;
@property(nonatomic,strong)UIButton *plusBtn;
@property(nonatomic,strong)UILabel *totaleNumebr;
@property(nonatomic,strong)NSIndexPath *index;
@property(nonatomic,assign) int total;
@property(nonatomic,strong)NSMutableArray *arry;
@property(nonatomic,strong)ChooseBlock cellBlock;
@property(nonatomic,strong)RestauantModel *model;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
