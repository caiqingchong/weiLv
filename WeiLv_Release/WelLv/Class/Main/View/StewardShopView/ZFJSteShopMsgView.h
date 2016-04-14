//
//  ZFJSteShopMsgView.h
//  WelLv
//
//  Created by WeiLv on 15/10/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZFJMsgCusyomViewStyle){
    ZFJMsgNoneStyle,
    ZFJMsgTitleStyle,
    ZFJMsgImageStyle,
    ZFJMsgInfoStyle
};

@interface ZFJSteShopMsgView : UIView


@property (nonatomic, strong) UIImageView * msgImage;
@property (nonatomic, strong) UILabel * msgTitleLabel;
@property (nonatomic, strong) UILabel * inforLabel;
@property (nonatomic, strong) UIButton * chooseBut;

@property (nonatomic, copy) NSString * msgTitleStr;
@property (nonatomic, copy) NSString * inforStr;
@property (nonatomic, assign) BOOL isNeedLine;

//@property (nonatomic, strong) UIColor * inforTextColor;

@property (nonatomic, assign) ZFJMsgCusyomViewStyle style;


@end
