//
//  backGroundCell.h
//  WelLv
//
//  Created by lyx on 15/11/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestauantModel.h"

@interface backGroundCell : UITableViewCell

typedef void(^cellBlock)(NSIndexPath *indexPath3,int tota,RestauantModel *model);
@property(nonatomic,strong)UILabel *dishNameLabel;
@property(nonatomic,strong)UIImageView *leftImage;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *minusBtn;
@property(nonatomic,strong)UIButton *plusBtn;
@property(nonatomic,strong)UILabel *totaleNumebr;
@property(nonatomic,assign) int total;
@property(nonatomic,strong)RestauantModel *model;
//@property(nonatomic,assign)NSIndexPath *index;
@property(nonatomic,strong)cellBlock cellBlock2;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
