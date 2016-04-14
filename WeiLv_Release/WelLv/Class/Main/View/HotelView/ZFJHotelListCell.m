//
//  ZFJHotelListCell.m
//  WelLv
//
//  Created by zhangjie on 15/10/2.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJHotelListCell.h"

#define M_LEFT_WIDTH 15
#define M_TOP_WIDTH 10
#define M_GAP_WIDTH 10
#define M_CELL_HEIGHT 90
#define M_PRICELABEL_HEIGHT 25

@interface ZFJHotelListCell ()

@property (nonatomic, assign) HotelListCellStyle listCellStyle;

@end


@implementation ZFJHotelListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, M_TOP_WIDTH, M_CELL_HEIGHT - M_TOP_WIDTH * 2, M_CELL_HEIGHT - M_TOP_WIDTH * 2)];
    self.iconImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(self.iconImageView) + M_GAP_WIDTH, M_TOP_WIDTH, windowContentWidth - (ViewRight(_iconImageView) + M_GAP_WIDTH), ViewHeight(_iconImageView) / 3)];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_titleLabel), ViewBelow(_titleLabel), ViewWidth(_titleLabel) * 2/ 3, ViewHeight(_iconImageView) - ViewHeight(_titleLabel))];
    self.messageLabel.font = [UIFont systemFontOfSize:12];
    self.messageLabel.textColor = [UIColor grayColor];
    self.messageLabel.numberOfLines = 0;
    [self.contentView addSubview:self.messageLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_messageLabel) + M_GAP_WIDTH, ViewBelow(_iconImageView) - M_PRICELABEL_HEIGHT, ViewWidth(_titleLabel) / 3, M_PRICELABEL_HEIGHT)];
    self.priceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.priceLabel];
    
    
    
}

-(void)setHotelModel:(HotelListModel *)hotelModel
{
    _hotelModel = hotelModel;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",_hotelModel.LowRate];
    self.messageLabel.text = [NSString stringWithFormat:@"星级：%@ \n评分：%@好评 \n地址：%@",_hotelModel.StarRate,_hotelModel.Score,_hotelModel.Address];
    self.titleLabel.text = hotelModel.HotelName;
//    [self.iconImageView setImageWithURL:[NSURL URLWithString:hotelModel.ThumbNailUrl] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:hotelModel.ThumbNailUrl] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    
}

@end
