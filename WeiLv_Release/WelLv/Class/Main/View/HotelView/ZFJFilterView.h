//
//  ZFJFilterView.h
//  WelLv
//
//  Created by zhangjie on 15/10/2.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectIndex)(NSIndexPath * index);
typedef void(^ChooseOneFilter)(NSInteger oneFilter);
typedef void(^ChooseNaviTitle)(NSInteger chooseOpenOrClose);

@interface ZFJFilterView : UIView
@property (nonatomic, copy) ChooseOneFilter oneFilter;
@property (nonatomic, copy)SelectIndex selectIndex;
@property (nonatomic, copy) NSString * chooseNavTitleStr;
@property (nonatomic, copy) ChooseNaviTitle chooseNaviTitle;
@property (nonatomic, assign) BOOL goBackColor;
/**
 *  普通的筛选有图标和标题组成。
 *
 *  @param frame         Frame
 *  @param titleArr      标题数组
 *  @param iconArr       没有被选择时的图标
 *  @param chooseIconArr 选中时的图标（可以不传，不传时没有选中效果）
 *
 *  @return 返回self
 */
- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArr iconArr:(NSArray *)iconArr chooseIconArr:(NSArray *)chooseIconArr;
- (void)didSelectIndex:(SelectIndex)index;

- (id)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)titleArr;

- (void)chooseFilterNoReturn:(ChooseOneFilter)oneFilter;
- (void)chooseNaviTitle:(ChooseNaviTitle)chooseNavi;

@end
