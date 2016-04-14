//
//  TopView.m
//  TraveDetail
//
//  Created by WeiLv on 16/1/11.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "TopView.h"

#import "ProductModel.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@implementation TopView

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self layoutOfTopView];
        
    }
    return self;
}
/**
 *  头部视图的布局
 */
- (void)layoutOfTopView{
    
    //轮播图
    self.cycle = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0,UISCREEN_WIDTH, (UISCREEN_HEIGHT - UISCREEN_WIDTH / 2.5) / 2)];
    self.cycle.autoScrollTimeInterval = 4.0;
    [self addSubview:self.cycle];
    
}
- (void)assignValueWithModel:(ProductModel *)model{
    
    
    
    //标题
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.cycle.frame) +10, CGRectGetMaxY(self.cycle.frame) + 2, UISCREEN_WIDTH - UISCREEN_WIDTH / 16, UISCREEN_HEIGHT / 15)];
    self.titleLable.numberOfLines = 0;
    //   self.titleLable.text = @"< 郑州到新乡宝泉西沟一日游 >";
    self.titleLable.textColor = [UIColor colorWithRed:55 / 255.0 green:55 / 255.0 blue:55 / 255.0 alpha:1.0];
    self.titleLable.layer.borderColor = [UIColor whiteColor].CGColor;
    self.titleLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 21.3];
    self.titleLable.text = [NSString stringWithFormat:@"< %@ >",model.product_name];
    [self addSubview:self.titleLable];
    
    //标签
    
    //    self.markLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLable.frame), CGRectGetMaxY(self.titleLable.frame) + UISCREEN_WIDTH / 40, (UISCREEN_WIDTH - 35) / 6, UISCREEN_HEIGHT / 28)];
    //    //        self.markLable.text = @"标签标签";
    //    self.markLable.textAlignment = NSTextAlignmentCenter;
    //    self.markLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 35.5];
    //    [self addSubview:self.markLable];
    self.markImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLable.frame),CGRectGetMaxY(self.titleLable.frame) + UISCREEN_WIDTH / 40, UISCREEN_WIDTH / 5.81, UISCREEN_HEIGHT / 28)];
    // markImage.image = [UIImage imageNamed:@"标签"];
    [self addSubview:_markImage];
    
    
    //微旅价格
    self.priceLable = [[UILabel alloc]init];
    if ([self judgeString:model.travel_tag] == NO) {
        self.priceLable.frame = CGRectMake(CGRectGetMinX(self.titleLable.frame), CGRectGetMaxY(self.titleLable.frame) + UISCREEN_WIDTH / 30, UISCREEN_WIDTH / 3, UISCREEN_HEIGHT / 28);
    }else{
        
        self.priceLable.frame = CGRectMake(CGRectGetMinX(self.titleLable.frame), CGRectGetMaxY(self.markImage.frame) + UISCREEN_WIDTH / 30, UISCREEN_WIDTH / 3, UISCREEN_HEIGHT / 28);
        
    }
    
    //    self.priceLable.text = @"微旅价: ￥60";
    self.priceLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 25];
    self.priceLable.textColor = [UIColor colorWithRed:255 / 255.0 green:89 / 255.0 blue:0 alpha:1.0];
    [self addSubview:self.priceLable];
    
    NSArray *stringArr = [model.travel_tag componentsSeparatedByString:@","];
    
    for (int i = 0; i < stringArr.count; i++) {
        self.markLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLable.frame) + i * (UISCREEN_WIDTH / 5.81 + 6), CGRectGetMaxY(self.titleLable.frame) + UISCREEN_WIDTH / 40, UISCREEN_WIDTH / 5.81, UISCREEN_HEIGHT / 28)];
        self.markLable.text = stringArr[i];
        self.markLable.layer.borderColor = [UIColor whiteColor].CGColor;
        self.markLable.textColor = [UIColor orangeColor];
        self.markLable.textAlignment = NSTextAlignmentCenter;
        self.markLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH /26.66];
        [self addSubview:self.markLable];
        
        if ([model.travel_tag isEqualToString:@""]) {
            self.markImage.hidden = YES;
            
        }else{
            self.markImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.titleLable.frame) + i * (UISCREEN_WIDTH / 5.81 + 6), CGRectGetMaxY(self.titleLable.frame) + UISCREEN_WIDTH / 40, UISCREEN_WIDTH / 5.81, UISCREEN_HEIGHT / 28)];
            _markImage.image = [UIImage imageNamed:@"标签"];
            [self addSubview:_markImage];
        }
        
        
    }
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        self.commissionLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.priceLable.frame), CGRectGetMinY(self.priceLable.frame), UISCREEN_WIDTH/ 3.5, UISCREEN_HEIGHT / 28.4)];
        _commissionLable.textAlignment = NSTextAlignmentCenter;
        _commissionLable.backgroundColor = [UIColor colorWithRed:129/255.0 green:214/255.0 blue:205/255.0 alpha:1.0];
        _commissionLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66];
        _commissionLable.layer.borderColor = [UIColor whiteColor].CGColor;
        _commissionLable.textColor = [UIColor whiteColor];
        _commissionLable.layer.cornerRadius = UISCREEN_WIDTH / 34;
        _commissionLable.layer.masksToBounds = YES;
        
        _commissionLable.text = [NSString stringWithFormat:@"返佣:￥%.2f",[model.gj_adult_rebate floatValue]];
        [self addSubview:_commissionLable];
    }else{
        //        self.commissionLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    }
    
    
    //分隔线1
    UILabel *firstLine = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.priceLable.frame), CGRectGetMaxY(self.priceLable.frame) + UISCREEN_WIDTH / 35, UISCREEN_WIDTH - UISCREEN_WIDTH / 26.6, 1)];
    firstLine.alpha = 0.2;
    firstLine.backgroundColor = [UIColor grayColor];
    [self addSubview:firstLine];
    
    //编号
    self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(firstLine.frame), CGRectGetMaxY(firstLine.frame) + UISCREEN_WIDTH / 35, UISCREEN_WIDTH - UISCREEN_WIDTH /32, UISCREEN_HEIGHT / 28)];
    //   self.numberLable.text = @"订单编号:b111111111111111111";
    self.numberLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH /26.6];
    self.numberLable.textColor = [UIColor colorWithRed:125 / 255.0 green:125 / 255.0 blue:125 / 255.0 alpha:1.0];
    [self addSubview:self.numberLable];
    
    //提供方
    self.offerLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(firstLine.frame), CGRectGetMaxY(self.numberLable.frame) + UISCREEN_WIDTH / 50, UISCREEN_WIDTH - 20, UISCREEN_HEIGHT / 28)];
    //    self.offerLable.text = @"本产品由**旅行社提供";
    self.offerLable.numberOfLines = 0;
    self.offerLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.6];
    self.offerLable.textColor = [UIColor colorWithRed:125 / 255.0 green:125 / 255.0 blue:125 / 255.0 alpha:1.0];
    [self addSubview:self.offerLable];
    
    //
    self.businesslicLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.offerLable.frame), CGRectGetMaxY(self.offerLable.frame) + UISCREEN_WIDTH / 50, UISCREEN_WIDTH - 20, UISCREEN_HEIGHT / 28)];
    self.businesslicLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26.66];
    self.businesslicLable.textColor = [UIColor colorWithRed:125 / 255.0 green:125 / 255.0 blue:125 / 255.0 alpha:1.0];
    [self addSubview:self.businesslicLable];
    
    //分隔线2
    UILabel *secondLine = [[UILabel alloc]init];
    
    if ([self judgeString:model.businesslicNo] == NO) {
        secondLine.frame =CGRectMake(CGRectGetMinX(self.offerLable.frame), CGRectGetMaxY(self.offerLable.frame) + UISCREEN_WIDTH / 50, UISCREEN_WIDTH - UISCREEN_WIDTH / 26  , 1);
        self.businesslicLable.hidden = YES;
    }else{
        secondLine.frame =CGRectMake(CGRectGetMinX(self.businesslicLable.frame), CGRectGetMaxY(self.businesslicLable.frame) + UISCREEN_WIDTH / 35, UISCREEN_WIDTH - UISCREEN_WIDTH / 26  , 1);
        self.businesslicLable.hidden = NO;
    }
    
    secondLine.alpha = 0.2;
    secondLine.backgroundColor = [UIColor grayColor];
    [self addSubview:secondLine];
    
    //团期安排详情
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(CGRectGetMinX(secondLine.frame), CGRectGetMinY(secondLine.frame) + UISCREEN_WIDTH / 35, UISCREEN_WIDTH - UISCREEN_WIDTH / 26, UISCREEN_HEIGHT / 22);
    self.button.tag = 101;
    [self addSubview:self.button];
    
    //团期
    self.newlyLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(secondLine.frame), CGRectGetMaxY(secondLine.frame) + UISCREEN_WIDTH / 40, UISCREEN_WIDTH - UISCREEN_WIDTH / 5, UISCREEN_HEIGHT / 22)];
    //    self.newlyLable.backgroundColor = [UIColor purpleColor];
    self.newlyLable.text = @"最近团期:";
    self.newlyLable.textColor = [UIColor colorWithRed:103 / 255.0 green:107 / 255.0 blue:112 / 255.0 alpha:1.0];
    self.newlyLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 24.6];
    [self addSubview:self.newlyLable];
    
    //箭头
    self.moreImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 50.39 - UISCREEN_WIDTH / 21.33, CGRectGetMinY(self.newlyLable.frame) + UISCREEN_WIDTH / 38, UISCREEN_WIDTH /50.39, UISCREEN_HEIGHT / 53.68)];
    self.moreImage.image = [UIImage imageNamed:@"矩形-32-副本-2"];
    //    self.moreImage.backgroundColor = [UIColor purpleColor];
    [self addSubview:self.moreImage];
    
    
    if ([model.belongs isEqual:@"2"]&&[model.supply_type isEqual:@"1"]) {
        self.priceLable.text = [NSString stringWithFormat:@"微旅价:￥%ld起",[model.sell_price integerValue]];
    }else{
        self.priceLable.text = [NSString stringWithFormat:@"微旅价:￥%ld起",[model.adult_price integerValue]];
    }
    
    //    self.commissionLable.text = [NSString stringWithFormat:@"返佣: ￥%@",model.gj_commission];
    self.numberLable.text = [NSString stringWithFormat:@"编号:%@",model.product_sn];
    self.businesslicLable.text = [NSString stringWithFormat:@"经营许可证号:%@",model.businesslicNo];
    self.offerLable.text = [NSString stringWithFormat:@"本产品由%@提供服务",model.company_name];
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
