//
//  ScenicView.h
//  WelLv
//
//  Created by WeiLv on 16/2/16.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductModel;

@interface ScenicView : UIView

@property (nonatomic, strong) UILabel *featureLable;

- (void)assignValueWithModel:(ProductModel *)productModel;

+ (CGFloat)lableHeight:(ProductModel *)model;


@end
