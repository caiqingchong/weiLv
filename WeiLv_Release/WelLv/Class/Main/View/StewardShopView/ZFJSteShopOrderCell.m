//
//  ZFJSteShopOrderCell.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopOrderCell.h"
#import "ZFJSteShopOrderModel.h"
#import "orderModel.h"

#define M_CELL_HEIGHT 120
#define M_LEFT_GAP 10
#define M_GAP 10
#define M_THUMB_W_H (90 - 5 * 2)

@interface ZFJSteShopOrderCell ()
@property (nonatomic, strong) UIView * line;

@end

@implementation ZFJSteShopOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIView * topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 10)];
        topBgView.backgroundColor = kColor(240, 246, 251);
        [self.contentView addSubview:topBgView];
        [self customView];
    }
    return self;
}
- (void)customView {
 
    self.productTypeLab = [[UILabel alloc] init];
    self.productTypeLab.font =[UIFont systemFontOfSize:12];
    self.productTypeLab.textColor = UIColorFromRGB(0x6f7378);
    [self.contentView addSubview:_productTypeLab];
    
    self.startTimeLab = [[UILabel alloc] init];
    self.startTimeLab.font =[UIFont systemFontOfSize:12];
    self.startTimeLab.textColor = UIColorFromRGB(0x6f7378);
    [self.contentView addSubview:_startTimeLab];
    
    self.payStatus = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth - [self returnTextCGRectText:@"[已取消]" textFont:12 cGSize:CGSizeMake(0, 20)].size.width - M_LEFT_GAP, 10, [self returnTextCGRectText:@"[已取消]" textFont:12 cGSize:CGSizeMake(0, 20)].size.width, 20)];
    self.payStatus.font =[UIFont systemFontOfSize:12];
    self.payStatus.textColor = UIColorFromRGB(0x6fafff);
    self.payStatus.text = @"[已取消]";
    [self.contentView addSubview:_payStatus];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5, windowContentWidth, 0.5)];;
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:lineView];
    
    self.thumbImage = [[UIImageView alloc] initWithFrame:CGRectMake(M_LEFT_GAP, ViewBelow(lineView) + 5, M_THUMB_W_H, M_THUMB_W_H)];
    self.thumbImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.thumbImage.layer.cornerRadius = 3.0;
    self.thumbImage.layer.masksToBounds = YES;
    self.thumbImage.contentMode = UIViewContentModeScaleAspectFill;
    self.thumbImage.clipsToBounds = YES;
    [self.contentView addSubview:_thumbImage];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_thumbImage) + M_GAP, ViewY(_thumbImage), windowContentWidth - (ViewRight(_thumbImage) + M_GAP), ViewHeight(_thumbImage) / 2.0)];
    self.titleLab.numberOfLines = 2;
    self.titleLab.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLab];
    
    self.partnerLab = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_titleLab), ViewBelow(_titleLab), ViewWidth(_titleLab) * 3 / 4.0, ViewHeight(_thumbImage) / 4.0)];
    self.partnerLab.textColor = UIColorFromRGB(0xabb4bc);
    self.partnerLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_partnerLab];
    
    self.commissionLab = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_titleLab), ViewBelow(_partnerLab), ViewWidth(_titleLab) / 2.0+10.0, ViewHeight(_thumbImage) / 4.0)];
    self.commissionLab.textColor = UIColorFromRGB(0xabb4bc);
    self.commissionLab.font = [UIFont systemFontOfSize:12];
    self.commissionLab.text = @"佣金:¥100";
    [self.contentView addSubview:_commissionLab];

    self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth - ViewWidth(_titleLab)  / 2.0 , ViewBelow(_partnerLab), ViewWidth(_titleLab) / 2.0  - 10, ViewHeight(_thumbImage) / 4.0)];
    self.priceLab.textColor = UIColorFromRGB(0xff9600);
    self.priceLab.font = [UIFont systemFontOfSize:15];
    self.priceLab.textAlignment = NSTextAlignmentRight;
    self.priceLab.text = @"¥1236.00";
    [self.contentView addSubview:_priceLab];

}

- (void)setModelOrder:(ZFJSteShopOrderModel *)modelOrder {
    //self.productTypeLab.text = @"";
    NSLog(@"%@",modelOrder.img);
    NSString * productTypeStr = @"";
    //NSLog(@"%@", modelOrder.product_category);
    if ([modelOrder.product_category isEqualToString:@"2"]) {
        productTypeStr = @"签证";
    } else if ([modelOrder.product_category isEqualToString:@"3"] || [modelOrder.product_category isEqualToString:@"-5"]){
        productTypeStr = @"邮轮";

    }else if ([modelOrder.product_category isEqualToString:@"-1"]){
        productTypeStr = @"门票";

    }else if ([modelOrder.product_category isEqualToString:@"-2"]){
        productTypeStr = @"游学";

    }else if ([modelOrder.product_category isEqualToString:@"-3"]){
        productTypeStr = @"机票";

    }else if ([modelOrder.product_category isEqualToString:@"5"]){
        
        productTypeStr = @"一日游";
        
    }else if ([modelOrder.product_category isEqualToString:@"6"] || [modelOrder.product_category isEqualToString:@"-11"]) {
        productTypeStr = @"周边游";
    }else if ([modelOrder.product_category isEqualToString:@"7"] || [modelOrder.product_category isEqualToString:@"-12"]) {
        productTypeStr = @"国内游";
    }else if ([modelOrder.product_category isEqualToString:@"8"] || [modelOrder.product_category isEqualToString:@"-13"]) {
        productTypeStr = @"出境游";
    }else if ([modelOrder.product_category isEqualToString:@"9"] || [modelOrder.product_category isEqualToString:@"-14"]) {
        productTypeStr = @"港澳台";
    }else if ([modelOrder.product_category isEqualToString:@"10"] || [modelOrder.product_category isEqualToString:@"-15"]) {
        productTypeStr = @"港澳台";
    }
    
    
    
    
    self.productTypeLab.frame = CGRectMake(M_LEFT_GAP, 10, [self returnTextCGRectText:productTypeStr textFont:12 cGSize:CGSizeMake(0, 20)].size.width, 20);
    self.productTypeLab.text = productTypeStr;
    self.line.frame = CGRectMake(ViewRight(_productTypeLab) + 10, 12, 0.5, 16);
    NSString * startTimeStr = @"";
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    startTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[modelOrder.setoff_time integerValue]]];
    self.startTimeLab.text = [NSString stringWithFormat:@"出发日期:%@", startTimeStr];
    self.startTimeLab.frame = CGRectMake(ViewRight(_productTypeLab) + 20, 10, [self returnTextCGRectText:_startTimeLab.text textFont:12 cGSize:CGSizeMake(0, 20)].size.width, 20);
    
    if (([modelOrder.pay_status isEqualToString:@"0"]) && ([modelOrder.order_status isEqualToString:@"90"] || [modelOrder.order_status isEqualToString:@"91"] || [modelOrder.order_status isEqualToString:@"92"]|| [modelOrder.order_status isEqualToString:@"12"])) {
        self.payStatus.text = @"[待确认]";

    } else if ([modelOrder.pay_status isEqualToString:@"0"] && ([modelOrder.order_status isEqualToString:@"0"] || [modelOrder.order_status isEqualToString:@"1"])) {
        
        self.payStatus.text = @"[待付款]";

    }  else if ([modelOrder.pay_status isEqualToString:@"1"] && [modelOrder.order_status isEqualToString:@"2"]) {
        
        self.payStatus.text = @"[已完成]";
        
    }else if ([modelOrder.pay_status isEqualToString:@"1"]){
        
        self.payStatus.text = @"[已付款]";
        
    } else if ([modelOrder.order_status isEqualToString:@"11"]) {
        
        self.payStatus.text = @"[已取消]";
        
    }
    
    [self.thumbImage sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:modelOrder.img]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    self.titleLab.text = [self judgeReturnString:modelOrder.product_name withReplaceString:@""];
    [self.titleLab sizeToFit];
    self.partnerLab.text = [NSString stringWithFormat:@"合伙人:%@", [self judgeReturnString:modelOrder.realname withReplaceString:@""]];
    self.commissionLab.text = [NSString stringWithFormat:@"电话:%@", [self judgeReturnString:modelOrder.phone withReplaceString:@""]];
    self.priceLab.text = [NSString stringWithFormat:@"¥%@", [self judgeReturnString:modelOrder.order_price withReplaceString:@""]];

}

- (UIView *)line {
    if (!_line) {
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = UIColorFromRGB(0x6f7378);
        [self.contentView addSubview:_line];
    }
    return _line;
}

- (void)setModelDEOrder:(orderModel *)modelDEOrder {
    
    
    NSString * productTypeStr = modelDEOrder.mark;
    self.productTypeLab.frame = CGRectMake(M_LEFT_GAP, 10, [self returnTextCGRectText:productTypeStr textFont:12 cGSize:CGSizeMake(0, 20)].size.width, 20);
    self.productTypeLab.text = productTypeStr;
    self.line.frame = CGRectMake(ViewRight(_productTypeLab) + 10, 12, 0.5, 16);
    NSString * startTimeStr = @"";
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    startTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[modelDEOrder.come_time integerValue]]];
    self.startTimeLab.text = [NSString stringWithFormat:@"预订时间:%@", startTimeStr];
    self.startTimeLab.frame = CGRectMake(ViewRight(_productTypeLab) + 20, 10, [self returnTextCGRectText:_startTimeLab.text textFont:12 cGSize:CGSizeMake(0, 20)].size.width, 20);
    
    if ([modelDEOrder.pay_status isEqualToString:@"0"] && [modelDEOrder.order_status isEqualToString:@"11"]) {
        self.payStatus.text = @"[已取消]";
        
    } else if ([modelDEOrder.pay_status isEqualToString:@"1"]) {
        self.payStatus.text = @"[已付款]";
        
    } else {
        self.payStatus.text = @"[待付款]";
    }
    
    [self.thumbImage sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:@""]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    self.titleLab.text = [self judgeReturnString:modelDEOrder.describe withReplaceString:@""];
    [self.titleLab sizeToFit];
    self.partnerLab.text = [NSString stringWithFormat:@"联系人:%@", [self judgeReturnString:modelDEOrder.contacts withReplaceString:@""]];
    self.commissionLab.text = [NSString stringWithFormat:@"电话:%@", [self judgeReturnString:modelDEOrder.phone withReplaceString:@""]];
    self.priceLab.text = [NSString stringWithFormat:@"¥%@", [self judgeReturnString:modelDEOrder.price withReplaceString:@""]];

}

@end
