//
//  GuoneiyouTableViewCell.m
//  Lvyou
//
//  Created by 赵冉 on 16/1/12.
//  Copyright © 2016年 赵冉. All rights reserved.
//

#import "GuoneiyouTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TravelAllHeader.h"
#define M_LEFT_WIDTH 15
#define M_TOP_WIDTH 10
#define M_GAP_WIDTH 10
#define M_CELL_HEIGHT 90
#define M_PRICELABEL_HEIGHT 25
#define windowContentWidth  ([[UIScreen mainScreen] bounds].size.width)

@interface GuoneiyouTableViewCell()
@property(nonatomic,weak)UILabel *la;
@property(nonatomic,strong)UILabel *payWayLabel;
    

@end
@implementation GuoneiyouTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI {
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, M_TOP_WIDTH, M_CELL_HEIGHT - M_TOP_WIDTH * 2, M_CELL_HEIGHT - M_TOP_WIDTH * 2)];
    self.iconImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.iconImageView.layer.cornerRadius = 5;
    self.iconImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.iconImageView];
    
    self.payWayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (M_CELL_HEIGHT - M_TOP_WIDTH * 2)/5*4, (M_CELL_HEIGHT - M_TOP_WIDTH * 2) / 4)];
    
    self.payWayLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    self.payWayLabel.textAlignment = NSTextAlignmentCenter;
    self.payWayLabel.textColor = [UIColor whiteColor];
    self.payWayLabel.font = [UIFont systemFontOfSize:9];
    [self.iconImageView addSubview:self.payWayLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_CELL_HEIGHT - M_TOP_WIDTH * 2 + 2 * M_LEFT_WIDTH, M_TOP_WIDTH / 2, windowContentWidth - M_LEFT_WIDTH * 2 - M_CELL_HEIGHT + M_TOP_WIDTH * 2 -M_LEFT_WIDTH, windowContentHeight / 16.6)];
    //self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_CELL_HEIGHT - M_TOP_WIDTH * 2 + 2 * M_LEFT_WIDTH, 0, windowContentWidth - M_LEFT_WIDTH * 2 - M_CELL_HEIGHT + M_TOP_WIDTH * 2 ,45)];
 
    self.titleLabel.baselineAdjustment = YES;
    self.titleLabel.baselineAdjustment = UIBaselineAdjustmentNone;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor colorWithRed:6/255.0 green:6/255.0 blue:6/255.0 alpha:1];
  
    self.titleLabel.font = [UIFont systemFontOfSize:14];
   
    [self.contentView addSubview:self.titleLabel];
    
 
    NSInteger dateLabelWidth;
 
    
    if (UISCREEN_HEIGHT == 667) {
        dateLabelWidth = 150;
    } else if (UISCREEN_HEIGHT == 736) {
        dateLabelWidth = 150;
    } else if (UISCREEN_HEIGHT < 569) {
        dateLabelWidth = 130;
    }
    
    
    self.Datalable = [[UILabel alloc] initWithFrame:CGRectMake(M_CELL_HEIGHT - M_TOP_WIDTH * 2 + 2 * M_LEFT_WIDTH, 60, dateLabelWidth, 20)];
    self.Datalable.lineBreakMode = NSLineBreakByTruncatingMiddle;
    self.Datalable.font = [UIFont systemFontOfSize:12];
    self.Datalable.textColor = [UIColor colorWithRed:161/255.0 green:161/255.0 blue:161/255.0 alpha:1];
    [self.contentView addSubview:self.Datalable];
    
    self.Returnpricelable = [[UILabel alloc]initWithFrame:CGRectMake(10, M_CELL_HEIGHT - M_TOP_WIDTH - 30 , windowContentWidth-20, windowContentWidth / 37.5)];
    
    self.Returnpricelable.textColor = [UIColor redColor];
    self.Returnpricelable.textAlignment = NSTextAlignmentRight;
    self.Returnpricelable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.Returnpricelable];
    
    
    self.pricelable = [[UILabel alloc]initWithFrame:CGRectMake(10, M_CELL_HEIGHT - M_TOP_WIDTH - 15, windowContentWidth-20, 20)];
    self.pricelable.textColor = [UIColor redColor];
    self.pricelable.textAlignment = NSTextAlignmentRight;
    self.pricelable.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.pricelable];

   }
- (void)config:(GuoneiyouModel *)model{
    //图片
    if ([model.thumb hasPrefix:@"http"]) {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    } else {
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",WLHTTP,model.thumb];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]placeholderImage:[UIImage imageNamed:@"默认图1"]];
    }
    
    _Returnpricelable.text = [NSString stringWithFormat:@"返佣:¥%.2f",[model.gj_adult_rebate floatValue]];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:_Returnpricelable.text];
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"返佣:"].location, [[noteStr string] rangeOfString:@"返佣:"].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:redRange];
    [_Returnpricelable setAttributedText:noteStr];
    //[_Returnpricelable sizeToFit];


    if ([model.pay_way isEqualToString:@"2"] || [model.parent_pay_way isEqualToString:@"2"]) {
        
        
        self.payWayLabel.text = @"确认后支付";
        
    }else{
        
        self.payWayLabel.text = @"直接支付";
    }
    
    _Returnpricelable.hidden = !_isShowReturnPrice;
    _la.hidden = !_isShowReturnPrice;
    _pricelable.text = [NSString stringWithFormat:@"¥%ld起",[model.adult_price integerValue]];
    _titleLabel.text = model.product_name;
}

@end
