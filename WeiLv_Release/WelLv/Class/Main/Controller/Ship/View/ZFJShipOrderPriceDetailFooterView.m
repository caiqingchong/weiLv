//
//  ZFJShipOrderPriceDetailFooterView.m
//  WelLv
//
//  Created by WeiLv on 15/9/24.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipOrderPriceDetailFooterView.h"

@implementation ZFJShipOrderPriceDetailFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addCustomView];
    }
    return self;
}
- (void)addCustomView {
    self.shoreTraveLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth / 2 - 0.25, 50)];
    self.shoreTraveLineLabel.numberOfLines = 0;
    self.shoreTraveLineLabel.font = [UIFont systemFontOfSize:15];
    self.shoreTraveLineLabel.textColor = [UIColor blackColor];
    self.shoreTraveLineLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_shoreTraveLineLabel];
    
    self.line = [[UIView alloc] initWithFrame:CGRectMake(ViewRight(_shoreTraveLineLabel) - 0.5, 0, 0.5, 50)];
    _line.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_line];
    
    self.personLabel = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth / 2 - 0.25, 0, windowContentWidth / 2, 50)];
    self.personLabel.numberOfLines = 0;
    self.personLabel.textColor = [UIColor blackColor];
    self.personLabel.font = [UIFont systemFontOfSize:15];
    self.personLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_personLabel];
}


@end
