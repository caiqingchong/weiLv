//
//  ZFJChooseDateView.h
//  TestProject
//
//  Created by 张发杰 on 15/9/10.
//  Copyright (c) 2015年 张发杰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChooseViewIndex)(NSInteger index);

@interface ZFJChooseDateView : UIView
@property (nonatomic, strong) UILabel * leftLabel;
@property (nonatomic, strong) UILabel * middleLabel;
@property (nonatomic, strong) UILabel * rightLabel;

@property (nonatomic, copy) ChooseViewIndex index;
- (void)chooseViewIndex:(ChooseViewIndex)index;

@end
