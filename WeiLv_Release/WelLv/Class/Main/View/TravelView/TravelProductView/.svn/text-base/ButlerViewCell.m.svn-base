//
//  ButlerViewCell.m
//  TraveDetail
//
//  Created by WeiLv on 16/1/12.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "ButlerViewCell.h"

#import "ProductModel.h"

#import "UIImageView+WebCache.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation ButlerViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self.contentView addSubview:self.photoImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.sexImage];
        [self.contentView addSubview:self.countLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.phoneImage];
    }
    return self;
}

/**
 *  懒加载创建子控件
 */
//头像
- (UIImageView *)photoImage{
    
    if (!_photoImage) {
        self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 20, UISCREEN_HEIGHT / 71, UISCREEN_WIDTH / 4, UISCREEN_WIDTH / 4)];
      
        self.photoImage.layer.cornerRadius = UISCREEN_WIDTH / 8;
        self.photoImage.layer.masksToBounds = YES;
       
    }
    return _photoImage;
}

//名称
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.photoImage.frame) + UISCREEN_WIDTH / 52,UISCREEN_HEIGHT / 44, UISCREEN_WIDTH / 6, UISCREEN_HEIGHT / 24)];

    }
    return _nameLabel;
}
//性别图标
- (UIImageView *)sexImage{
    if (!_sexImage) {
        self.sexImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLabel.frame) + UISCREEN_WIDTH / 30,CGRectGetMinY(self.nameLabel.frame), UISCREEN_WIDTH /13, UISCREEN_WIDTH / 13)];
        self.sexImage.layer.cornerRadius = UISCREEN_WIDTH / 26;
        self.sexImage.layer.masksToBounds = YES;
 
        self.sexImage.image = [UIImage imageNamed:@"默认图1"];
    }
    return _sexImage;
}
//服务记录
- (UILabel *)countLabel{
    if (!_countLabel) {
        self.countLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.nameLabel.frame), CGRectGetMaxY(self.nameLabel.frame) + UISCREEN_HEIGHT / 22, UISCREEN_WIDTH / 4, UISCREEN_WIDTH / 12)];
        
    }
    return _countLabel;
}

//分销产品
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.countLabel.frame) + UISCREEN_WIDTH / 16, CGRectGetMinY(self.countLabel.frame), UISCREEN_WIDTH / 5, UISCREEN_WIDTH /12)];
        
    }
    return _numberLabel;
}

//电话图片
- (UIImageView *)phoneImage{
    if (!_phoneImage) {
        self.phoneImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 30 - UISCREEN_WIDTH / 8, UISCREEN_HEIGHT / 20, UISCREEN_WIDTH / 8, UISCREEN_WIDTH / 8)];
        self.phoneImage.layer.cornerRadius = UISCREEN_WIDTH / 16;
        self.phoneImage.layer.masksToBounds = YES;
        self.phoneImage.image = [UIImage imageNamed:@"6-电话"];
    }
    return _phoneImage;
}

- (void)assignValueByModel:(ProductModel *)model{
    
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,model.avatar]] placeholderImage:[UIImage imageNamed:@"默认图1"]];

    self.nameLabel.text = model.name;
    self.nameLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 24.61];
    
    if ([model.gender isEqualToString:@"null"]) {
        self.sexImage.image = [UIImage imageNamed:@"女"];
    }else if([model.gender isEqualToString:@"2"]){
        self.sexImage.image = [UIImage imageNamed:@"男"];
    }
    
    self.countLabel.text = [NSString stringWithFormat:@"服务记录:%@",model.order_count];
    self.countLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 29.09];
    self.countLabel.textColor = [UIColor grayColor];
    self.numberLabel.text = [NSString stringWithFormat:@"分销产品:%@",model.product_count];
    self.numberLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 29.09];
    self.numberLabel.textColor = [UIColor grayColor];
    
    
    
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
