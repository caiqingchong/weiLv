//
//  ZFJTicketProductCell.m
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJTicketProductCell.h"
#import "TicketListModel.h"

#define M_TITLE_LABEL_HEIGHT 20
@implementation ZFJTicketProductCell

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewHeight(self))];
    [self addSubview:self.iconImage];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewHeight(self) - M_TITLE_LABEL_HEIGHT, ViewWidth(self), M_TITLE_LABEL_HEIGHT)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self.iconImage addSubview:self.titleLabel];
    
    UIImage * priceImage = [UIImage imageNamed:@"吊牌"];
    UIImageView * priceIconView = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(self.iconImage) - priceImage.size.width - 5.0 , 0, priceImage.size.width, priceImage.size.height)];
    priceIconView.image = priceImage;
    [self.iconImage addSubview:priceIconView];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, ViewHeight(priceIconView) / 2 - 10, ViewWidth(priceIconView) - 4, ViewHeight(priceIconView) / 2)];
    self.priceLabel.textColor = [UIColor whiteColor];
    self.priceLabel.font = [UIFont systemFontOfSize:14];
    self.priceLabel.adjustsFontSizeToFitWidth = YES;
    [priceIconView addSubview:self.priceLabel];
    
    
}
- (void)setModel:(TicketListModel *)model {
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[self judgeRetuRnImagesClass:[model.images objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"默认图4"]];

    self.titleLabel.text = [self judgeReturnString:model.product_name withReplaceString:@" "];
    //[NSString stringWithFormat:@"  %@", model.product_name];
    
    if ([self judgeString:model.start_price]) {
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@起", model.start_price];
    } else {
        self.priceLabel.text = [NSString stringWithFormat:@"￥0 起"];

    }
}

@end
