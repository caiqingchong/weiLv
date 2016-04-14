//
//  ManageMemberTableViewCell.m
//  WelLv
//
//  Created by 刘鑫 on 15/5/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ManageMemberTableViewCell.h"

@implementation ManageMemberTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self coustomView];
    }
    return self;
}

-(void)coustomView
{
    self.nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    self.nameLabel.textColor=[UIColor grayColor];
    //self.nameLabel.text=[_selectTableArray objectAtIndex:indexPath.row];
    self.nameLabel.font=[UIFont systemFontOfSize:15];
    [self addSubview:self.nameLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
