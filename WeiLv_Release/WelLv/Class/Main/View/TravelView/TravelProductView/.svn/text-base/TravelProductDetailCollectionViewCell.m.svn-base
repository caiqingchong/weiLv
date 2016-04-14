//
//  TravelProductDetailCollectionViewCell.m
//  WelLv
//
//  Created by 张子乾 on 16/2/16.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelProductDetailCollectionViewCell.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#import "UIImageView+WebCache.h"

#import "ProductModel.h"

@implementation TravelProductDetailCollectionViewCell

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.photoImage];
        [self.contentView addSubview:self.titlelable];
        [self.contentView addSubview:self.priceLable];
        [self addLines];
    }
    return self;
}

/**
 *  懒加载 ,加载视图上的子控件
 */
- (UIImageView *)photoImage {
    if (!_photoImage) {
        self.photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,UISCREEN_WIDTH / 2.2, UISCREEN_HEIGHT / 6.04)];
        self.photoImage.image = [UIImage imageNamed:@"111"];
        
    }
    return _photoImage;
}

- (UILabel *)titlelable{
    if (!_titlelable) {
        self.titlelable = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.photoImage.frame) + UISCREEN_HEIGHT / 94.66, CGRectGetWidth(self.photoImage.frame) - UISCREEN_WIDTH / 40,CGRectGetHeight(self.photoImage.frame) / 3)];
        self.titlelable.numberOfLines = 0;
        self.titlelable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.6];
        //        self.titlelable.text = @"< 郑州到少林寺 龙门石窟一日游 >";
        
    }
    return _titlelable;
}

- (UILabel *)priceLable{
    
    if (!_priceLable) {
        self.priceLable = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.titlelable.frame) + UISCREEN_HEIGHT / 94.66, CGRectGetWidth(self.titlelable.frame), CGRectGetHeight(self.titlelable.frame) / 2)];
        //       self.priceLable.text = @"￥1560";
        self.priceLable.textColor = [UIColor orangeColor];
        self.priceLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.6];
    }
    return _priceLable;
}

- (void)addLines{
    UILabel *firstLine = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.photoImage.frame), 1, UISCREEN_HEIGHT / 9.6)];
    firstLine.backgroundColor = [UIColor grayColor];
    firstLine.alpha = 0.3;
    [self.contentView addSubview:firstLine];
    
    UILabel *secondLine = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.photoImage.frame) - 1, CGRectGetMaxY(self.photoImage.frame), 1, UISCREEN_HEIGHT / 9.6)];
    secondLine.alpha = 0.3;
    secondLine.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:secondLine];
    
    UILabel *thirdLable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(firstLine.frame), CGRectGetWidth(self.photoImage.frame), 1)];
    thirdLable.alpha = 0.3;
    thirdLable.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:thirdLable];
}

- (void)assignValueForItemWithModel:(ProductModel *)model{
    if ([model.thumb hasPrefix:@"http"]) {
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.thumb]] placeholderImage:[UIImage imageNamed:@"默认图4"]];
    }else{
        [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,model.thumb]] placeholderImage:[UIImage imageNamed:@"默认图4"]];
    }
    self.titlelable.text = [NSString stringWithFormat:@"< %@ >",model.product_name];
   
    
    UILabel *signLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMinY(self.priceLable.frame) + 1, UISCREEN_WIDTH / 16, CGRectGetHeight(self.priceLable.frame))];
    signLabel.text = @"¥";
    signLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 34];
    signLabel.textColor = [UIColor colorWithRed:255 / 255.0 green:78 / 255.0 blue:0 / 255.0 alpha:1];
    [self.contentView addSubview:signLabel];
    
    self.priceLable.text = [NSString stringWithFormat:@"  %ld起",[model.adult_price integerValue]];
}


@end
