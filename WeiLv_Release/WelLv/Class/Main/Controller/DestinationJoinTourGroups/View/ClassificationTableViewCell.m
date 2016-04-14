//
//  ClassificationTableViewCell.m
//  WelLv
//
//  Created by 赵阳 on 16/2/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "ClassificationTableViewCell.h"

@implementation ClassificationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = UIColorFromRGB(0xeef2f6);

        
        self.titleLabel = [[UILabel alloc]initForAutoLayout];

        [self addSubview:self.titleLabel];

        [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:0];

        [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:0];

        [self.titleLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:0];
        
        [self.titleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:0];
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabel.textColor = UIColorFromRGB(0xa1b7ca);
        
        
        //左边标记线条
        self.lineView = [[UIView alloc]initForAutoLayout];
        
        [self addSubview:self.lineView];
        
        [self.lineView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:0];
        
        [self.lineView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:0];
        
        [self.lineView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self withOffset:0];
        
        [self.lineView autoSetDimension:ALDimensionWidth toSize:3];
        
        if (windowContentHeight == 480)
        {
            //iPhone4
            self.titleLabel.font = [UIFont boldSystemFontOfSize:12];

        }
        else if(windowContentHeight == 568)
        {
            //iPhone5,iPhone5s,
            self.titleLabel.font = [UIFont boldSystemFontOfSize:12];

        }
        else if (windowContentHeight == 667)
        {
            //iPhone6
            self.titleLabel.font = [UIFont boldSystemFontOfSize:14];

        }
        else{
            
            //iPhone6p
            self.titleLabel.font = [UIFont boldSystemFontOfSize:15];

        }
        
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
