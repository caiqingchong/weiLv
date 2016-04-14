//
//  ZFJImageAndTitleButton.h
//  WelLv
//
//  Created by 张发杰 on 15/4/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFJImageAndTitleButton : UIButton
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *title;
- (instancetype)initWithFrame:(CGRect)frame cornerRadius:(CGFloat )cornerRadius masksToBounds:(BOOL)masksToBounds;
- (instancetype)initWithFrame:(CGRect)frame shipViewCornerRadius:(CGFloat )cornerRadius masksToBounds:(BOOL)masksToBounds;
- (instancetype)initWithFrames:(CGRect)frame shipViewCornerRadiuss:(CGFloat )cornerRadius masksToBoundss:(BOOL)masksToBounds;
@end
