//
//  WLStewardDetailCell.m
//  WelLv
//
//  Created by WeiLv on 15/12/1.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLStewardDetailCell.h"
#define M_CELL_HEIGHT 45
#define M_CELL_TOP_GAP 10
#define M_CELL_LEFT_GAP 15
#define M_CELL_GAP 10

@interface WLStewardDetailCell ()

@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIImageView * goIcon;

@end

@implementation WLStewardDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.width = windowContentWidth;
        self.height = M_CELL_HEIGHT;
        self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}

#pragma mark - 懒加载

- (UIImageView *)iconImage {
    if (!_iconImage) {
        self.iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(M_CELL_LEFT_GAP, ((M_CELL_HEIGHT- 20) / 2.0), 20, 20)];
        self.iconImage.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImage.clipsToBounds = YES;
        [self addSubview:_iconImage];
//        WS(ws);
//        [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(ws).with.offset(M_CELL_LEFT_GAP);
//            make.top.mas_equalTo(((M_CELL_HEIGHT- 20) / 2.0));
//            make.size.mas_equalTo(CGSizeMake(20, 20));
//        }];
    }
    return _iconImage;
}

- (UILabel *)msgLab {
    if (!_msgLab) {
        self.msgLab = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLab.right + M_CELL_LEFT_GAP, 0, 0, M_CELL_HEIGHT)];
        self.msgLab.textColor = UIColorFromRGB(0x6f7378);
        self.msgLab.numberOfLines = 0;
        [self addSubview:_msgLab];
//        WS(ws);
//        [self.msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(ws.titleLab.mas_right).with.offset(15);
//            make.top.equalTo(ws);
//            make.right.equalTo(ws).with.offset(-30);
//        }];
        
    }
   
    return _msgLab;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImage.right + M_CELL_LEFT_GAP, 0, 0, M_CELL_HEIGHT)];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.textColor = [UIColor blackColor];
        [self addSubview:_titleLab];
//        WS(ws);
//        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(ws.iconImage.mas_right).with.offset(M_CELL_GAP);
//            make.top.equalTo(ws);
//            make.height.mas_equalTo(M_CELL_HEIGHT);
//        }];
    }
    
      return _titleLab;
}
/*
- (void)setTitleStr:(NSString *)titleStr {
    WS(ws);
    CGFloat titleWidth = [self returnTextCGRectText:titleStr textFont:18 cGSize:CGSizeMake(0, self.titleLab.height)].size.width;
    self.titleLab.text = titleStr;
    self.titleLab.backgroundColor = [UIColor orangeColor];
//    self.titleLab.width = titleWidth;
    [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(titleWidth);

    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        //ws.titleLab.text = titleStr;
//        make.left.equalTo(ws.iconImage.mas_right).with.offset(M_CELL_GAP);
//        make.top.equalTo(ws);
//        make.height.mas_equalTo(M_CELL_HEIGHT);
        make.width.mas_equalTo(titleWidth);

    }];
     

}

- (void)setMsgStr:(NSString *)msgStr {
    WS(ws);
    _msgStr = msgStr;
    self.msgLab.text = msgStr;
    CGFloat msgHeight = [self returnTextCGRectText:msgStr textFont:18 cGSize:CGSizeMake(self.right - 30 - self.titleLab.right + M_CELL_GAP, 0)].size.height;
    NSLog(@"height === %g", msgHeight);
    if (msgHeight > self.height) {
//        self.height = msgHeight + 5;
//        self.msgLab.height = msgHeight;
//        self.msgLab.text = msgStr;
        [self.msgLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(msgHeight);
            ws.height = msgHeight + 5;
        }];
    } else {
//        self.height = M_CELL_HEIGHT;
//        self.msgLab.height = M_CELL_HEIGHT;
        [self.msgLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(M_CELL_HEIGHT);
        }];
    }
}
*/
- (UIView *)lineView {
    if (!_lineView) {
        WS(ws);
        self.lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws);
            make.width.equalTo(ws);
            make.bottom.equalTo(ws).with.offset(-0.5);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _lineView;
}



- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLab.text = titleStr;
    CGFloat titleWidth = [self returnTextCGRectText:titleStr textFont:18 cGSize:CGSizeMake(0, self.titleLab.height)].size.width;
    self.titleLab.width = titleWidth;
    
}

- (void)setMsgStr:(NSString *)msgStr {
    _msgStr = msgStr;
    self.msgLab.text = msgStr;
    CGFloat msgHeight = [self returnTextCGRectText:msgStr textFont:18 cGSize:CGSizeMake(self.right - 50 - self.titleLab.right + M_CELL_GAP, 0)].size.height;
    self.height =  msgHeight > M_CELL_HEIGHT ? (msgHeight) : M_CELL_HEIGHT;
    self.msgLab.height = self.height;
    self.msgLab.width = self.right - 50 - self.titleLab.right + M_CELL_GAP;
}
@end

@implementation WLStewardDetailCellModel



@end