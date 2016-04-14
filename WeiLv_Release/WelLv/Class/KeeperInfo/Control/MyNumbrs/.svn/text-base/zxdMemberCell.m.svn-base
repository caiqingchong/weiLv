//
//  zxdMemberCell.m
//  WelLv
//
//  Created by liuxin on 16/1/20.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdMemberCell.h"
#import "zxdMemberModel.h"
@implementation zxdMemberCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatView];
    }
    return self;
}
-(void)creatView
{
    //加粗[UILabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    //姓名
    self.NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 180, 20)];
   // self.NameLabel.font = [UIFont systemFontOfSize:18];
    [self.NameLabel setFont:[UIFont  fontWithName:@"Helvetica-Bold" size:18]];
    self.NameLabel.textColor = [YXTools stringToColor:@"#6f7378"];
    
    self.NameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.NameLabel];
    //手机号
    self.PhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, windowContentWidth-200, 20)];
    self.PhoneLabel.font = [UIFont systemFontOfSize:15];
        self.PhoneLabel.textAlignment = NSTextAlignmentLeft;
    self.PhoneLabel.textColor = [YXTools stringToColor:@"#6f7378"];
    [self.contentView addSubview:self.PhoneLabel];
    //身份证号
    self.IDLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 200, 20)];
    self.IDLabel.font = [UIFont systemFontOfSize:15];
       self.IDLabel.textAlignment = NSTextAlignmentLeft;
    self.IDLabel.textColor = [YXTools stringToColor:@"#6f7378"];
    [self.contentView addSubview:self.IDLabel];
    //身份证号码
    self.IDNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, windowContentWidth-120, 20)];
    self.IDNumberLabel.font = [UIFont systemFontOfSize:15];
    self.IDNumberLabel.textAlignment = NSTextAlignmentLeft;
    self.IDNumberLabel.textColor = [YXTools stringToColor:@"#6f7378"];
    self.IDNumberLabel.textColor = [UIColor grayColor];
   // [self.contentView addSubview:self.IDNumberLabel];
}
-(void)setZxdModel:(zxdMemberModel *)zxdModel
{
    self.PhoneLabel.text = zxdModel.visitor;
    self.NameLabel.text = zxdModel.name;
    self.IDNumberLabel.text = zxdModel.phone;
    self.IDLabel.text = [NSString stringWithFormat:@"%@",zxdModel.qq];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
