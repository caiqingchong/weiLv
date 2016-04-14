//
//  LXSTListCell.h
//  WelLv
//
//  Created by 刘鑫 on 15/8/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXSTListModel;
@interface LXSTListCell : UITableViewCell
@property (nonatomic,strong)UIImageView *leftImageView;
@property (nonatomic,strong)UILabel *nameLab;
@property (nonatomic,strong)UILabel *priceLab;
@property (nonatomic,strong)UILabel *infoLab;
@property (nonatomic,strong)UILabel *gj_commissionLab;//返佣
@property (nonatomic,strong)UILabel *lastestDate;//最近发团日期

@property (nonatomic,strong)LXSTListModel *model;
@end
