//
//  ChooseTitleView.h
//  WelLv
//
//  Created by 张发杰 on 15/7/27.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseTitle)(NSString * title);
typedef void(^ChooseIndex)(NSIndexPath * index);

typedef void(^ChooseSectionRow)(NSInteger section, NSIndexPath * index);

@interface ChooseTitleView : UIView
@property (nonatomic, assign) NSInteger defaultChooseIndex;

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArr sencondTitleArray:(NSArray *)secondTitleArr;

- (id)initWithFrame:(CGRect)frame withIconArray:(NSArray *)iconArr titleArray:(NSArray *)titleArr;

- (id)initWithFrame:(CGRect)frame withChooseTitleArray:(NSArray *)titleArr;

- (id)initWithFrame:(CGRect)frame withCallTitleArray:(NSArray *)titleArr bigTitle:(NSString *)bigTitle butBackgroundColor:(NSArray *)colorArr;

- (void)chooseTitle:(ChooseTitle)chooseTitle;

- (void)chooseIndex:(ChooseIndex)chooseIndex;
- (void)chooseSectionRow:(ChooseSectionRow)choose;

@end

@interface ZFJChooseCell : UITableViewCell

@property (nonatomic, strong) UIImageView * iconImage;
@property (nonatomic, strong) UILabel * titleLabel;

@end
