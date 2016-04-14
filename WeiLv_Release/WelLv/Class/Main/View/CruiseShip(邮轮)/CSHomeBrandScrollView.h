//
//  CSHomeBrandScrollView.h
//  WelLv
//
//  Created by nick on 16/3/11.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MARGIN_WIDTH 10.0

#define MARGIN_HEIGHT 10.0

#define BRAND_ITEM_WIDTH (SCREEN_WIDTH - MARGIN_WIDTH * 4) / 3

#define BRAND_IMAGE_HEIGHT 80.0 * BRAND_ITEM_WIDTH / 120.0

#define BRAND_VIEW_HEIGHT BRAND_IMAGE_HEIGHT + MARGIN_HEIGHT * 2

@interface CSHomeBrandScrollView : UIScrollView

/**
 * 初始化邮轮品牌滚动列表
 *
 * @param - brands: 邮轮品牌内容数组.
 */
- (void)setLayoutWithBrands:(NSArray *)brands;

@end
