//
//  ZFJShipShoreTravelTitleView.m
//  WelLv
//
//  Created by zhangjie on 15/10/11.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipShoreTravelTitleView.h"

@implementation ZFJShipShoreTravelTitleView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        UIImageView * iconImage= [[UIImageView alloc] initWithFrame:CGRectMake(5, (45 - 13) / 2, 13, 13)];
        //iconImage.backgroundColor = [UIColor grayColor];
        iconImage.image = [UIImage imageNamed:@"岸上观光"];
        [self.contentView addSubview:iconImage];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(iconImage) + 5, 0, windowContentWidth - 30 - 15 - 16 , 45)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectView:)];
        [self addGestureRecognizer:tap];

    }
    return self;
}

- (void)selectView:(id)send {
    if (self.section) {
        self.section();
    }
}

- (void)didSelectSectionView:(SelectSection)selectSection{
    self.section = selectSection;
}


@end
