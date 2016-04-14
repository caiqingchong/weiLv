//
//  VisaCountryListCell.m
//  WelLv
//
//  Created by 张发杰 on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "VisaCountryListCell.h"
#define K_LEFT_MARGIN 10
#define K_TOP_MARGIN 5
#define K_ICON_SIZE 50

@implementation VisaCountryListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建子视图;
        [self createCellSubViews];
    }
    return self;
}
- (void)createCellSubViews
{
    self.countryIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(K_LEFT_MARGIN, K_TOP_MARGIN, K_ICON_SIZE, K_ICON_SIZE)];
    _countryIconImage.layer.cornerRadius = K_ICON_SIZE / 2;
    _countryIconImage.layer.masksToBounds = YES;
    _countryIconImage.contentMode = UIViewContentModeScaleAspectFill;
    _countryIconImage.clipsToBounds = YES;
    //_countryIconImage.layer.borderWidth = 0.0;
    [_countryIconImage sd_setImageWithURL:[NSURL URLWithString:@"http://ntu.so/dm/3NDGG/u=1919263832,3909055626&fm=21&gp=0.jpg"]];
    _countryIconImage.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_countryIconImage];
    
    self.countryNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(K_LEFT_MARGIN + K_ICON_SIZE + 5, K_TOP_MARGIN, self.frame.size.width - K_LEFT_MARGIN - K_ICON_SIZE - 5, K_ICON_SIZE)];
    //self.countryNameLabel.text = @"澳大利亚";
    //_countryNameLabel.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_countryNameLabel];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
