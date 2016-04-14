//
//  ZFJShipZeroRowCell.m
//  WelLv
//
//  Created by 张发杰 on 15/5/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipZeroRowCell.h"
#import "ZFJShipListModel.h"
#define M_LEFT_WIDTH 15
#define M_SHIP_TOP_WIDTH 10
#define M_LINE_Introduce_HEIGHT 120
#define M_SHIP_Price_HEIGHT 20
@implementation ZFJShipZeroRowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customView];
    }
    return self;
}


- (void)customView{
    self.iconIamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, M_SHIP_TOP_WIDTH, windowContentWidth - M_LEFT_WIDTH * 2, M_LINE_Introduce_HEIGHT)];
    self.iconIamgeView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconIamgeView.clipsToBounds = YES;
    self.iconIamgeView.layer.cornerRadius = 5;
    self.iconIamgeView.layer.masksToBounds = YES;
    [self.iconIamgeView sd_setImageWithURL:[NSURL URLWithString:@"http://webmap1.map.bdimg.com/maps/services/thumbnails?width=525&height=295&quality=100&align=middle,middle&src=http://hiphotos.baidu.com/lvpics/pic/item/241f95cad1c8a7866cd26aaf6709c93d71cf5092.jpg"]];
    [self.contentView addSubview:self.iconIamgeView];
    
    self.lineCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, ViewY(_iconIamgeView) + ViewHeight(_iconIamgeView) + 5, ViewWidth(_iconIamgeView) / 4, M_SHIP_Price_HEIGHT)];
    self.lineCountLabel.textAlignment = NSTextAlignmentCenter;
    self.lineCountLabel.font = [UIFont systemFontOfSize:12];
    //self.lineCountLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_lineCountLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, ViewY(_lineCountLabel) + ViewHeight(_lineCountLabel), ViewWidth(_iconIamgeView) / 4, M_SHIP_Price_HEIGHT)];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.font = [UIFont systemFontOfSize:15];
    self.priceLabel.textColor = kColor(255, 96, 126);
    [self.contentView addSubview:_priceLabel];
    
    self.startLabel = [[UILabel alloc] init];
    _startLabel.text = @"起";
    _startLabel.textColor = [UIColor grayColor];
    _startLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_startLabel];
    
    UIView * splitLine = [[UIView alloc] initWithFrame:CGRectMake(ViewX(_lineCountLabel) + ViewWidth(_lineCountLabel)  - 0.5, ViewY(_lineCountLabel) + 5, 0.5, M_SHIP_Price_HEIGHT * 2 - 7)];
    splitLine.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:splitLine];
    
    self.inforLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(splitLine) + ViewWidth(splitLine) + 5, ViewY(_lineCountLabel), ViewWidth(_iconIamgeView) * 3 / 4 - 5, M_SHIP_Price_HEIGHT * 2)];
    self.inforLabel.numberOfLines = 2;
    self.inforLabel.font = [UIFont systemFontOfSize:12];
    self.inforLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_inforLabel];
    
}




- (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, M_SHIP_Price_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return rect;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
