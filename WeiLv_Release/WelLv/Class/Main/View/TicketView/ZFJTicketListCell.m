//
//  ZFJTicketListCell.m
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJTicketListCell.h"
#import "TicketListModel.h"

#define ICON_TOP 10
#define ICON_LEFT 15
#define ICON_WIDTH 75
#define WIDTH_GAP 10 //间距

@implementation ZFJTicketListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addCustomView];
    }
    return self;
}

- (void)addCustomView {
    self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(ICON_LEFT, ICON_TOP, ICON_WIDTH, ICON_WIDTH)];
    self.iconImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.iconImage.layer.cornerRadius = 5.0;
    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImage.clipsToBounds = YES;
    [self.contentView addSubview:_iconImage];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    
//    self.timeLabel = [[UILabel alloc] init];
//    self.timeLabel.font = [UIFont systemFontOfSize:15];
//    self.timeLabel.textColor = kColor(123, 174, 253);
//    [self.contentView addSubview:_timeLabel];
    
    
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.font = [UIFont systemFontOfSize:12];
    self.typeLabel.textColor = kColor(115, 115, 120);
    self.typeLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.typeLabel];
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.font = [UIFont systemFontOfSize:13];
    self.addressLabel.textColor = kColor(111, 115, 120);
    //[self.contentView addSubview:self.addressLabel];

    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = kColor(255, 102, 0);
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_priceLabel];
}

- (void)setModel:(TicketListModel *)model {
    
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[self judgeRetuRnImagesClass:[model.images objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    self.titleLabel.frame = CGRectMake(ViewRight(_iconImage) + WIDTH_GAP, ICON_TOP, windowContentWidth - ViewRight(_iconImage) - WIDTH_GAP * 2, ViewHeight(_iconImage) / 2);
    self.titleLabel.text = [self judgeReturnString:model.product_name withReplaceString:@" "];
    [self.titleLabel sizeToFit];
    
    //WithFrame:CGRectMake(windowContentWidth - 10 - 60, ViewBelow(self.iconImage) - 25, 60, 25)
    //NSLog(@"%@", model.start_price);
    //@"<span style=font-size:18px;color:#FF6600;>￥</span><span style=font-size:18px;color:#ff6600;>%@</span><span style=font-size:18px;color:#FF6600;></span><br />"
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", [self judgeReturnString:model.start_price withReplaceString:@"0.00"]];
 //   [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@", [self judgeReturnString:model.start_price withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.priceLabel.font = [UIFont systemFontOfSize:18];
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.textColor = kColor(255, 102, 0);
    [self.priceLabel sizeToFit];
    self.priceLabel.frame = CGRectMake(windowContentWidth - 10 - ViewWidth(self.priceLabel), ViewBelow(self.iconImage) - ViewHeight(self.priceLabel), ViewWidth(self.priceLabel), ViewHeight(self.priceLabel));
    /*
    NSString * timeStr = nil;
    if ([model.scenic_attach objectForKey:@"openTimes"]) {
        NSDictionary * dic = [self judgeRetuRnImagesClass:[[model.scenic_attach objectForKey:@"openTimes"] objectForKey:@"openTime"]];
        if ([dic isEqual:@""]) {
            timeStr = @"依景区具体规定";
        } else {
            if ( [dic objectForKey:@"sightStart"] || [dic objectForKey:@"sightEnd"]) {
                timeStr = [NSString stringWithFormat:@"%@-%@", [dic objectForKey:@"sightStart"], [dic objectForKey:@"sightEnd"]];
            } else if ([dic objectForKey:@"openTimeInfo"] || ![dic objectForKey:@"sightStart"]) {
                timeStr = [dic objectForKey:@"openTimeInfo"];
            }
            
        }
    } else {
        timeStr = [self judgeReturnString:model.openTime withReplaceString:@"依景区具体规定"];

    }
    self.timeLabel.text = timeStr;
    CGRect rect = [self returnTextCGRectText:timeStr textFont:15 cGSize:CGSizeMake(0, 25)];
    self.timeLabel.frame = CGRectMake(ViewRight(self.iconImage) + WIDTH_GAP, ViewBelow(self.iconImage) - 25, MIN(rect.size.width, ViewX(self.priceLabel) - ViewRight(self.iconImage) - WIDTH_GAP), 25);
    */

    
    
    NSString * addressStr = [NSString stringWithFormat:@"%@%@", [self judgeReturnString:model.place_province withReplaceString:@""], [self judgeReturnString:model.place_city withReplaceString:@""]];
    if ([model.place_province isEqualToString:model.place_city]) {
        addressStr = [self judgeReturnString:model.place_province withReplaceString:@""];
    }
    //self.addressLabel.text = [self judgeReturnString:[model.scenic_attach objectForKey:@"placeToAddr"] withReplaceString:@""];
    //CGFloat earnings = [model.sell_price floatValue]*0.04;[NSString stringWithFormat:@"返佣:¥%g", earnings];
    self.addressLabel.text = addressStr;
    self.addressLabel.frame = CGRectMake(ViewRight(self.iconImage) + WIDTH_GAP, ViewHeight(_iconImage) / 2 + ICON_TOP, ViewWidth(self) - ViewRight(self.iconImage) - WIDTH_GAP - ICON_LEFT, ViewHeight(_iconImage) / 4);
    NSString * typeStr = [NSString stringWithFormat:@"%@  %@", [self judgeReturnString:model.product_theme withReplaceString:@""], [self judgeReturnString:model.place_level withReplaceString:@""]];
    NSString *typeStrs=@"景区级别：";
    typeStr=[typeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![typeStr isEqual:@""])
    {
        typeStrs=[typeStrs stringByAppendingString:typeStr];
    }
    else
    {
        typeStrs=typeStr;
    }
    
    self.typeLabel.text = typeStrs;
    self.typeLabel.frame = CGRectMake(ViewRight(self.iconImage) + WIDTH_GAP, ViewBelow(self.addressLabel), ViewX(self.priceLabel) - ViewRight(self.iconImage) - WIDTH_GAP, ViewHeight(_iconImage) / 4);
    

}
/*
 NSDictionary * dic = [self judgeRetuRnImagesClass:[[model.scenic_attach objectForKey:@"openTimes"] objectForKey:@"openTime"]];
 NSString * timeStr = nil;
 if ([dic objectForKey:@"sightStart"] || [dic objectForKey:@"sightEnd"]) {
 timeStr = [NSString stringWithFormat:@"%@-%@", [dic objectForKey:@"sightStart"], [dic objectForKey:@"sightEnd"]];
 } else if ([dic objectForKey:@"openTimeInfo"] || ![dic objectForKey:@"sightStart"]) {
 timeStr = [dic objectForKey:@"openTimeInfo"];
 }
 
 self.timeLabel.text = timeStr;
 */

@end
