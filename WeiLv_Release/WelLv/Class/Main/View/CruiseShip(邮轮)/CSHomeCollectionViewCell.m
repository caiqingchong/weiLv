//
//  CSHomeCollectionViewCell.m
//  WelLv
//
//  Created by nick on 16/3/10.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSHomeCollectionViewCell.h"

@implementation CSHomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if(self){
    
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setLayoutWithContents:(NSArray *)contents andIndexPath:(NSIndexPath *)indexPath {

    //产品照片
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, 0, SCREEN_WIDTH - MARGIN_WIDTH * 2, 150)];
    
    photoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"product_%li.png", indexPath.row]];
    
    [self.contentView addSubview:photoImageView];
    
    [self setCornerRadiusWithView:photoImageView roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight andRadius:CGSizeMake(2, 2)];
    
    //提示栏
    UIView *tipBar = [[UIView alloc] initWithFrame:CGRectMake(0, photoImageView.frame.size.height - 25, photoImageView.frame.size.width, 25)];
    
    tipBar.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    [photoImageView addSubview:tipBar];
    
    //出发港口
    UIImageView *portIcon = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, (tipBar.frame.size.height - 14) / 2, 12, 14)];
    
    portIcon.image = [UIImage imageNamed:@"port.png"];
    
    [tipBar addSubview:portIcon];
    
    UILabel *portLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(portIcon.frame) + 5, 0, 48, tipBar.frame.size.height)];
    
    portLabel.text = @"上海出发";
    
    portLabel.font = [UIFont systemFontOfSize:12.0];
    
    portLabel.textColor = [UIColor whiteColor];
    
    [tipBar addSubview:portLabel];
    
    //报名时间
    UIImageView *enrollIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(portLabel.frame) + 30, portIcon.frame.origin.y, 12, 14)];
    
    enrollIcon.image = [UIImage imageNamed:@"enroll.png"];
    
    [tipBar addSubview:enrollIcon];
    
    UILabel *enrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(enrollIcon.frame) + 5, 0, 90, tipBar.frame.size.height)];
    
    enrollLabel.text = @"请提前10天报名";
    
    enrollLabel.font = [UIFont systemFontOfSize:12.0];
    
    enrollLabel.textColor = [UIColor whiteColor];
    
    [tipBar addSubview:enrollLabel];
    
    //收藏图标
    UIImageView *favIcon = [[UIImageView alloc] initWithFrame:CGRectMake(tipBar.frame.size.width - MARGIN_WIDTH - 21, 2, 21, 21)];
    
    favIcon.image = [UIImage imageNamed:@"favorite.png"];
    
    [tipBar addSubview:favIcon];
    
    //产品信息
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, CGRectGetMaxY(photoImageView.frame), photoImageView.frame.size.width, 67)];
    
    infoView.layer.borderWidth = 0.5;
    
    infoView.layer.borderColor = kColor(222.0, 222.0, 222.0).CGColor;
    
    [self.contentView addSubview:infoView];
    
    [self setCornerRadiusWithView:infoView roundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight andRadius:CGSizeMake(2, 2)];
    
    //产品名称
    NSArray *names = @[@"<2015年6月7日歌诗达大西洋号 上海-济州-福冈-上海 4晚5天>",
                       @"09.01 伯曼邮轮“海皇号”北欧波罗的海五国11天经典首都游",
                       @"2015年5月15日皇家加勒比海量子号 上海-福冈-宫崎-上海5晚6天"];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, 5, photoImageView.frame.size.width - MARGIN_WIDTH * 2, 35)];
    
    nameLabel.text = [names objectAtIndex:indexPath.row];
    
    nameLabel.numberOfLines = 2;
    
    nameLabel.font = [UIFont systemFontOfSize:14.0];
    
    nameLabel.textColor = kColor(45.0, 45.0, 45.0);
    
    [infoView addSubview:nameLabel];
    
    //邮轮品牌
    NSArray *brands = @[@"歌诗达大西洋号邮轮", @"伯曼邮轮“海皇号”", @"皇家加勒比国际游轮"];
    
    UIView *brandView = [[UIView alloc] initWithFrame:CGRectMake(nameLabel.frame.origin.x, CGRectGetMaxY(nameLabel.frame) + 5, nameLabel.frame.size.width * 0.6, 12)];
    
    [infoView addSubview:brandView];
    
    UIImageView *brandIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    
    brandIcon.image = [UIImage imageNamed:@"brand.png"];
    
    [brandView addSubview:brandIcon];
    
    CGFloat brandOriginX = CGRectGetMaxX(brandIcon.frame) + 5;
    
    UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(brandOriginX, 0, brandView.frame.size.width - brandOriginX, brandView.frame.size.height)];
    
    brandLabel.text = [brands objectAtIndex:indexPath.row];
    
    brandLabel.font = [UIFont systemFontOfSize:12.0];
    
    brandLabel.textColor = kColor(156.0, 156.0, 156.0);
    
    [brandView addSubview:brandLabel];
    
    //产品价格
    NSArray *prices = @[@"19860", @"9860", @"9860"];
    
    UILabel *rangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame) - 13, CGRectGetMaxY(nameLabel.frame) + 4, 13, 13)];
    
    rangeLabel.text = @"起";
    
    rangeLabel.font = [UIFont systemFontOfSize:13.0];
    
    rangeLabel.textColor = kColor(156.0, 156.0, 156.0);
    
    [infoView addSubview:rangeLabel];
    
    NSMutableAttributedString *price = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %@", [prices objectAtIndex:indexPath.row]]];
    
    [price addAttribute:NSForegroundColorAttributeName value:kColor(255.0, 81.0, 65.0) range:NSMakeRange(0, price.length)];
    
    [price addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, 1)];
    
    [price addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0] range:NSMakeRange(1, price.length - 1)];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(brandView.frame), CGRectGetMaxY(nameLabel.frame), nameLabel.frame.size.width * 0.4 - rangeLabel.frame.size.width, 17)];
    
    priceLabel.attributedText = price;
    
    priceLabel.textAlignment = NSTextAlignmentRight;
    
    [infoView addSubview:priceLabel];
}

- (void)setCornerRadiusWithView:(UIView *)view roundingCorners:(UIRectCorner)corners andRadius:(CGSize)radius {

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:radius];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
}

@end








