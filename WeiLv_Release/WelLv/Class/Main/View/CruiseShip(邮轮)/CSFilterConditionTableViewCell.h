//
//  CSFilterConditionTableViewCell.h
//  WelLv
//
//  Created by nick on 16/3/17.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN_WIDTH 10.0

#define MARGIN_HEIGHT 10.0

#define CONDITION_CELL_WIDTH SCREEN_WIDTH * 0.35

#define ICON_SIZE 16.0

@interface CSFilterConditionTableViewCell : UITableViewCell

/**
 * 初始化综合筛选条件cell布局
 *
 * @params - conditions: 筛选条件内容数组; indexPath: cell的索引值; row: 当前选中cell的索引值.
 */
- (void)setLayoutWithFilterConditions:(NSArray *)conditions indexPath:(NSIndexPath *)indexPath andSelectedIndexPathRow:(NSInteger)row;

@end
