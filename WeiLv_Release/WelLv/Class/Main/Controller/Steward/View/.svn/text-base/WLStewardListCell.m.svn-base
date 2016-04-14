//
//  WLStewardListCell.m
//  WelLv
//
//  Created by WeiLv on 15/12/1.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLStewardListCell.h"
#define M_CELL_HEIGHT 90
#define M_CELL_TOP_GAP 10
#define M_CELL_LEFT_GAP 15
#define M_CELL_GAP 10

@interface WLStewardListCell ()

@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIImageView * sexIcon;

@end

@implementation WLStewardListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self customView];
    }
    return self;
}

- (void)customView {
    WS(ws);
    self.headPortraitIcon = [[UIImageView alloc] init];
    self.headPortraitIcon.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_headPortraitIcon];
    [self.headPortraitIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(M_CELL_LEFT_GAP);
        make.top.equalTo(ws).with.offset(M_CELL_TOP_GAP);
        make.bottom.equalTo(ws).with.offset(-M_CELL_TOP_GAP);
        make.width.mas_equalTo(ws.headPortraitIcon.mas_height);
    }];
    self.headPortraitIcon.layer.cornerRadius = (M_CELL_HEIGHT - M_CELL_TOP_GAP * 2) /2.0;
    self.headPortraitIcon.layer.masksToBounds = YES;
    
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.textColor = UIColorFromRGB(0x2f2f2f);
    [self addSubview:_nameLab];
    
    self.serveCountLab = [[UILabel alloc] init];
    self.serveCountLab.textColor = UIColorFromRGB(0x57d5e);
    self.serveCountLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_serveCountLab];
    
    self.sellProductCountLab = [[UILabel alloc] init];
    self.sellProductCountLab.textColor = UIColorFromRGB(0x57d5e);
    self.sellProductCountLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_sellProductCountLab];
    
}

#pragma mark - 懒加载

- (UIView *)lineView {
    if (!_lineView) {
        WS(ws);
        self.lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.mas_bottom).with.offset(-0.5);
            make.width.equalTo(ws);
            make.centerX.equalTo(ws);
            make.height.mas_equalTo(0.5);
        }];
        self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _lineView;
}

@end
