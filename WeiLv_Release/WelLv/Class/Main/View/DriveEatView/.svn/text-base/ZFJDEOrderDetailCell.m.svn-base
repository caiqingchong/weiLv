//
//  ZFJDEOrderDetailCell.m
//  WelLv
//
//  Created by WeiLv on 15/11/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJDEOrderDetailCell.h"

#define M_CELL_HEIGHT 50
#define M_LEFT_GAP 10
@interface ZFJDEOrderDetailCell ()


@end

@implementation ZFJDEOrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setOrderStyle:(ZFJDEOrderStyle)orderStyle {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (orderStyle) {
        case ZFJDEOrderStyleIconTitleCountPrice:
        {
            if (_callIcon) {
                [self.callIcon removeFromSuperview];
            }
            [self.contentView addSubview:self.goodsIcon];
            self.titleLab.frame = CGRectMake(ViewRight(self.goodsIcon) + 5, 0, windowContentWidth  * 2 / 3.0, M_CELL_HEIGHT);
            self.countLab.frame = CGRectMake(ViewRight(_titleLab), 0, windowContentWidth / 12.0, M_CELL_HEIGHT);
            self.countLab.adjustsFontSizeToFitWidth = YES;
            [self.contentView addSubview:self.countLab];
            self.msgLab.frame = CGRectMake(ViewRight(_titleLab) + windowContentWidth / 12.0, 0, (windowContentWidth - (ViewRight(_titleLab) + windowContentWidth / 12.0)) - M_LEFT_GAP, M_CELL_HEIGHT);
            self.msgLab.textAlignment = NSTextAlignmentRight;
            self.msgLab.textColor = M_MIAN_RED_CORLOR;
            self.msgLab.adjustsFontSizeToFitWidth = YES;
            self.msgLab.numberOfLines = 1;
            self.lineView.frame = CGRectMake(20, M_CELL_HEIGHT - 0.5, windowContentWidth - 20, 0.5);
        }
            break;
        case ZFJDEOrderStyleTitleIconMsg:
        {
            if (_goodsIcon) {
                [self.goodsIcon removeFromSuperview];
                [self.countLab removeFromSuperview];
            }
            self.titleLab.frame = CGRectMake(M_LEFT_GAP, 0, [self returnTextCGRectText:@"手机号" textFont:17 cGSize:CGSizeMake(0, M_CELL_HEIGHT)].size.width, M_CELL_HEIGHT);
            self.msgLab.adjustsFontSizeToFitWidth = NO;
            CGFloat msgWidth = [self returnTextCGRectText:@"18236925230" textFont:17 cGSize:CGSizeMake(0, M_CELL_HEIGHT)].size.width;
            self.msgLab.frame = CGRectMake(windowContentWidth - M_LEFT_GAP - msgWidth,
                                           0,
                                           msgWidth,
                                           M_CELL_HEIGHT);
            self.msgLab.textAlignment = NSTextAlignmentRight;
            self.msgLab.textColor = M_MIAN_GRAY_CORLOR;
            self.msgLab.numberOfLines = 1;
            [self.contentView addSubview:self.callIcon];
            self.lineView.frame = CGRectMake(0, M_CELL_HEIGHT - 0.5, windowContentWidth, 0.5);
        }
            break;
        case ZFJDEOrderStyleTitleMsg:
        {
            if (_goodsIcon) {
                [self.goodsIcon removeFromSuperview];
                [self.countLab removeFromSuperview];
            }
            if (_callIcon) {
                [self.callIcon removeFromSuperview];
            }
            self.titleLab.frame = CGRectMake(M_LEFT_GAP, 0, [self returnTextCGRectText:@"就餐时间" textFont:17 cGSize:CGSizeMake(0, M_CELL_HEIGHT)].size.width, M_CELL_HEIGHT);
            
//            self.msgLab.frame = CGRectMake(M_LEFT_GAP, ViewBelow(_titleLab), windowContentWidth - M_LEFT_GAP * 2, 45);
//            CGRect rect = self.frame;
//            rect.size.height = ViewBelow(_msgLab);
//            self.frame = rect;
//            self.msgLab.textAlignment = NSTextAlignmentLeft;
//            self.msgLab.textColor = M_MIAN_GRAY_CORLOR;
//            self.lineView.frame = CGRectMake(0, ViewHeight(self) - 0.5, windowContentWidth, 0.5);

        }
            break;
        case ZFJDEOrderStyleTitleOneMsg:
        {
            if (_goodsIcon) {
                [self.goodsIcon removeFromSuperview];
                [self.countLab removeFromSuperview];
            }
            if (_callIcon) {
                [self.callIcon removeFromSuperview];
            }
            self.titleLab.frame = CGRectMake(M_LEFT_GAP, 0, [self returnTextCGRectText:@"就餐时间" textFont:17 cGSize:CGSizeMake(0, M_CELL_HEIGHT)].size.width, M_CELL_HEIGHT);
            self.msgLab.frame = CGRectMake(ViewRight(_titleLab), 0, windowContentWidth - ViewRight(_titleLab) - M_LEFT_GAP, M_CELL_HEIGHT);
            self.msgLab.textAlignment = NSTextAlignmentRight;
            self.msgLab.textColor = M_MIAN_GRAY_CORLOR;
            self.msgLab.numberOfLines = 1;
            self.lineView.frame = CGRectMake(0, M_CELL_HEIGHT - 0.5, windowContentWidth, 0.5);
        }
            break;
        case ZFJDEOrderStyleTitlePrice:
        {
            if (_goodsIcon) {
                [self.goodsIcon removeFromSuperview];
                [self.countLab removeFromSuperview];
            }
            if (_callIcon) {
                [self.callIcon removeFromSuperview];
            }
            self.titleLab.frame = CGRectMake(M_LEFT_GAP, 0,[self returnTextCGRectText:@"合计" textFont:17 cGSize:CGSizeMake(0, M_CELL_HEIGHT)].size.width, M_CELL_HEIGHT);
            self.msgLab.frame = CGRectMake(ViewRight(_titleLab), 0, windowContentWidth - ViewRight(_titleLab) - M_LEFT_GAP, M_CELL_HEIGHT);
            self.msgLab.textAlignment = NSTextAlignmentRight;
            self.msgLab.textColor = M_MIAN_RED_CORLOR;
            self.msgLab.numberOfLines = 1;
            self.lineView.frame = CGRectMake(0, M_CELL_HEIGHT - 0.5, windowContentWidth, 0.5);
        }
            break;

        default:
            break;
    }
}

- (void)setMsgStr:(NSString *)msgStr {
    _msgStr = msgStr;
    CGFloat height = [self returnTextCGRectText:msgStr textFont:17 cGSize:CGSizeMake( windowContentWidth - M_LEFT_GAP * 2, 0)].size.height;
    self.msgLab.frame = CGRectMake(M_LEFT_GAP, ViewBelow(_titleLab), windowContentWidth - M_LEFT_GAP * 2, height);
    CGRect rect = self.frame;
    rect.size.height = ViewBelow(_msgLab);
    self.frame = rect;
    self.msgLab.textAlignment = NSTextAlignmentLeft;
    self.msgLab.textColor = M_MIAN_GRAY_CORLOR;
    self.msgLab.numberOfLines = 0;
    self.msgLab.text = msgStr;
    self.lineView.frame = CGRectMake(0, ViewHeight(self) - 0.5, windowContentWidth, 0.5);

}

#pragma mark --- 懒加载

- (UIImageView *)goodsIcon {
    if (!_goodsIcon) {
        UIImage * image = [UIImage imageNamed:@"de_order_goods_icon"];
        self.goodsIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, (M_CELL_HEIGHT - image.size.height) / 2, image.size.width, image.size.height)];
        self.goodsIcon.image = image;
    }
    return _goodsIcon;
}

- (UIImageView *)callIcon {
    if (!_callIcon) {
        UIImage * image = [UIImage imageNamed:@"de_order_call_icon"];
        self.callIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(self.msgLab) - image.size.width - 5, (M_CELL_HEIGHT - image.size.height) / 2, image.size.width, image.size.height)];
        self.callIcon.image = image;
    }
    return _callIcon;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        self.titleLab = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLab];
    }
    return _titleLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        self.priceLab = [[UILabel alloc] init];
        self.priceLab.textColor = M_MIAN_RED_CORLOR;
    }
    return _priceLab;
}

- (UILabel *)countLab {
    if (!_countLab) {
        self.countLab = [[UILabel alloc] init];
    }
    return _countLab;
}

- (UILabel *)msgLab {
    if (!_msgLab) {
        self.msgLab = [[UILabel alloc] init];
        [self.contentView addSubview:_msgLab];
    }
    return _msgLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end
