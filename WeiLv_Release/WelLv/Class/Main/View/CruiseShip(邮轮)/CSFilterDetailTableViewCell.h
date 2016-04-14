//
//  CSFilterDetailTableViewCell.h
//  WelLv
//
//  Created by nick on 16/3/17.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN_WIDTH 10.0

#define MARGIN_HEIGHT 10.0

#define DETAIL_CELL_WIDTH SCREEN_WIDTH * 0.65

#define ICON_SIZE 16.0

@interface CSFilterDetailTableViewCell : UITableViewCell

/**
 * 初始化综合筛选条件详情cell布局
 *
 * @params - details: 筛选条件详情内容数组; indexPath: cell的索引值; crow: 当前选中条件的索引值; drows: 以字典形式存储各条件下对应选中的条件详情的索引值.
 */
- (void)setLayoutWithConditionDetails:(NSArray *)details indexPath:(NSIndexPath *)indexPath selectedConditionRow:(NSInteger)crow andSelectedDetailRows:(NSDictionary *)drows;

@end
