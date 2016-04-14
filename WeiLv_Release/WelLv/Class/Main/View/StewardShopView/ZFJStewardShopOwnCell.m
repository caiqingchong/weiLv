//
//  ZFJStewardShopOwnCell.m
//  WelLv
//
//  Created by WeiLv on 15/10/14.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJStewardShopOwnCell.h"
#import "ZFJSteShopListTravelModel.h"
#import "ZFJSteShopListShipModel.h"
#import "ZFJSteShopListStudyTourModel.h"
#import "ZFJSteShopListVisaModel.h"

#define M_CELL_HEIGHT 100
#define M_GAP_LEFT 10
#define M_GAP_TOP 10
#define M_GAP 8
#define M_BUT_WIDTH 55
@implementation ZFJStewardShopOwnCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    self.thumbnai = [[UIImageView alloc] initWithFrame:CGRectMake(M_GAP_LEFT, M_GAP_TOP, M_CELL_HEIGHT - M_GAP_TOP * 2, M_CELL_HEIGHT - M_GAP_TOP * 2)];
    self.thumbnai.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.thumbnai.layer.cornerRadius = 5.0;
    self.thumbnai.layer.masksToBounds = YES;
    self.thumbnai.contentMode = UIViewContentModeScaleAspectFill;
    self.thumbnai.clipsToBounds = YES;
    [self.contentView addSubview:_thumbnai];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_thumbnai)+ M_GAP,5, windowContentWidth - 10-80-8-10,40)];
    //self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    //self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_titleLabel];
    
 
    self.priceLabel=[[UILabel alloc] initWithFrame:CGRectMake(ViewX(_titleLabel),M_GAP_TOP+ViewHeight(_thumbnai)/2.0+M_GAP,ViewWidth(_titleLabel)*2/3.0,ViewHeight(_thumbnai)/4.0)];
    [self.contentView addSubview:_priceLabel];
    
    
    self.commissionLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_priceLabel),ViewBelow(_thumbnai)-ViewRight(_thumbnai)/4.0+M_GAP,ViewWidth(_priceLabel),ViewHeight(_thumbnai)/4.0-M_GAP)];
    [self.contentView addSubview:_commissionLabel];
    
    
    
    
    
    self.distributionBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.distributionBut.frame = CGRectMake(windowContentWidth - (M_GAP_LEFT + M_BUT_WIDTH) , M_GAP_TOP + ViewHeight(_thumbnai) / 2.0 + M_GAP, M_BUT_WIDTH, ViewHeight(_thumbnai) / 2.0 - M_GAP);
    self.distributionBut.backgroundColor = TimeGreenColor;
    [self.distributionBut setTitle:@"分销" forState:UIControlStateNormal];
    [self.distributionBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.distributionBut.titleLabel.font = [UIFont systemFontOfSize:15];
    self.distributionBut.layer.cornerRadius = 3.0;
    self.distributionBut.layer.masksToBounds = YES;
    [self.contentView addSubview:_distributionBut];
    
}

- (void)setModelTravel:(ZFJSteShopListTravelModel *)modelTravel{
    [self.thumbnai sd_setImageWithURL:[NSURL URLWithString:[[WLSingletonClass defaultWLSingleton] wlJudgeThumbImageViewURLStr:modelTravel.thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    self.titleLabel.text = [self judgeReturnString:modelTravel.product_name withReplaceString:@""];
    self.titleLabel.numberOfLines = 0;
    self.commissionLabel.attributedText = [self commissionStr:[NSString stringWithFormat:@"%.2f", [[self judgeReturnString:[NSString stringWithFormat:@"%@", modelTravel.gj_commission] withReplaceString:@"0.00"] floatValue]]];
    self.priceLabel.attributedText = [self priceStr:[self judgeReturnString:[NSString stringWithFormat:@"%@", modelTravel.adult_price] withReplaceString:@""]];
    DLog(@"%@",modelTravel.sell_price);
    //[self.titleLabel sizeToFit];
}
- (void)setModelShip:(ZFJSteShopListShipModel *)modelShip {
    //DLog(@"%@",modelShip.picture);
    [self.thumbnai sd_setImageWithURL:[NSURL URLWithString:[[WLSingletonClass defaultWLSingleton] wlJudgeThumbImageViewURLStr:modelShip.thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    self.titleLabel.text = [self judgeReturnString:modelShip.product_name withReplaceString:@""];
    self.titleLabel.numberOfLines = 0;
   // [self.titleLabel sizeToFit];
}

- (void)setModelStudyTour:(ZFJSteShopListStudyTourModel *)modelStudyTour {
    [self.thumbnai sd_setImageWithURL:[NSURL URLWithString:[[WLSingletonClass defaultWLSingleton] wlJudgeThumbImageViewURLStr:modelStudyTour.thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    self.titleLabel.text = [self judgeReturnString:modelStudyTour.yoosure_name withReplaceString:@""];
    self.titleLabel.numberOfLines = 0;
    //[self.titleLabel sizeToFit];

    self.commissionLabel.attributedText = [self commissionStr:[self returnTwoNumStr:[self judgeReturnString:modelStudyTour.camper_rebate withReplaceString:@"0.00"]]];
    self.priceLabel.attributedText = [self priceStr:[self returnTwoNumStr:[self judgeReturnString:modelStudyTour.camper_price withReplaceString:@"0.00"]]];

}

- (void)setModelVisa:(ZFJSteShopListVisaModel *)modelVisa {
    [self.thumbnai sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:modelVisa.thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    self.titleLabel.text = [self judgeReturnString:modelVisa.product_name withReplaceString:@""];
    self.titleLabel.numberOfLines = 0;
    //[self.titleLabel sizeToFit];
    self.commissionLabel.attributedText = [self commissionStr:[self returnTwoNumStr:[self judgeReturnString:modelVisa.commission withReplaceString:@"0.00"]]];
    self.priceLabel.attributedText = [self priceStr:[self returnTwoNumStr:[self judgeReturnString:modelVisa.sell_price withReplaceString:@"0.00"]]];
    
}

- (UILabel *)partnerCommissionLab {
    if (!_partnerCommissionLab) {
        self.distributionBut.backgroundColor = UIColorFromRGB(0xff5b26);
        [self.distributionBut setTitle:@"取消" forState:UIControlStateNormal];
        [self.distributionBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.partnerCommissionLab = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_thumbnai)+ M_GAP,ViewBelow(_titleLabel), 100, ViewHeight(_commissionLabel))];
        [self.contentView addSubview:_partnerCommissionLab];
    }
    return _partnerCommissionLab;
}


- (NSAttributedString *)commissionStr:(NSString *)str {
    return [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#6F7378;font-size:12px>管家返佣:&nbsp;</span><span style=color:#FF5B26;font-size:12px>¥%@</span>", [self judgeReturnString:str withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
}

- (NSAttributedString *)priceStr:(NSString *)str {
    return [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#6F7378;font-size:12px>微旅价:&nbsp;</span><span style=color:#FF5B26;font-size:12px>¥%@</span>", [self judgeReturnString:str withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}


@end
