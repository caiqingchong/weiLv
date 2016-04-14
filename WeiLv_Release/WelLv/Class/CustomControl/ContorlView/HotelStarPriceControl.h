//
//  HotelStarPriceControl.h
//  CreateControl
//
//  Created by James on 15/11/20.
//  Copyright © 2015年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYRangeSlider.h"
@protocol HotelStarPriceControlDelegate
@optional
-(void)result:(NSString *)resultValue;
@end

@interface HotelStarPriceControl : UIView

//背景视图
@property(nonatomic,strong) UIView *backgroundView;

//“星级（可多选）”按钮边框颜色
@property(nonatomic,strong) UIColor *borderColor;
//星级 (可多选) 数据字典
@property(nonatomic,strong) NSMutableDictionary *selectDict;
//“不限”按钮
@property(nonatomic,strong) UIButton *button0;
//经济
@property(nonatomic,strong) UIButton *button1;
//三星/舒适
@property(nonatomic,strong) UIButton *button2;
//四星/高档
@property(nonatomic,strong) UIButton *button3;
//五星/豪华
@property(nonatomic,strong) UIButton *button4;
//价格区间值
@property(nonatomic,strong) NSString *priceRange;
//全局存储变量
@property(nonatomic,strong) NSString *pubString;
@property(nonatomic,strong) NSString *starString;
@property(nonatomic,strong) NSString *starValue;
@property(nonatomic,strong) NSString *priceValue;
@property(nonatomic,strong) LYRangeSlider *sliderRange;
@property(nonatomic,strong) NSMutableDictionary *priceDict;
@property(nonatomic,strong) NSDictionary *tempPriceDict;
@property(nonatomic,strong) NSString *lowerValue;
@property(nonatomic,strong) NSString *upperValue;

@property (retain,nonatomic) id<HotelStarPriceControlDelegate>delegate;

-(void)initWithValue:(NSString *)value;
@end
