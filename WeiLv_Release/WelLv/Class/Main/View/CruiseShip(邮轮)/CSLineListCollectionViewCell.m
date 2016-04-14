//
//  CSLineListCollectionViewCell.m
//  WelLv
//
//  Created by nick on 16/3/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSLineListCollectionViewCell.h"

@interface CSLineListCollectionViewCell ()

@property(weak, nonatomic) UIView *payTypeView;

@property(weak, nonatomic) UIView *commissionView;

@end

@implementation CSLineListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if(self){
    
        self.backgroundColor = [UIColor whiteColor];
        
        self.layer.shouldRasterize = YES;
        
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
    
    return self;
}

- (void)setLayoutWithContents:(NSArray *)contents andIndexPath:(NSIndexPath *)indexPath {

    //邮轮照片
    CGFloat photoSize = self.frame.size.height - MARGIN_HEIGHT * 2;
    
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MARGIN_WIDTH, MARGIN_HEIGHT, photoSize, photoSize)];
    
    photoImageView.image = [UIImage imageNamed:@"list.png"];
    
    photoImageView.layer.masksToBounds = YES;
    
    photoImageView.layer.cornerRadius = 3.0;
    
    [self.contentView addSubview:photoImageView];
    
    //历时时间
    UILabel *durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, photoSize - 20, 15)];
    
    durationLabel.text = @"5晚6天";
    
    durationLabel.font = [UIFont systemFontOfSize:11.0];
    
    durationLabel.textColor = [UIColor whiteColor];
    
    durationLabel.textAlignment = NSTextAlignmentCenter;
    
    durationLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    [self setCornerRadiusWithView:durationLabel roundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight andRadius:CGSizeMake(3, 3)];
    
    [photoImageView addSubview:durationLabel];
    
    //邮轮名称
    NSString *name;
    
    if(indexPath.row % 2 == 0){
        
        name = @"2015年5月15日皇家加勒比海量子号 上海-福冈-宫崎-上海5晚6天";
        
    }else{
        
        name = @"2016年4月18日 上海-济州-福冈-上海";
    }
    
    CGFloat nameOriginX = CGRectGetMaxX(photoImageView.frame) + MARGIN_WIDTH;
    
    CGFloat nameHeight = [self contentSizeWithString:name fontSize:14.0 andMaxSize:CGSizeMake(self.frame.size.width - nameOriginX - MARGIN_WIDTH, 35)].height;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameOriginX, MARGIN_HEIGHT, self.frame.size.width - nameOriginX - MARGIN_WIDTH, nameHeight)];
    
    nameLabel.text = name;
    
    nameLabel.numberOfLines = 0;
    
    nameLabel.font = [UIFont systemFontOfSize:14.0];
    
    nameLabel.textColor = kColor(45.0, 45.0, 45.0);
    
    [self.contentView addSubview:nameLabel];
    
    //出发日期
    UIImageView *setoutIcon = [[UIImageView alloc] initWithFrame:CGRectMake(nameOriginX, CGRectGetMaxY(photoImageView.frame) - 15 - 5 - 12, 12, 12)];
    
    setoutIcon.image = [UIImage imageNamed:@"cs_calendar_gray"];
    
    [self.contentView addSubview:setoutIcon];
    
    UILabel *setoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(setoutIcon.frame) + 5, setoutIcon.frame.origin.y, 80, 12)];
    
    setoutLabel.text = @"2016-04-18";
    
    setoutLabel.font = [UIFont systemFontOfSize:12.0];
    
    setoutLabel.textColor = kColor(156.0, 156.0, 156.0);
    
    [self.contentView addSubview:setoutLabel];
    
    //出发港口
    UIImageView *portIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(setoutLabel.frame) + 20, setoutIcon.frame.origin.y, 12, 12)];
    
    portIcon.image = [UIImage imageNamed:@"cs_port_gray"];
    
    [self.contentView addSubview:portIcon];
    
    UILabel *portLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(portIcon.frame) + 3, setoutLabel.frame.origin.y, 80, 12)];
    
    portLabel.text = @"上海出发";
    
    portLabel.font = [UIFont systemFontOfSize:12.0];
    
    portLabel.textColor = kColor(156.0, 156.0, 156.0);
    
    [self.contentView addSubview:portLabel];
    
    //支付类型
    if(indexPath.row % 2 == 0){
    
        UIView *payTypeView = [[UIView alloc] init];
        
        payTypeView.layer.borderWidth = 1;
        
        payTypeView.layer.borderColor = kColor(120.0, 188.0, 2494.0).CGColor;
        
        payTypeView.layer.cornerRadius = 7;
        
        [self.contentView addSubview:payTypeView];
        
        self.payTypeView = payTypeView;
        
        UIImageView *payTypeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(photoImageView.frame) + MARGIN_WIDTH, CGRectGetMaxY(photoImageView.frame) - 15, 14, 15)];
        
        [self.contentView addSubview:payTypeIcon];
        
        UILabel *payTypeLabel = [[UILabel alloc] init];
        
        payTypeLabel.font = [UIFont systemFontOfSize:11.0];
        
        payTypeLabel.textColor = kColor(120.0, 188.0, 2494.0);
        
        [payTypeView addSubview:payTypeLabel];
        
        if(indexPath.row % 2 == 0){
        
            payTypeView.frame = CGRectMake(CGRectGetMaxX(photoImageView.frame) + MARGIN_WIDTH + payTypeIcon.frame.size.width / 2, payTypeIcon.frame.origin.y, 68, payTypeIcon.frame.size.height);
            
            payTypeIcon.image = [UIImage imageNamed:@"pay_confirm.png"];
            
            payTypeLabel.text = @"确认后支付";
            
        }else{
        
            payTypeView.frame = CGRectMake(CGRectGetMaxX(photoImageView.frame) + MARGIN_WIDTH + payTypeIcon.frame.size.width / 2, payTypeIcon.frame.origin.y, 57, payTypeIcon.frame.size.height);
            
            payTypeIcon.image = [UIImage imageNamed:@"pay_now.png"];
            
            payTypeLabel.text = @"直接支付";
        }
        
        payTypeLabel.frame = CGRectMake(payTypeIcon.frame.size.width / 2 + 1.5, 0, payTypeView.frame.size.width - 8 - 5, payTypeView.frame.size.height);
    }
    
    //管家返佣金额
    if(indexPath.row % 2 != 0){
    
        NSString *commission = @"¥9999起";
        
        CGFloat commissionWidth = [self contentSizeWithString:commission fontSize:11.0 andMaxSize:CGSizeMake(100, 11)].width + 18 + MARGIN_WIDTH;
        
        UIView *commissionView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(photoImageView.frame) + MARGIN_WIDTH, CGRectGetMaxY(photoImageView.frame) - 15, commissionWidth, 15)];
        
        commissionView.layer.borderWidth = 1;
        
        commissionView.layer.borderColor = kColor(120.0, 188.0, 2494.0).CGColor;
        
        commissionView.layer.cornerRadius = 7;
        
        [self.contentView addSubview:commissionView];
        
        self.commissionView = commissionView;
        
        UILabel *commissionTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, commissionView.frame.size.height)];
        
        commissionTipLabel.text = @"返";
        
        commissionTipLabel.font = [UIFont systemFontOfSize:11.0];
        
        commissionTipLabel.textAlignment = NSTextAlignmentCenter;
        
        commissionTipLabel.textColor = [UIColor whiteColor];
        
        commissionTipLabel.backgroundColor = kColor(95.0, 180.0, 243.0);
        
        [self setCornerRadiusWithView:commissionTipLabel roundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft andRadius:CGSizeMake(7, 7)];
        
        [commissionView addSubview:commissionTipLabel];
        
        UILabel *commissionLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(commissionTipLabel.frame), 0, commissionWidth - commissionTipLabel.frame.size.width, commissionView.frame.size.height)];
        
        commissionLabel.font = [UIFont systemFontOfSize:11.0];
        
        commissionLabel.textAlignment = NSTextAlignmentCenter;
        
        commissionLabel.textColor = kColor(156.0, 156.0, 156.0);
        
        NSMutableAttributedString *mutCommission = [[NSMutableAttributedString alloc] initWithString:commission];
        
        [mutCommission addAttribute:NSForegroundColorAttributeName value:kColor(255.0, 88.0, 0.0) range:NSMakeRange(0, mutCommission.length - 1)];
        
        commissionLabel.attributedText = mutCommission;
        
        [commissionView addSubview:commissionLabel];
    }
    
    //邮轮价格
    NSString *price = @"¥ 19660起";
    
    UILabel *priceLabel = [[UILabel alloc] init];
    
    priceLabel.font = [UIFont systemFontOfSize:12.0];
    
    priceLabel.textColor = kColor(156.0, 156.0, 156.0);
    
    priceLabel.textAlignment = NSTextAlignmentRight;
    
    CGFloat originX;
    
    if(indexPath.row % 2 == 0){
    
        originX = CGRectGetMaxX(self.payTypeView.frame) + MARGIN_WIDTH;
        
    }else{
    
        originX = CGRectGetMaxX(self.commissionView.frame) + MARGIN_WIDTH;
    }
    
    priceLabel.frame = CGRectMake(originX, CGRectGetMaxY(photoImageView.frame) - 16, SCREEN_WIDTH - originX - MARGIN_WIDTH, 16);
    
    NSMutableAttributedString *mutPrice = [[NSMutableAttributedString alloc] initWithString:price];
    
    [mutPrice addAttribute:NSForegroundColorAttributeName value:kColor(255.0, 88.0, 0.0) range:NSMakeRange(0, mutPrice.length - 1)];
    
    [mutPrice addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(1, price.length - 2)];
    
    priceLabel.attributedText = mutPrice;
    
    [self.contentView addSubview:priceLabel];
    
    //底边框
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
    
    bottomLine.backgroundColor = kColor(229.0, 229.0, 229.0);
    
    [self.contentView addSubview:bottomLine];
}

- (void)setCornerRadiusWithView:(UIView *)view roundingCorners:(UIRectCorner)corners andRadius:(CGSize)radius {
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:radius];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.frame = view.bounds;
    
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
}

- (CGSize)contentSizeWithString:(NSString *)string fontSize:(CGFloat)fontSize andMaxSize:(CGSize)rectSize {
    
    CGSize contentSize = [string boundingRectWithSize:rectSize options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil].size;
    
    return contentSize;
}

@end








