//
//  WLLoginIconTFView.m
//  WelLv
//
//  Created by WeiLv on 15/11/5.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLLoginIconTFView.h"

@interface WLLoginIconTFView ()

@property (nonatomic, strong) UIImageView * imageIcon;

@end

@implementation WLLoginIconTFView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self) - 0.5, windowContentWidth, 0.5)];
        lineView.backgroundColor = kColor(200, 200, 200);
        [self addSubview:lineView];
    }
    return self;
}


- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageIcon.image = image;
}
- (void)setPlaceholderStr:(NSString *)placeholderStr {
    _placeholderStr = placeholderStr;
    self.inputTF.placeholder = placeholderStr;
}

- (UIImageView *)imageIcon {
    if (!_imageIcon) {
        self.imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 15, 19)];
        [self addSubview:_imageIcon];
    }
    return _imageIcon;
}

- (UITextField *)inputTF {
    if (!_inputTF) {
        self.inputTF = [[UITextField alloc] initWithFrame:CGRectMake(20 + 15 +40, 10, windowContentWidth-(20 + 15 +40 + 15), 30)];
        _inputTF.borderStyle=UITextBorderStyleNone;
        _inputTF.tintColor = [UIColor orangeColor];
        _inputTF.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:_inputTF];
    }
    return _inputTF;
}
@end
