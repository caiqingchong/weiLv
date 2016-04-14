//
//  ZFJShoreTraveTitleCell.m
//  WelLv
//
//  Created by WeiLv on 15/10/22.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShoreTraveTitleCell.h"

#define M_CELL_HEIGHT 50

@implementation ZFJShoreTraveTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, ViewWidth(self) - 105, M_CELL_HEIGHT)];
    //self.titleLabel.text = @"岸上观光线路A";
    self.titleLabel.textColor = UIColorFromRGB(0x6f7378);
    [self.contentView addSubview:_titleLabel];
    
    self.checkBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.checkBut.frame = CGRectMake(windowContentWidth - 65, 0, 65, M_CELL_HEIGHT);
    self.checkBut.backgroundColor = [UIColor orangeColor];
    [self.checkBut setTitle:@"查看" forState:UIControlStateNormal];
    self.checkBut.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.checkBut];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, M_CELL_HEIGHT - 0.5, windowContentWidth, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0x6f7378);
    [self.contentView addSubview:lineView];
    
}




@end
