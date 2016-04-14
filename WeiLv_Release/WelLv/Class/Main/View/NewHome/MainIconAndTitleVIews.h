//
//  MainIconAndTitleVIew.h
//  WelLv
//
//  Created by mac for csh on 15/11/3.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFJImageAndTitleButton.h"

typedef void(^TapBut)(NSIndexPath * indxPath);
@interface MainIconAndTitleVIews : UIView

@property (nonatomic, strong) UIImageView * iconImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * goIcon;
@property (nonatomic, strong) ZFJImageAndTitleButton * but;
@property (nonatomic, copy) TapBut tapBut;


- (id)initWithFrame:(CGRect)frame MainTitleArray:(NSArray *)titleArr ImageURLArray:(NSArray *)ImageUrlStrArr;
-(NSInteger)tagForBtn:(UIButton *)sender;

@end
