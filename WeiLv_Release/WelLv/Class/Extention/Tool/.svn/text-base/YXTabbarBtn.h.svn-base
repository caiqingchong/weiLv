//
//  YXTabbarBtn.h
//  enData
//
//  Created by lyx on 14-9-5.
//  Copyright (c) 2014年 lyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXButtonViewDelegate <NSObject>

@optional
- (void)segmentedButtonSelectedIndex:(NSUInteger)segment button:(UIButton *)btn;

@end

@interface YXTabbarBtn : UIView
{
    NSArray *_btnArray;
    NSMutableArray *_btnArr;
    NSArray *_nomalArray;
    NSArray *_hightArray;
    NSInteger   _selectedIndex;

}

@property (nonatomic,weak) id<YXButtonViewDelegate> delegate;
@property (nonatomic,readonly) NSMutableArray *btnArr;
@property (nonatomic,readonly) NSInteger selectedIndex;


- (id)initWithNomal:(NSArray *)titleArray  frame:(CGRect)frame;
- (void)setSelectIndex:(NSInteger)index;
- (void)btnClick:(UIButton *)btn;

@end
