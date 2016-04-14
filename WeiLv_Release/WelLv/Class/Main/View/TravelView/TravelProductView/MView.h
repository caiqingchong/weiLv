//
//  MView.h
//  WelLv
//
//  Created by WeiLv on 16/1/24.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductModel;
@interface MView : UIView
@property (nonatomic,strong) UIImageView *pictureImage;

@property (nonatomic,strong) UILabel *timeLable;

@property (nonatomic, strong) UILabel *hotelLable;

@property (nonatomic, strong) UILabel *foodLable;


@property (nonatomic,strong) UIImageView *locationImage;

@property (nonatomic,strong) UILabel *lineLable;

@property (nonatomic, strong) UILabel *dayLable;

+ (CGFloat)cellHeight:(ProductModel *)model;

- (void)assignValueWithModel:(ProductModel *)model;

@end
