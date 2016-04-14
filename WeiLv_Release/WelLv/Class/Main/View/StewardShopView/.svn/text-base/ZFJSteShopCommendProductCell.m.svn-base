//
//  ZFJSteShopCommendProductCell.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopCommendProductCell.h"
#import "ZFJSteShopListTravelModel.h"

@implementation ZFJSteShopCommendProductCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    
    self.thumbImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(self), ViewWidth(self) * 220 / 352.0)];
    _thumbImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_thumbImageView];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(_thumbImageView), ViewWidth(self), 25)];
    self.titleLab.textColor = [UIColor blackColor];
    [self addSubview:_titleLab];
    
    self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(_titleLab), ViewWidth(self), 15)];
    self.priceLab.font =[UIFont systemFontOfSize:15];
    [self addSubview:_priceLab];
    
}

- (UILabel *)commisstionLab {
    if (!_commisstionLab) {
        self.commisstionLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(_priceLab), ViewWidth(self), 15)];
        self.commisstionLab.font = [UIFont systemFontOfSize:15];
        [self addSubview:_commisstionLab];
    }
    return _commisstionLab;
}
- (void)setModelTravel:(ZFJSteShopListTravelModel *)modelTravel {
    [self.thumbImageView sd_setImageWithURL:[NSURL URLWithString:[[WLSingletonClass defaultWLSingleton] wlJudgeThumbImageViewURLStr:modelTravel.thumb]] placeholderImage:[UIImage imageNamed:@"默认图4"]];
    
    self.titleLab.text = [self judgeReturnString:modelTravel.product_name withReplaceString:@""];
    
    self.priceLab.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#6F7378;font-size:14px>微旅价:</span><span style=color:#FF5B26;font-size:14px>¥%@</span>", [self judgeReturnString:modelTravel.adult_price withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    if ([[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteShop]) {
        if (modelTravel.partner_reward) {
            self.commisstionLab.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#6F7378;font-size:14px>分销佣金:</span><span style=color:#2ECD70;font-size:14px>¥%0.2f</span>", [modelTravel.partner_reward floatValue]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        }else{
            self.commisstionLab.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#6F7378;font-size:14px>分销佣金:</span><span style=color:#2ECD70;font-size:14px>¥%@</span>",@"0.00"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        }
        
       
    }else
    {
        self.commisstionLab.hidden=YES;
    }
   
}
@end
