//
//  BaseTableViewCell.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/3.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseCellModel;
@interface BaseTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *leftImageView;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *nameLab;
@property (nonatomic,strong)UIImageView *soldNumberImage;//出售份数图片
@property (nonatomic,strong)UILabel *soldNumberLab;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)UIImageView *gradeImage;//评分图片
@property (nonatomic,strong)UILabel *gradeLab;

@property (nonatomic,strong)BaseCellModel *item;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
