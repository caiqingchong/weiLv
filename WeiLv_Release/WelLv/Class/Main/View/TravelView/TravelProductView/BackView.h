//
//  BackView.h
//  TraveDetail
//
//  Created by WeiLv on 16/1/17.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackView : UIView

//行程介绍button
@property (nonatomic,strong) UIButton *firstButton;
//产品特色 button
@property (nonatomic,strong) UIButton *secondButton;
//分隔线
@property (nonatomic, strong) UILabel *longLine;
//滚动线图
@property (nonatomic,strong) UIImageView *lineImage;


@end
