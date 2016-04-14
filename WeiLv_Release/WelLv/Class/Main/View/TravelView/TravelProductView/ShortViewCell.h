//
//  ShortViewCell.h
//  TraveDetail
//
//  Created by WeiLv on 16/1/19.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductModel;
@interface ShortViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *locationImage;

@property (nonatomic,strong) UILabel *lineLable;

@property (nonatomic, strong) UILabel *dayLable;


@property (nonatomic,strong) UILabel *timeLable;

@property (nonatomic, strong) UILabel *hotelLable;

@property (nonatomic, strong) UILabel *foodLable;

@property (nonatomic,strong) UIImageView *pictureImage;

@property (nonatomic, strong) UILabel *webLable;

@property (nonatomic,strong) UIImageView *albumsImage;



//写一个接口为 cell 上的控件赋值
- (void)assignValueWithModel:(ProductModel *)model;

/**
 *  定义一个类方法,返回 cell 的行高
 */
//根据传进来的数据,计算当前 cell 的行高
+ (CGFloat)cellHeight:(ProductModel *)model;


@end
