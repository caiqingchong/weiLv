//
//  ZFJLiveAddressCell.m
//  WelLv
//
//  Created by 张发杰 on 15/4/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJLiveAddressCell.h"

@implementation ZFJLiveAddressCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width - 50, self.frame.size.height)];
        //self.titleLabel.text = @"河南";
        [self addSubview:self.titleLabel];
        
        self.chooseImage = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 50, 10, self.frame.size.height - 20, self.frame.size.height - 20)];
        //self.chooseImage.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.chooseImage];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
