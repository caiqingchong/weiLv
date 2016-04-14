//
//  ZFJShipShoreTravelOneCell.m
//  WelLv
//
//  Created by zhangjie on 15/10/11.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipShoreTravelOneCell.h"
#import "ZFJShipDetailModel.h"

#define M_LEFT_GAP 15

@implementation ZFJShipShoreTravelOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    /*
    UIImageView * locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(M_LEFT_GAP, 0, 14, 16)];
    locationIcon.image = [UIImage imageNamed:@"日程"];
    [self.contentView addSubview:locationIcon];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(locationIcon), 0, windowContentWidth - ViewRight(locationIcon) - 15 - 16, 30)];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    */
    self.arrivalAndSail = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, windowContentWidth - 15 - 16, 50)];
    self.arrivalAndSail.numberOfLines = 0;
    [self.contentView addSubview:_arrivalAndSail];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_arrivalAndSail), ViewBelow(_arrivalAndSail), windowContentWidth - 15 - 16 , 100)];
    self.messageLabel.numberOfLines = 0;
    [self.contentView addSubview:self.messageLabel];
    
    self.eatAndLiveLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_eatAndLiveLabel];
}

- (void)setShoreTraveModel:(ZFJShoreTraveModel *)shoreTraveModel {
   
    self.arrivalAndSail.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:14px;background-color:#FFFFFF;color:#00CF83;>第%@天 ｜ %@</span><span style=background-color:#FFFFFF;></span>",  shoreTraveModel.arrival_time, shoreTraveModel.sail_time] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [self.arrivalAndSail sizeToFit];
    NSLog(@"%@", shoreTraveModel.detail);
    self.messageLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@", shoreTraveModel.detail] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.messageLabel.font = [UIFont systemFontOfSize:14];
    [self.messageLabel sizeToFit];
    
    //self.eatAndLiveLabel.attributedText = nil;
    self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), ViewBelow(_messageLabel));
    
}


@end
