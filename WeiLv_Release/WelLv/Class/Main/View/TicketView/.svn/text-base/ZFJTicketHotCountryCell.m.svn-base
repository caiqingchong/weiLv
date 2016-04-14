//
//  ZFJTicketHotCountryCell.m
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJTicketHotCountryCell.h"
#import "ZFJTicketHotCityModel.h"

#define M_ICONIMAGE_WIDTH 70
#define M_TITILELABEL_HEITH
@implementation ZFJTicketHotCountryCell

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, M_ICONIMAGE_WIDTH, M_ICONIMAGE_WIDTH)];
        self.iconImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_iconImage];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(_iconImage), M_ICONIMAGE_WIDTH, ViewHeight(self) - M_ICONIMAGE_WIDTH)];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setModel:(ZFJTicketHotCityModel *)model {
    
    /*
    NSString * imageURLStr = nil;
    if ([[model.images objectForKey:@"image"] isKindOfClass:[NSArray class]]) {
        NSArray * arr = [model.images objectForKey:@"image"];
        imageURLStr = [arr objectAtIndex:0];
    } else {
        imageURLStr = [model.images objectForKey:@"image"];
    }
     */
    /*
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[self judgeRetuRnImagesClass:[model.images objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    self.titleLabel.text = model.place_city;
    */
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:model.img]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    self.titleLabel.text = model.name;
}

@end
