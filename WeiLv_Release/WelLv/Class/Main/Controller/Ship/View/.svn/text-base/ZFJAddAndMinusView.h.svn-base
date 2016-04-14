//
//  ZFJAddAndMinusVIew.h
//  WelLv
//
//  Created by 张发杰 on 15/8/27.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NumOfSumLabel)(NSInteger num);

@interface ZFJAddAndMinusView : UIView

@property (nonatomic, strong) UILabel * sumLabel;
@property (nonatomic, strong) UIButton * addBut;
@property (nonatomic, strong) UIButton * minusBut;



@property (nonatomic, assign) NSInteger defaultNum; //默认显示值,  默认的为0;
@property (nonatomic, assign) NSInteger maxNum;     //增加到的最大值, 默认位计算机的最大值。
@property (nonatomic, assign) NSInteger minNum;     //减小的最小指, 默认为0。
/**
 *  获取当前的和
 */
@property (nonatomic, assign) NSInteger currentNum;

- (id)initWithFrame:(CGRect)frame and:(NSString *)type;
- (void)numOfSumLabel:(NumOfSumLabel)num;

@end
