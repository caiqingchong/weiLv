//
//  ZFJSteShopMsgView.m
//  WelLv
//
//  Created by WeiLv on 15/10/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopMsgView.h"
#define M_GAP_LEFT 10

@interface ZFJSteShopMsgView ()

@end
@implementation ZFJSteShopMsgView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setStyle:(ZFJMsgCusyomViewStyle)style {
    
    switch (style) {
        case ZFJMsgNoneStyle:
        {
            [self addNoneStyle];
        }
            break;
        case ZFJMsgImageStyle:
        {
            
        }
            break;
        case ZFJMsgInfoStyle:
        {
            [self addInforStyle];
        }
            break;
        case ZFJMsgTitleStyle:
        {
            
        }
            break;
            
        default:
            break;
    }

}



- (void)addNoneStyle {
   self.msgTitleLabel.frame = CGRectMake(M_GAP_LEFT, 0, ViewWidth(self) - M_GAP_LEFT - 20, 50);
    [self addSubview:self.msgTitleLabel];

}

- (void)addImageStyle {
    
}

- (void)addInforStyle {
    CGRect frame = self.msgTitleLabel.frame;
    frame.size.width = [self returnTextCGRectText:self.msgTitleLabel.text textFont:15 cGSize:CGSizeMake(0, ViewHeight(_msgTitleLabel))].size.width;
    self.msgTitleLabel.frame = frame;
    _inforLabel.numberOfLines = 0;
    CGFloat height = MAX([self returnTextCGRectText:self.inforStr textFont:15 cGSize:CGSizeMake((ViewWidth(self) - ViewRight(_msgTitleLabel) - 20 - 20), 0)].size.height, ViewHeight(self));
    _inforLabel.frame = CGRectMake(ViewRight(_msgTitleLabel) + 20, 0, (ViewWidth(self) - ViewRight(_msgTitleLabel) - 20 - 20), height);
    CGRect selfFrame = self.frame;
    selfFrame.size.height = ViewBelow(_inforLabel) + 5;
    self.frame = selfFrame;

}

- (void)addTitleStyle {
    
}

- (void)setIsNeedLine:(BOOL)isNeedLine {
    if (isNeedLine == YES) {
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self) - 0.5, ViewWidth(self), 0.5)];
        lineView.backgroundColor = UIColorFromRGB(0x6f7378);
        [self addSubview:lineView];
    } else {
        
    }
}

- (void)setInforStr:(NSString *)inforStr {
    _inforStr = inforStr;
    self.inforLabel.text = inforStr;
}

#pragma mark --- 懒加载

- (UILabel *)inforLabel {
    if (!_inforLabel) {
        CGRect frame = self.msgTitleLabel.frame;
        frame.size.width = [self returnTextCGRectText:self.msgTitleLabel.text textFont:15 cGSize:CGSizeMake(0, ViewHeight(_msgTitleLabel))].size.width;
        self.msgTitleLabel.frame = frame;
        self.inforLabel = [[UILabel alloc] init];
        _inforLabel.textColor = [UIColor blackColor];
        _inforLabel.font = [UIFont systemFontOfSize:15];
//        CGFloat weith = MIN([self returnTextCGRectText:self.inforStr textFont:15 cGSize:CGSizeMake(0, ViewHeight(self))].size.width, (ViewWidth(self) - ViewRight(_msgTitleLabel) - 20 - 20));
//        _inforLabel.frame = CGRectMake(ViewRight(_msgTitleLabel) + 20, 0, weith, ViewHeight(self));

        [self addSubview:_inforLabel];
    }
    CGFloat weith = MIN([self returnTextCGRectText:self.inforStr textFont:15 cGSize:CGSizeMake(0, ViewHeight(self))].size.width, (ViewWidth(self) - ViewRight(_msgTitleLabel) - 20 - 20));
    _inforLabel.frame = CGRectMake(ViewRight(_msgTitleLabel) + 20, 0, weith, ViewHeight(self));

    return _inforLabel;
}

- (UILabel *)msgTitleLabel {
    if (!_msgTitleLabel) {
        self.msgTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_GAP_LEFT, 0, ViewWidth(self) - M_GAP_LEFT - 20, ViewHeight(self))];
        self.msgTitleLabel.font = [UIFont systemFontOfSize:15];
        self.msgTitleLabel.textColor = UIColorFromRGB(0x6f7278);
        [self addSubview:_msgTitleLabel];
    }
    return _msgTitleLabel;
}



- (UIImageView *)msgImage {
    if (!_msgImage) {
        CGRect frame = self.msgTitleLabel.frame;
        frame.size.width = [self returnTextCGRectText:self.msgTitleLabel.text textFont:15 cGSize:CGSizeMake(0, ViewHeight(_msgTitleLabel))].size.width;
        self.msgTitleLabel.frame = frame;
        self.msgImage = [[UIImageView alloc] initWithFrame:CGRectMake(ViewBelow(_msgTitleLabel) + 20, 7.5, 50, 50)];
        _msgImage.layer.cornerRadius = 25;
        _msgImage.layer.masksToBounds = YES;
        [self addSubview:_msgImage];
        
    }
    return _msgImage;
}

- (UIButton *)chooseBut {
    if (!_chooseBut) {
        UIImageView * goIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(self) - 20,  (ViewHeight(self) - 17) / 2 , 10, 17)];
        goIcon.backgroundColor = [UIColor whiteColor];
        goIcon.image = [UIImage imageNamed:@"矩形-32"];
        [self addSubview:goIcon];
        self.chooseBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.chooseBut.frame = self.bounds;
        [self addSubview:_chooseBut];

    }
    return _chooseBut;
}

@end
