//
//  ZFJShipItineraryDayCell.m
//  WelLv
//
//  Created by WeiLv on 15/10/10.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipItineraryDayCell.h"
#import "ZFJShipDetailModel.h"
#import "IconAndTitleView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define M_LEFT_GAP 15

@interface ZFJShipItineraryDayCell ()
@property (nonatomic, strong) UILabel * breakfastLabel;
@property (nonatomic, strong) UILabel * lunchLabel;
@property (nonatomic, strong) UILabel * dinnerLabel;
@property (nonatomic, strong) UILabel * roomLabel;
@property (nonatomic, strong) NSArray * albumArr;

@end

@implementation ZFJShipItineraryDayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //[self customView];
        [self addNewCustomView];
    }
    return self;
}

- (void)addNewCustomView {
    
    UIImageView * dayIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 70, 30)];
    dayIcon.image = [UIImage imageNamed:@"圆角矩形"];
    [self.contentView addSubview:dayIcon];
    self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 2.5, 50, 25)];
    self.dayLabel.font = [UIFont systemFontOfSize:16];
    self.dayLabel.textColor = [UIColor whiteColor];
    self.dayLabel.text = @"第一天";
    [dayIcon addSubview:_dayLabel];
    
    
    
    self.addressLineView = [[UIView alloc] initWithFrame:CGRectMake(40, 15, 90, 30)];
    self.addressLineView.layer.cornerRadius = 15;
    self.addressLineView.layer.masksToBounds = YES;
    self.addressLineView.layer.borderWidth = 1.0;
    self.addressLineView.layer.borderColor = UIColorFromRGB(0x2bd999).CGColor;
    [self.contentView addSubview:_addressLineView];
    
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(dayIcon) + 5, ViewY(_addressLineView), 40, ViewHeight(_addressLineView))];
//    self.addressLabel.layer.cornerRadius = 15;
//    self.addressLabel.layer.masksToBounds = YES;
//    self.addressLabel.layer.borderWidth = 1.0;
//    self.addressLabel.layer.borderColor = UIColorFromRGB(0x2bd999).CGColor;
    self.addressLabel.font = [UIFont systemFontOfSize:15];
    self.addressLabel.textAlignment = NSTextAlignmentCenter;
    self.addressLabel.text = @"上海";
    [self.contentView addSubview:_addressLabel];
    [self.contentView addSubview:dayIcon];
    
    self.timeLabel = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewBelow(dayIcon) + 5, windowContentWidth, 25) iconImageName:@"ship_Itinerary_time" titleLabel:@"航程：17:00出发"];
    [self.contentView addSubview:_timeLabel];
    
    self.shipNameLabel = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewBelow(_timeLabel), windowContentWidth, 25) iconImageName:@"ship_Itinerary_ship_name" titleLabel:@"海洋量子号邮轮"];
    [self.contentView addSubview:_shipNameLabel];
    
    self.eatAndLiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(_shipNameLabel), windowContentWidth, 50)];
    UIImageView *eatIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, (25 - 8) / 2, 10, 10)];
    eatIcon.image = [UIImage imageNamed:@"lauch"];
    [_eatAndLiveLabel addSubview:eatIcon];
    
    self.breakfastLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(eatIcon) + 5, 0, (ViewWidth(_eatAndLiveLabel) - (ViewRight(eatIcon) + 5)) / 3.0, 25)];
    self.breakfastLabel.font = [UIFont systemFontOfSize:14];
    self.breakfastLabel.textColor = [UIColor orangeColor];
    [_eatAndLiveLabel addSubview:_breakfastLabel];
    
    self.lunchLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_breakfastLabel) , 0, (ViewWidth(_eatAndLiveLabel) - (ViewRight(eatIcon) + 5)) / 3.0, 25)];
    self.lunchLabel.font = [UIFont systemFontOfSize:14];
    self.lunchLabel.textColor = [UIColor orangeColor];
    [_eatAndLiveLabel addSubview:_lunchLabel];
    
    self.dinnerLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_lunchLabel) , 0, (ViewWidth(_eatAndLiveLabel) - (ViewRight(eatIcon) + 5)) / 3.0, 25)];
    self.dinnerLabel.font = [UIFont systemFontOfSize:14];
    self.dinnerLabel.textColor = [UIColor orangeColor];
    [_eatAndLiveLabel addSubview:_dinnerLabel];

    
    
    UIImageView * romeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25 + (25 - 9.5) / 2, 11.5, 9.5)];
    romeIcon.image = [UIImage imageNamed:@"bed"];
    [_eatAndLiveLabel addSubview:romeIcon];
    
    self.roomLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(romeIcon) + 5, 25, ViewWidth(_eatAndLiveLabel) - (ViewRight(romeIcon) + 5), 25)];
    self.roomLabel.text = @"住宿：邮轮";
    self.roomLabel.font = [UIFont systemFontOfSize:14];
    self.roomLabel.textColor = [UIColor orangeColor];
    [_eatAndLiveLabel addSubview:_roomLabel];
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(_eatAndLiveLabel) - 0.5, windowContentWidth, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0x6f7378);
    [_eatAndLiveLabel addSubview:lineView];
    [self.contentView addSubview:_eatAndLiveLabel];
    
}


- (void)customView {
    UIImageView * locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(M_LEFT_GAP, 0, 14, 16)];
    locationIcon.image = [UIImage imageNamed:@"日程"];
    [self.contentView addSubview:locationIcon];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(M_LEFT_GAP + 6.5, ViewBelow(locationIcon), 0.5, ViewHeight(self) - ViewBelow(locationIcon))];
    _lineView.backgroundColor = TimeGreenColor;
    [self.contentView addSubview:_lineView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(locationIcon), 0, windowContentWidth - ViewRight(locationIcon), 30)];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(_titleLabel), ViewBelow(_titleLabel), ViewWidth(_titleLabel), 100)];
    self.messageLabel.numberOfLines = 0;
    [self.contentView addSubview:self.messageLabel];
    
    self.eatAndLiveLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_eatAndLiveLabel];
    
}
/*
- (void)setShipItineraryModel:(ZFJshipSchedule *)shipItineraryModel {
    self.titleLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:14px;background-color:#FFFFFF;color:#00CF83;>第%@天 ｜ %@</span><span style=background-color:#FFFFFF;></span>", shipItineraryModel.day, shipItineraryModel.title] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [self.titleLabel sizeToFit];
    
    self.messageLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@", shipItineraryModel.detail] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.messageLabel.font = [UIFont systemFontOfSize:14];
    [self.messageLabel sizeToFit];
    
    
    self.lineView.frame = CGRectMake(ViewX(_lineView), ViewY(_lineView), ViewWidth(_lineView), ViewBelow(_messageLabel)-  ViewY(_lineView));
    self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), ViewBelow(_messageLabel));
}
*/

- (void)setShipItineraryModel:(ZFJshipSchedule *)shipItineraryModel {

    self.dayLabel.text = [NSString stringWithFormat:@"第%@天", shipItineraryModel.day];
    
    NSString *breakfastStr = @"";
    NSString *lunchStr = @"";
    NSString *dinnerStr = @"";
    
    if ([shipItineraryModel.breakfast isEqual:@"0"]) {
        breakfastStr = @"早餐: 自理";
    }else if ([shipItineraryModel.breakfast isEqual:@"1"]){
        breakfastStr = @"早餐: 含餐";
    }
    if ([shipItineraryModel.lunch isEqual:@"0"]) {
        lunchStr = @"午餐: 自理";
    }else if ([shipItineraryModel.lunch isEqual:@"1"]){
        lunchStr = @"午餐: 含餐";
    }
    if ([shipItineraryModel.dinner isEqual:@"0"]) {
        dinnerStr = @"晚餐: 自理";
    }else if ([shipItineraryModel.dinner isEqual:@"1"]){
        dinnerStr = @"晚餐: 含餐";
    }
    
    self.breakfastLabel.text = breakfastStr;
    self.lunchLabel.text = lunchStr;
    self.dinnerLabel.text = dinnerStr;
    
    
    
    //NSLog(@"album = %@", shipItineraryModel.album);
    if ([shipItineraryModel.album isKindOfClass:[NSArray class]]) {
        self.albumArr = shipItineraryModel.album;
        NSInteger imageCount = MIN(2, self.albumArr.count);
        for (int i = 0; i < imageCount; i++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + ((windowContentWidth - 30) / 2.0 + 10) * (i % 2), ViewBelow(_shipNameLabel) + 5 , (windowContentWidth - 30) / 2.0, (windowContentWidth - 30) / 2.0 / 1.77)];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBigImage:)];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100 + i;
            imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            //NSLog(@"%@", [[albumArr objectAtIndex:i] objectForKey:@"picture"]);
            //i / 2 > (i - 1) / 2 ? i / 2 :( i / 2 - 1);
            //+ (i / 2.0 > i / 2 ? i / 2 :( i / 2 + 1)) * ((windowContentWidth - 40) / 2.0 / 1.77 + 10)
            //+ (i / 2 > (i - 1) / 2 ? i / 2 :( i / 2 - 1)) * ((windowContentWidth - 30) / 2.0 / 1.77 + 10)
            NSString *imageUrl = self.albumArr[i][@"picture"];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:imageUrl]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
            [self.contentView addSubview:imageView];

        }
        UIView * tempView = [self viewWithTag:100 + imageCount];
        self.eatAndLiveLabel.frame = CGRectMake(ViewX(_eatAndLiveLabel), ViewBelow(_shipNameLabel) + (windowContentWidth - 30) / 2.0 / 1.77 + 5, ViewWidth(_eatAndLiveLabel), ViewHeight(_eatAndLiveLabel));
    }
    
    self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), ViewBelow(_eatAndLiveLabel));
}

- (void)clickBigImage:(UIGestureRecognizer *)tap {
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [self.albumArr count]];
    NSInteger imageCount = MIN(2, self.albumArr.count);
    for (int i = 0; i < imageCount; i++) {
        // 替换为中等尺寸图片
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: [NSString stringWithFormat:@"%@/%@", WLHTTP, [[self.albumArr objectAtIndex:i] objectForKey:@"picture"]] ]; // 图片路径
        UIImageView * imageView = (UIImageView *)[self viewWithTag: 100  + i];
        photo.srcImageView = imageView;
        [photos addObject:photo];
    }
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = photos; // 设置所有的图片
    NSInteger tapImageTag = tap.view.tag - 100;
    browser.currentPhotoIndex = tapImageTag;
    [browser show];
}

@end
