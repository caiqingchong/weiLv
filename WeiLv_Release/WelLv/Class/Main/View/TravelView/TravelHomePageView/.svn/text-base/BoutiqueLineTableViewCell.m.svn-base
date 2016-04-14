
//
//  BoutiqueLineTableViewCell.m
//  WelLv
//
//  Created by 张子乾 on 16/1/11.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "BoutiqueLineTableViewCell.h"
#import "TravelAllHeader.h"


@interface BoutiqueLineTableViewCell()

@property (nonatomic,strong)TravelJPLineModel *model;

@end


@implementation BoutiqueLineTableViewCell

//线路图片
- (UIImageView *)lineImageView {
    if (_lineImageView == nil) {
        _lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, kLineImageViewHeight)];
        
    }
    return _lineImageView;
}

//线路名称
- (UILabel *)lineTitleLabel {
    if (_lineTitleLabel == nil) {
        _lineTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLineTitleLabelX, kLineTitleLabelY, UISCREEN_WIDTH, kLineTitleLabelTitleSize)];
        _lineTitleLabel.textColor = UIColorFromRGB(0x2f2f2f);
        if (UISCREEN_HEIGHT < 667) {
            _lineTitleLabel.font = [UIFont systemFontOfSize:kLineTitleLabelTitleSize5];
        } else {
            _lineTitleLabel.font = [UIFont systemFontOfSize:kLineTitleLabelTitleSize];
        }
    }
    return _lineTitleLabel;
}

//标签一
- (UILabel *)firstTagLabel {
    if (_firstTagLabel == nil) {
        
        if (UISCREEN_HEIGHT < 667) {
            _firstTagLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLineTitleLabelX, CGRectGetMaxY(_lineTitleLabel.frame) + 25 / 2, kTagLabelWidth5, kTagLabelHeight5)];
        } else {
            
            _firstTagLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLineTitleLabelX, CGRectGetMaxY(_lineTitleLabel.frame) + 25 / 2, kTagLabelWidth, kTagLabelHeight)];
        }
        _firstTagLabel.layer.borderColor = [UIColor orangeColor].CGColor;
        _firstTagLabel.layer.borderWidth = 1.0;
        _firstTagLabel.layer.masksToBounds = YES;
        _firstTagLabel.layer.cornerRadius = 2.f;
        _firstTagLabel.font = [UIFont systemFontOfSize:kProductTagTextSize];
        _firstTagLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _firstTagLabel;
}

//标签二
- (UILabel *)secondTagLabel {
    if (_secondTagLabel == nil) {
        if (UISCREEN_HEIGHT < 667) {
            _secondTagLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_firstTagLabel.frame) + 8, CGRectGetMaxY(_lineTitleLabel.frame) + 25 / 2, kTagLabelWidth5, kTagLabelHeight5)];
        } else {
            _secondTagLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_firstTagLabel.frame) + 8, CGRectGetMaxY(_lineTitleLabel.frame) + 25 / 2, kTagLabelWidth, kTagLabelHeight)];
        }
        _secondTagLabel.layer.borderColor = [UIColor orangeColor].CGColor;
        _secondTagLabel.layer.borderWidth = 1.0;
        _secondTagLabel.layer.masksToBounds = YES;
        _secondTagLabel.layer.cornerRadius = 2.f;
        _secondTagLabel.font = [UIFont systemFontOfSize:kProductTagTextSize];
        _secondTagLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _secondTagLabel;
}

//微旅价
- (UILabel *)weiLvPriceLabel {
    if (_weiLvPriceLabel == nil) {
        //        if (UISCREEN_HEIGHT < 667) {
        //        _weiLvPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake( kWeiLvPriceLabelX5 , kWeiLvPriceLabelY, kWeiLvPriceLabelWidth, kWeiLvPriceLabelHeight)];
        //        } else {
        //        _weiLvPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake( kWeiLvPriceLabelX , kWeiLvPriceLabelY, kWeiLvPriceLabelWidth, kWeiLvPriceLabelHeight)];
        //        }
        //        _weiLvPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWeiLvPriceLabelX, CGRectGetMaxY(_firstTagLabel.frame)+kWeiLvPriceLabelDistance, kWeiLvPriceLabelWidth, kWeiLvPriceLabelHeight)];
        
        if (!_model.travel_tag || [_model.travel_tag isEqualToString:@""]) {
            _weiLvPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake( kLineTitleLabelX ,
                                                                        kLineTitleLabelY + kLineTitleLabelTitleSize + 20, kWeiLvPriceLabelWidth, kWeiLvPriceLabelHeight)];
        }else{
            
            _weiLvPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake( kLineTitleLabelX , CGRectGetMaxY(_firstTagLabel.frame) + kWeiLvPriceLabelDistance, kWeiLvPriceLabelWidth, kWeiLvPriceLabelHeight)];
            
        }
        
        
        
        _weiLvPriceLabel.text = @"微旅价:";
        
        if (UISCREEN_HEIGHT == 667) {
            _weiLvPriceLabel.font = [UIFont systemFontOfSize:13];
        } else {
            _weiLvPriceLabel.font = [UIFont systemFontOfSize:kWeiLvPriceLabelTitleSize];
        }
        _weiLvPriceLabel.textColor = [UIColor orangeColor];
        
    }
    return _weiLvPriceLabel;
}

//价格
- (UILabel *)priceLabel {
    if (_priceLabel == nil) {
        
        if(!_model.travel_tag || [_model.travel_tag isEqualToString:@""]){
         _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_weiLvPriceLabel.frame), kLineTitleLabelY + kLineTitleLabelTitleSize + 20, kPriceLabelWidth, kWeiLvPriceLabelHeight)];
        }else{
         _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_weiLvPriceLabel.frame), kWeiLvPriceLabelY, kPriceLabelWidth, kWeiLvPriceLabelHeight)];
        }

        _priceLabel.textColor = [UIColor orangeColor];
        if (UISCREEN_HEIGHT == 667) {
            _priceLabel.font = [UIFont systemFontOfSize:18];
        } else {
            _priceLabel.font = [UIFont systemFontOfSize:kWeiLvPriceLabelSize];
        }
        _priceLabel.font = [UIFont systemFontOfSize:kWeiLvPriceLabelSize];
        //        _priceLabel.backgroundColor = [UIColor yellowColor];
    }
    return _priceLabel;
}

//佣金价格
- (UILabel *)commissionLabel {
    if (_commissionLabel == nil) {
        if (UISCREEN_HEIGHT < 667) {
            _commissionLabel = [[UILabel alloc]initWithFrame:CGRectMake( CGRectGetMaxX(_priceLabel.frame), kCommissionLabelY-25, 100, kWeiLvPriceLabelHeight)];
        } else {
            _commissionLabel = [[UILabel alloc]initWithFrame:CGRectMake( CGRectGetMaxX(_priceLabel.frame) + 10, kCommissionLabelY-5, 100, kWeiLvPriceLabelHeight)];
        }
        _commissionLabel.backgroundColor = [UIColor colorWithRed:129/255.0 green:214/255.0 blue:205/255.0 alpha:1.0];
        if (UISCREEN_HEIGHT < 667) {
            _commissionLabel.font = [UIFont systemFontOfSize:13];
        } else {
            _commissionLabel.font = [UIFont systemFontOfSize:kCommissionTitleSize];
        }
        _commissionLabel.textColor = [UIColor whiteColor];
        _commissionLabel.layer.masksToBounds = YES;
        _commissionLabel.layer.cornerRadius = 10;
    }
    return _commissionLabel;
}

//立即抢购
- (UIImageView *)buyImageView {
    if (_buyImageView == nil) {
        if (UISCREEN_HEIGHT < 667) {
            if (!_model.travel_tag || [_model.travel_tag isEqualToString:@""]) {
              _buyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH - 75, CGRectGetMinY(self.priceLabel.frame) - 5, 70, 25)];
            }else{
              _buyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH - 75, CGRectGetMinY(self.priceLabel.frame) - 5, 70, 25)];
            }

        } else {
            
            if (!_model.travel_tag || [_model.travel_tag isEqualToString:@""]) {
            _buyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH - 90, CGRectGetMinY(self.priceLabel.frame) - 5, 80, 30)];
                DLog(@"%@",NSStringFromCGRect(_buyImageView.frame));
            }else{
            _buyImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH - 90, CGRectGetMinY(self.priceLabel.frame)- 5, 80, 30)];
            }

             DLog(@"%@",NSStringFromCGRect(_buyImageView.frame));
        }
        
        _buyImageView.backgroundColor = [UIColor orangeColor];
        _buyImageView.image = [UIImage imageNamed:@"立即抢购"];
        _buyImageView.layer.masksToBounds = YES;
        _buyImageView.layer.cornerRadius = 2.f;
    }
    return _buyImageView;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self.contentView addSubview:self.lineImageView];
//        [self.contentView addSubview:self.lineTitleLabel];
//        [self.contentView addSubview:self.firstTagLabel];
//        [self.contentView addSubview:self.secondTagLabel];
//        [self.contentView addSubview:self.weiLvPriceLabel];
//        [self.contentView addSubview:self.priceLabel];
//        [self.contentView addSubview:self.commissionLabel];
//        [self.contentView addSubview:self.buyImageView];
    }
    return self;
}

//赋值方法实现
- (void)setDataFromModel:(TravelJPLineModel *)model {
    
    self.model = model;
    [self.contentView addSubview:self.lineImageView];
    [self.contentView addSubview:self.lineTitleLabel];
    [self.contentView addSubview:self.firstTagLabel];
    [self.contentView addSubview:self.secondTagLabel];
    [self.contentView addSubview:self.weiLvPriceLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.commissionLabel];
    [self.contentView addSubview:self.buyImageView];
    
    

    //标题
    NSString *titleStr = [NSString stringWithFormat:@"<%@>",model.product_name];
    _lineTitleLabel.text = titleStr;
    
    //图片
    if ([model.picture hasPrefix:@"http"]) {
        [_lineImageView sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"默认图4"]];
    } else {
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",WLHTTP,model.picture];
        [_lineImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]placeholderImage:[UIImage imageNamed:@"默认图4"]];
    }
    //标签
    if (!model.travel_tag || [model.travel_tag isEqualToString:@""]) {
        _firstTagLabel.hidden = YES;
        _secondTagLabel.hidden = YES;
        
    } else {
        
        NSString *tagStr = model.travel_tag;
        NSArray *tagArray = [tagStr componentsSeparatedByString:@","];
        
        if (tagArray.count > 1) {
            _firstTagLabel.text = tagArray[0];
            _firstTagLabel.textColor = [UIColor orangeColor];
            
            _secondTagLabel.text = tagArray[1];
            _secondTagLabel.textColor = [UIColor orangeColor];
        } else {
            _firstTagLabel.text = tagArray[0];
            _firstTagLabel.textColor = [UIColor orangeColor];
            _secondTagLabel.hidden = YES;
        }
    }
    
    
    //价格
    NSString *priceStr = [NSString stringWithFormat:@"¥%.2f",[model.adult_price floatValue]];
    _priceLabel.text = priceStr;
    
    //    //返佣
    //
    //    NSString *commsionStr = [NSString stringWithFormat:@"返佣:%@",model.gj_adult_rebate];
    //    CGSize size = [commsionStr sizeWithFont:_commissionLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, _commissionLabel.frame.size.height)];
    //    [_commissionLabel setFrame:CGRectMake(CGRectGetMaxX(_priceLabel.frame) + 10, CGRectGetMinY(_priceLabel.frame), size.width, 20)];
    //    _commissionLabel.text = commsionStr;
    
    

    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

