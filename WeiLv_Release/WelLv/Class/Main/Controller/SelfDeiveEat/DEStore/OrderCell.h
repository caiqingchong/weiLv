//
//  OrderCell.h
//  WelLv
//
//  Created by liuxin on 15/11/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//
#import "orderModel.h"
#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property(nonatomic,strong) NSIndexPath *indexPath2;
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *dataLabel;
@property(nonatomic,strong)UISwitch *sw;
@property(nonatomic,strong)UIButton *btn;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;



@property(nonatomic,strong)orderModel *model;
//-(void)setModel:(orderModel *)model;
@end
