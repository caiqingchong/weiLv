//
//  CSHomeCollectionViewCell.h
//  WelLv
//
//  Created by nick on 16/3/10.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN_WIDTH 10.0

#define MARGIN_HEIGHT 10.0

@interface CSHomeCollectionViewCell : UICollectionViewCell

/**
 * 初始化热推产品cell
 *
 * @param - contents: 热推产品内容数组.
 */
- (void)setLayoutWithContents:(NSArray *)contents andIndexPath:(NSIndexPath *)indexPath;

@end
