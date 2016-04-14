//
//  JYCMyBankCardsCell.m
//  WelLv
//
//  Created by lyx on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "JYCMyBankCardsCell.h"

@implementation JYCMyBankCardsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    self.logoImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    [self addSubview:self.logoImage];
    self.topLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.logoImage)+10, 10, 150, 20)];
    self.topLabel.textColor=[UIColor blackColor];
    self.topLabel.font=[UIFont systemFontOfSize:16];
    [self addSubview:self.topLabel];
    self.numLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewX(self.topLabel), ViewBelow(self.topLabel)+20, 90, 20)];
    self.numLabel.textColor=[UIColor grayColor];
    self.numLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.numLabel];
    self.typeLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.numLabel)+15, ViewY(self.numLabel), 80, 20)];
    self.typeLabel.textColor=[UIColor grayColor];
    self.typeLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:self.typeLabel];
    
    
    return self;
}
-(void)setModel:(bank_model *)model
{
    if (![self judgeString:model.img]) {
        self.logoImage.hidden=YES;
        [self.topLabel setFrame:CGRectMake(10, 10, 150, 20)];
        [self.numLabel setFrame:CGRectMake(ViewX(self.topLabel), ViewBelow(self.topLabel)+20, 90, 20)];
        [self.typeLabel setFrame:CGRectMake(ViewRight(self.numLabel)+15, ViewY(self.numLabel), 80, 20)];
    }
    NSString *str=[NSString stringWithFormat:@"%@%@",WLHTTP,model.img];
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    self.topLabel.text=[NSString stringWithFormat:@"%@",model.bank];
    NSString *str2=[model.account substringWithRange:NSMakeRange(model.account.length-4, 4)];
    self.numLabel.text=[NSString stringWithFormat:@"尾号%@",str2];
    self.typeLabel.text=[NSString stringWithFormat:@"%@",model.card_type];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
