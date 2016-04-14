//
//  IconAndTitleView.h
//  WelLv
//
//  Created by 张发杰 on 15/7/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^chooseTopBlock)(NSInteger chooseTop);

@interface IconAndTitleView : UIView
@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * goIcon;
@property (nonatomic, copy) NSString * titleStr;
@property (nonatomic, assign) BOOL more;

- (id)initWithFrame:(CGRect)frame iconImageName:(NSString *)iconStr titleLabel:(NSString *)title;
- (id)initWithFrame:(CGRect)frame downTitleArray:(NSArray *)titleArr ImageURLStrArrary:(NSArray *)ImageUrlStrArr;
- (id)initWithFrame:(CGRect)frame shipLineTitleArray:(NSArray *)titleArr ImageURLArray:(NSArray *)ImageUrlStrArr;
- (id)initWithFrame:(CGRect)frame roundIconIamge:(NSString *)imageStr titleStr:(NSString *)titleStr;
- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)titleStr secondTitle:(NSString *)secondTitle;

- (void)chooseTop:(chooseTopBlock)chooseTop;
@end
