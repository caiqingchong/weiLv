//
//  MyCollectViewCell.m
//  WelLv
//
//  Created by WeiLv on 16/1/31.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "MyCollectViewCell.h"

#import "ProductModel.h"

#import "UIImageView+WebCache.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation MyCollectViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.pictureImage];
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.dateLable];
        [self.contentView addSubview:self.signLable];
        [self.contentView addSubview:self.priceLable];
        
    }
    return self;
}

//宣传图片
- (UIImageView *)pictureImage{
    if (!_pictureImage) {
        self.pictureImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, UISCREEN_WIDTH / 4.26, UISCREEN_WIDTH / 4.26)];
        self.pictureImage.image = [UIImage imageNamed:@"默认图1"];
        self.pictureImage.layer.masksToBounds = YES;
        self.pictureImage.layer.cornerRadius = 3;
    }
    return _pictureImage;
}
//标题
- (UILabel *)titleLable{
    if (!_titleLable) {
        self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.pictureImage.frame) + 10,CGRectGetMinY(self.pictureImage.frame), UISCREEN_WIDTH - UISCREEN_WIDTH / 4.26 - UISCREEN_WIDTH / 10, UISCREEN_WIDTH / 4.26/2)];
        self.titleLable.numberOfLines = 0;
        self.titleLable.text = @"徽州故事:黄山,西递,宏林,醉温泉高端品质之旅";
        self.titleLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 21.33];
        
    }
    return _titleLable;
}

//最近团期
- (UILabel *)dateLable{
    
    if (!_dateLable) {
        self.dateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLable.frame), CGRectGetMaxY(self.pictureImage.frame) - UISCREEN_WIDTH / 16, UISCREEN_WIDTH / 4, UISCREEN_WIDTH / 16)];
        self.dateLable.text = @"11-8.11-15....出发";
        self.dateLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66];
        self.dateLable.textColor = [UIColor grayColor];
    }
    return _dateLable;
}
//金钱符号
- (UILabel *)signLable{
    if (!_signLable) {
        self.signLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 4.2, CGRectGetMinY(self.dateLable.frame) - 6, UISCREEN_WIDTH / 16, UISCREEN_WIDTH / 10)];
        self.signLable.text = @"￥";
        self.signLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 24.6];
        self.signLable.textColor = [UIColor orangeColor];
        
    }
    return _signLable;
}

//价格
- (UILabel *)priceLable{
    if (!_priceLable) {
        self.priceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.signLable.frame) - 8, CGRectGetMinY(self.signLable.frame), UISCREEN_WIDTH / 3, UISCREEN_WIDTH / 10)];
        self.priceLable.text = @"1660";
        self.priceLable.textColor = [UIColor orangeColor];
        self.priceLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 21.33];
        
    }
    return _priceLable;
}

- (void)assignValueWithModel:(ProductModel *)model{
    
    if ([model.thumb hasPrefix:@"http"]) {
        [self.pictureImage sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    }else{
        
        [self.pictureImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/upload/thumb/%@",WLHTTP,model.thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    }
    
    self.titleLable.text = model.product_name;

    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.dateLable.frame), CGRectGetMinY(self.dateLable.frame),UISCREEN_WIDTH / 12, CGRectGetHeight(self.dateLable.frame))];
    startLabel.text = @"出发";
    startLabel.textColor = [UIColor grayColor];
    startLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66];
    [self addSubview:startLabel];
    
    self.priceLable.text = [NSString stringWithFormat:@"%ld起",[model.adult_price integerValue]];
    //DLog(@"111%@",self.priceLable.text);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
