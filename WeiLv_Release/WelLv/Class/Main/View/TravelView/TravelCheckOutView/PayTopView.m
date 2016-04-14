//
//  PayTopView.m
//  FillOrder
//
//  Created by WeiLv on 16/1/14.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "PayTopView.h"

#import "TravelOrderDetailModel.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation PayTopView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addControl];
    }
    return self;
}

/**
 *  添加相关控件
 */
- (void)addControl{
    
    //标题
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 36, UISCREEN_WIDTH / 35, UISCREEN_WIDTH - UISCREEN_WIDTH / 17, UISCREEN_HEIGHT / 28)];
    //self.titleLable.text = @"<郑州到新乡宝泉西沟一日游>";
    self.titleLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 21];
    self.titleLable.numberOfLines = 0;
    [self addSubview:self.titleLable];
    
    //订单编号
    self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLable.frame), CGRectGetMaxY(self.titleLable.frame) + UISCREEN_HEIGHT / 33, UISCREEN_WIDTH - UISCREEN_WIDTH / 16, UISCREEN_HEIGHT / 31)];
    //self.numberLable.text = @"订单编号:252525252525";
    self.numberLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self addSubview:self.numberLable];
    
    //城市
    self.cityLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.numberLable.frame), CGRectGetMaxY(self.numberLable.frame) + UISCREEN_WIDTH / 32, UISCREEN_WIDTH - UISCREEN_WIDTH / 16, UISCREEN_HEIGHT / 31)];
    //self.cityLable.text = @"出发城市:郑州";
    self.cityLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self addSubview:self.cityLable];
    
    //出发日期
    self.dateLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.cityLable.frame), CGRectGetMaxY(self.cityLable.frame) + UISCREEN_WIDTH / 32, UISCREEN_WIDTH - UISCREEN_WIDTH / 16, UISCREEN_HEIGHT / 31)];
    //self.dateLable.text = @"出发日期:2015-06-18";
    self.dateLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self addSubview:self.dateLable];
    
    //出游人数
    self.peopleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.dateLable.frame), CGRectGetMaxY(self.dateLable.frame) + UISCREEN_WIDTH / 32, UISCREEN_WIDTH  - UISCREEN_WIDTH / 16, UISCREEN_HEIGHT / 31)];
   // self.peopleLable.text = @"出游人数:2成人 1儿童";
    self.peopleLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self addSubview:self.peopleLable];
    
    //订单总额
    self.priceLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.peopleLable.frame), CGRectGetMaxY(self.peopleLable.frame) + UISCREEN_WIDTH / 32, UISCREEN_WIDTH / 2, UISCREEN_HEIGHT / 31)];
    //self.priceLable.text = @"订单总额:";
    self.priceLable.textColor = [UIColor orangeColor];
    self.priceLable.textAlignment = NSTextAlignmentLeft;
    self.priceLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self addSubview:self.priceLable];
    
    
    self.countLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.priceLable.frame), CGRectGetMinY(self.priceLable.frame), UISCREEN_WIDTH / 5, UISCREEN_HEIGHT / 31)];
   // self.countLable.text = @"¥60";
    self.countLable.textAlignment = NSTextAlignmentLeft;
    self.countLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    self.countLable.textColor = [UIColor orangeColor];
    [self addSubview:self.countLable];
}

- (void)assignValueWithModel:(TravelOrderDetailModel *)model{
    
    
    self.titleLable.text = [NSString stringWithFormat:@"< %@ >",model.product_name];
    
    self.numberLable.text = [NSString stringWithFormat:@"%@",model.order_id];
    
//    self.cityLable.text = [NSString stringWithFormat:@"%@",model.f_ci]
    
    
}



@end
