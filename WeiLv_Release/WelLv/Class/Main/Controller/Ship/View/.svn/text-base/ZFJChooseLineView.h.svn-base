//
//  ZFJChooseLineView.h
//  WelLv
//
//  Created by 张发杰 on 15/8/27.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseRow)(NSInteger row);
typedef void(^ChooseRowArray)(NSArray * arr);

@interface ZFJChooseLineView : UIView

@property (nonatomic, assign) NSInteger defaultLineNum; //默认选中某行,  默认第0行; (从0开始）
@property (nonatomic, assign) BOOL multiRow;            //是否可以选择多行, 默认不可以;
@property (nonatomic, assign) NSInteger canChooseRow;  //可以选中的行数, 默认只可以选中多行;
/**
 *  价格Label
 */
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) NSArray * priceArr;


- (id)initWithFrame:(CGRect)frame withChooseLineArray:(NSArray *)lineArr;

- (void)chooseOneRow:(ChooseRow)chooseRow;

- (void)chooseRowArr:(ChooseRowArray)arr;

@end
