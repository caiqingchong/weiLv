//
//  ZFJFilterDetailView.h
//  WelLv
//
//  Created by WeiLv on 15/11/5.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZFJFilterDetailStyle) {
    ZFJFilterDetailStyleOneListChangeColor,          //一个列表点击改变颜色
    ZFJFilterDetailStyleOneListFlagNoChangeColor,    //一个列表带一个标志不变色
    ZFJFilterDetailStyleOneListFlagChangeColor       //一个列表带一个标志变色
};

typedef void(^ChooseFilterIndexPath)(NSIndexPath * indexPath);
typedef void(^HiddenView)(UIView * view);

@interface ZFJFilterDetailView : UIView

@property (nonatomic, copy)NSArray * titleArr;
@property (nonatomic, strong) UIImage * flagIcon;
@property (nonatomic, copy) ChooseFilterIndexPath chooseIndexPath;
@property (nonatomic, copy) HiddenView hiddenView;

- (instancetype)initWithFrame:(CGRect)frame style:(ZFJFilterDetailStyle)style;

- (void)selectFilterViewIndexPath:(ChooseFilterIndexPath)chooseIndexPath;

- (void)selectHiddenView:(HiddenView)view;

@end
