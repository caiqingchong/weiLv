//
//  ZFJSSDistributionShipCell.m
//  WelLv
//
//  Created by WeiLv on 15/10/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSSDistributionShipCell.h"
#import "ZFJSteShopDistributionTravelView.h"
#import "ZFJSSShipRoomModel.h"

@implementation ZFJSSDistributionShipCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    self.view = [[ZFJSteShopDistributionTravelView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 135)];
    [self.contentView addSubview:_view];
}


- (void)setModelShipRoom:(ZFJSSShipRoomModel *)modelShipRoom {
    self.view.titleLab.text = [self judgeReturnString:modelShipRoom.cabin_name withReplaceString:@""];
    self.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:modelShipRoom.room_price2 withReplaceString:@"0.00"]];
    self.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:modelShipRoom.butler_s withReplaceString:@"0.00"]];
    self.view.distributionLab.attributedText=[self attributedTextBlackAndRedTitleStr:@"分销" msgStr:[self judgeReturnString:modelShipRoom.partner_reward withReplaceString:@"0.00"]];
}
- (NSAttributedString *)attributedTextBlackAndRedTitleStr:(NSString *)titleStr msgStr:(NSString *)msgStr {
    return [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#6F7378;font-size:17px>%@:&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=color:#FF5B26;font-size:17px>¥%@</span>", titleStr, msgStr] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}


@end
