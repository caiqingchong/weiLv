//
//  CSHomeLineScrollView.h
//  WelLv
//
//  Created by nick on 16/3/10.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN_WIDTH 10.0

#define MARGIN_HEIGHT 10.0

#define LINE_ITEM_WIDTH (SCREEN_WIDTH - MARGIN_WIDTH * 2) / 4

#define LINE_IMAGE_VIEW_HEIGHT 45.0 * LINE_ITEM_WIDTH / 80.0

#define LINE_ITEM_HEIGHT LINE_IMAGE_VIEW_HEIGHT + 28.0 + 10.0 + MARGIN_HEIGHT

@protocol CSHomeLineScrollViewSelectedDelegate <NSObject>

- (void)didSelectLineItemWithLineId:(NSString *)lid andLineName:(NSString *)name;

@end

@interface CSHomeLineScrollView : UIScrollView

@property(weak, nonatomic) id<CSHomeLineScrollViewSelectedDelegate> sdelegate;

/**
 * 初始化邮轮航线滚动列表
 *
 * @param - contents: 邮轮内容数据.
 */
- (void)setLayoutWithLineContents:(NSArray *)contents;

@end
