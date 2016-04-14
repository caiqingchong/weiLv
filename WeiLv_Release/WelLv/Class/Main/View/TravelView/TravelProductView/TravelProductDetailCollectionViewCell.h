//
//  TravelProductDetailCollectionViewCell.h
//  WelLv
//
//  Created by 张子乾 on 16/2/16.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductModel;

@interface TravelProductDetailCollectionViewCell : UICollectionViewCell


//风景照
@property (nonatomic,strong) UIImageView *photoImage;
//标题
@property (nonatomic,strong) UILabel *titlelable;
//价格
@property (nonatomic,strong) UILabel *priceLable;

//写一个接口为 Item 上的控件赋值
- (void)assignValueForItemWithModel:(ProductModel *)model;

@end
