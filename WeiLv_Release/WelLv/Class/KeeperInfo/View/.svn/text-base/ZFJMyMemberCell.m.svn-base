//
//  ZFJMyMemberCell.m
//  WelLv
//
//  Created by 张发杰 on 15/5/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJMyMemberCell.h"
#import "MyMembersModel.h"
#import "UIDefines.h"

#define M_ICON_WIDTH 60
#define M_TOP 10
#define M_R_WIDTH 5
#define M_BUT_WIDTH 35
#define M_LABEL_WIDTH (self.frame.size.width - M_R_WIDTH * 2 - M_BUT_WIDTH - 15 - M_ICON_WIDTH - 10)

@implementation ZFJMyMemberCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self coustomView];
    }
    return self;
}

- (void)coustomView
{
    
    self.memberIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, M_TOP, M_ICON_WIDTH, M_ICON_WIDTH)];
    self.memberIcon.layer.cornerRadius = M_ICON_WIDTH / 2;
    self.memberIcon.layer.masksToBounds = YES;
    self.memberIcon.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_memberIcon];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.memberIcon.frame.origin.x + self.memberIcon.frame.size.width + 10, M_TOP + 5, windowContentWidth - M_R_WIDTH * 2 - M_BUT_WIDTH * 2 - 15 - M_ICON_WIDTH - 10, M_ICON_WIDTH / 2)];
    self.nameLabel.adjustsFontSizeToFitWidth=YES;
    [self addSubview:_nameLabel];
    
    
    self.phoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.memberIcon.frame.origin.x + self.memberIcon.frame.size.width + 10, M_TOP + self.nameLabel.frame.size.height, M_LABEL_WIDTH, M_ICON_WIDTH / 2)];
    self.phoneNumberLabel.textColor = [UIColor grayColor];
    [self addSubview:_phoneNumberLabel];
    
    
    self.travelsBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.travelsBut.frame = CGRectMake(windowContentWidth - M_R_WIDTH * 3 - M_BUT_WIDTH * 3, (80 - M_BUT_WIDTH) / 2, M_BUT_WIDTH, M_BUT_WIDTH);
    [self addSubview:self.travelsBut];
    
    self.editMemderInforBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editMemderInforBut.frame = CGRectMake(windowContentWidth - M_R_WIDTH * 2 - M_BUT_WIDTH * 2, (80 - M_BUT_WIDTH) / 2, M_BUT_WIDTH, M_BUT_WIDTH);
    [self addSubview:_editMemderInforBut];
    
    self.sendMessagesBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendMessagesBut.frame = CGRectMake(windowContentWidth - M_R_WIDTH - M_BUT_WIDTH, (80 - M_BUT_WIDTH) / 2, M_BUT_WIDTH, M_BUT_WIDTH);
    [self addSubview:_sendMessagesBut];
    
    
}

-(void)setMemberModel:(MyMembersModel *)memberModel
{
    if (memberModel.avater == nil || [memberModel.avater isEqual:[NSNull null]])
    {
        [self.memberIcon sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"默认图2"]];
    }
    else
    {
        NSString *url=[NSString stringWithFormat:@"%@/%@",WLHTTP,memberModel.avater];
        [self.memberIcon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"默认图2"]];
    }
    if (memberModel.realname == nil) {
        self.nameLabel.text=memberModel.username;
        
    } else {
        self.nameLabel.text=memberModel.realname;
        
    }
    self.nameLabel.frame = CGRectMake(ViewX(self.nameLabel), ViewY(self.nameLabel), [self returnTextCGRectText:self.nameLabel.text textFont:17 cGSize:CGSizeMake(0, ViewHeight(self.nameLabel))].size.width, ViewHeight(self.nameLabel));
    self.sexIcon.frame = CGRectMake(ViewRight(self.nameLabel) + 10, ViewY(self.nameLabel) + ViewHeight(self.nameLabel) / 2 - 8, 16, 16);
    if ([memberModel.sex isEqual:@"1"]) {
        self.sexIcon.image = [UIImage imageNamed:@"♂"];
    } else if ([memberModel.sex isEqual:@"2"]) {
        self.sexIcon.image = [UIImage imageNamed:@"♀"];
    } else {
        self.sexIcon.image = [UIImage imageNamed:@""];
        
    }
    
    self.phoneNumberLabel.text=memberModel.phone;
}


- (UIImageView *)sexIcon {
    if (!_sexIcon) {
        self.sexIcon = [[UIImageView alloc] init];
        [self addSubview:_sexIcon];
    }
    return _sexIcon;
}

@end
