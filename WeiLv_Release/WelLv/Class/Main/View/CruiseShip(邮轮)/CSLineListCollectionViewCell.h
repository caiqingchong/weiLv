//
//  CSLineListCollectionViewCell.h
//  WelLv
//
//  Created by nick on 16/3/14.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN_WIDTH 10.0

#define MARGIN_HEIGHT 10.0

@interface CSLineListCollectionViewCell : UICollectionViewCell

/**
 * 初始化航线产品列表cell
 *
 * @param - contents: 产品内容数组; indexPath: 索引值.
 */
- (void)setLayoutWithContents:(NSArray *)contents andIndexPath:(NSIndexPath *)indexPath;

@end
