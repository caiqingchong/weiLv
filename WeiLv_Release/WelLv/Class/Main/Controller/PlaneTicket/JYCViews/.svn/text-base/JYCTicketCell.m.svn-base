//
//  JYCTicketCell.m
//  WelLv
//
//  Created by lyx on 15/9/12.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCTicketCell.h"
@interface JYCTicketCell ()

@end

@implementation JYCTicketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    
    CGFloat padding = 20;
    CGRect frame    = CGRectMake(padding, padding, height-2*padding, height-2*padding);
    self.leftImageView=[[UIImageView alloc]initWithFrame:frame];
    [self addSubview:self.leftImageView];
    self.infoLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.leftImageView)+15, ViewY(self.leftImageView), windowContentWidth-ViewX(self.infoLabel)*2, ViewHeight(self.leftImageView))];
    self.infoLabel.backgroundColor = [UIColor clearColor];
    self.infoLabel.font = [UIFont boldSystemFontOfSize:18.0];
    
    [self addSubview:self.infoLabel];
    return self;
}
//- (void)awakeFromNib {
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
