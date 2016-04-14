//
//  CSLineListFilterbar.h
//  WelLv
//
//  Created by nick on 16/3/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN_WIDTH 10.0

#define MARGIN_HEIGHT 10.0

#define FILTER_BAR_HEIGHT 40.0

#define CONTROL_BAR_HEIGHT 48.0

#define CELL_HEIGHT 45.0

typedef NS_ENUM(NSInteger, FilterType){

    FilterTypeComprehensive = 100,
    
    FilterTypeSort
};

typedef NS_ENUM(NSInteger, FilterTableViewType){

    FilterTableViewTypeCondition = 1000,
    
    FilterTableViewTypeDetail,
    
    FilterTableViewTypeSort
};

@interface CSLineListFilterConditionView : UIView

@property(strong, nonatomic) UIView *controlBar;

@property(strong, nonatomic) UITableView *conditionTbView;

@property(strong, nonatomic) UITableView *detailTbView;

@property(strong, nonatomic) UITableView *sortTbView;

- (void)resetLayoutWithFilterType:(FilterType)type;

@end



@interface CSLineListFilterbar : UIView

@property(strong, nonatomic) NSArray *conditions;

@property(strong, nonatomic) CSLineListFilterConditionView *conditionView;

/**
 * 初始化筛选栏
 *
 * @params - frame: 筛选栏尺寸值; conditions: 筛选条件内容数组.
 */
- (instancetype)initWithFrame:(CGRect)frame andFilterConditions:(NSArray *)conditons;

@end

