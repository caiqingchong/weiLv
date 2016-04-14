//
//  CSNavigationBar.h
//  WelLv
//
//  Created by nick on 16/3/8.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NAV_BAR_HEIGHT 64.0

#define STATUS_BAR_HEIGHT 20.0

typedef NS_ENUM(NSInteger, CSNavBarStyle){

    CSNavBarStyleNormal,        //正常样式的导航栏
    CSNavBarStyleTransparent,   //透明样式的导航栏
    CSNavBarStyleOrder          //订单样式的导航栏
};

@interface CSNavigationBar : UIView

@property(assign, nonatomic) CSNavBarStyle navBarStyle;

@property(strong, nonatomic) UIView *statusBar;

@property(strong, nonatomic) id leftItem;

@property(weak, nonatomic) id rightItem;

@property(weak, nonatomic) id titleView;

@property(assign, nonatomic) CGSize leftSize;

@property(assign, nonatomic) CGSize rightSize;

@property(strong, nonatomic) id leftContent;

@property(strong, nonatomic) id rightContent;

@property(strong, nonatomic) id titleContent;

/**
 * 初始化导航栏
 *
 * @params - navBarstyle: 导航栏样式; content: 导航栏左侧按钮、标题、右侧按钮的内容.
 */
- (instancetype)initWithStyle:(CSNavBarStyle)navBarstyle leftItemSize:(CGSize)leftSize rightItemSize:(CGSize)rightSize andContents:(NSArray *)contents;

@end
