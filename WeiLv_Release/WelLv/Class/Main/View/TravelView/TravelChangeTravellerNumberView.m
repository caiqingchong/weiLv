//
//  TravelChangeTravellerNumberView.m
//  bottomView
//
//  Created by 张子乾 on 16/1/21.
//  Copyright © 2016年 张子乾. All rights reserved.
//

#import "TravelChangeTravellerNumberView.h"
#import "TravelChangeCountView.h"
#import "ChangeCountView.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//成人框X
#define kAdultLabelX kScreenWidth/(kScreenWidth/15)
//成人框y
#define kAdultLabelY kScreenHeight/(kScreenHeight/17)
//成人框宽
#define kAdultLabelWidth kScreenWidth/(kScreenWidth/40)
//成人框高
#define kAdultLabelHeight kScreenHeight/(kScreenHeight/17)
//成人数目X
//#define kAdultNumberX CGRectGetMaxX(_adultLabel.frame) + kScreenWidth/(kScreenWidth/10)
//成人数目Y
//#define kAdultNumberY kScreenHeight/(kScreenHeight/10)
//成人数目宽
#define kAdultNumberWidth kScreenWidth/(kScreenWidth/84)
//成人数目高
//#define kAdultNumberHeight kScreenHeight/(kScreenHeight/30)
//成人价格X
#define kAdultPriceLableX kScreenWidth/(kScreenWidth/15)
//成人价格Y
#define kAdultPriceLableY CGRectGetMaxY(_adultNumberbackView.frame) + kScreenHeight/(kScreenHeight/10)
//成人价格宽
#define kAdultPriceLableWidth kScreenWidth/(kScreenWidth/150)
//成人价格高
#define kAdultPriceLableHeight kScreenWidth/(kScreenWidth/15)


//儿童X
#define kChildLabelX CGRectGetMaxX(_adultNumberbackView.frame) + kScreenWidth/(kScreenWidth/33)
//儿童Y
#define kChildLabelY kScreenHeight/(kScreenHeight/17)
//儿童宽
#define kChildLabelWidth kScreenWidth/(kScreenWidth/40)
//儿童高
#define kChildLabelHeight kScreenHeight/(kScreenHeight/17)
//儿童说明X
//#define kChildActionX CGRectGetMaxX(_childLabel.frame)
//儿童说明Y
#define kChildActionY kScreenHeight/(kScreenHeight/20)
//儿童说明宽
#define kChildActionWidth kScreenWidth/(kScreenWidth/15)
//儿童说明高
#define kChildActionHeight kScreenWidth/(kScreenWidth/15)
//儿童数目X
#define kChildNumberX CGRectGetMaxX(_childActionButton.frame) + kScreenWidth/(kScreenWidth/10)
//儿童数目Y
#define kChildNumberY kScreenHeight/(kScreenHeight/10)
//儿童数目宽
#define kChildNumberWidth kScreenWidth/(kScreenWidth/84)
//儿童数目高
#define kChildNumberHeight kScreenHeight/(kScreenHeight/28)
//儿童价格X
#define kChildPriceX kChildLabelX
//儿童价格Y
#define kChildPriceY CGRectGetMaxY(_childNumberBackView.frame) + kScreenHeight/(kScreenHeight/10)
//儿童价格宽
#define kChildPriceWidth kAdultPriceLableWidth
//儿童价格高
#define kChildPriceHeight kAdultPriceLableHeight

//下一步Y
#define kNextStepButtonY kAdultPriceLableY + kScreenHeight/(kScreenHeight/30)
//下一步高
#define kNextButtonHeight kScreenHeight/(kScreenHeight/50)






@implementation TravelChangeTravellerNumberView

//初始化界面
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutAllViews];
        //        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}
//加减人数框
- (void)layoutAllViews {
    
    //黑线
    self.blackLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    self.blackLineView.backgroundColor = BgViewColor;
    [self addSubview:self.blackLineView];
    
    //成人X
    NSInteger adlutX;
    //成人y
    NSInteger adlutY;
    //成人宽
    NSInteger adlutWidth;
    //成人高
    NSInteger adlutHeight;
    //成人数目X
    NSInteger adlutCountX;
    //成人数目Y
    NSInteger adlutCountY;
    //儿童名称X
    NSInteger childLabelX;
    //儿童名称Y
    NSInteger childLabelY;
    //儿童数目X
    NSInteger childCountX;
    //儿童数目Y
    NSInteger childCountY;
    //儿童价格尺寸
    NSInteger adlutPriceSize;
    //下一步按钮Y
    NSInteger NextButtonY;
    //下一步按钮高度
    NSInteger NextButtonHeight;
    //儿童说明
    NSInteger childActionY;
    //儿童说明宽
    NSInteger childActionWidth;
    //儿童说明高
    NSInteger childActionHeigh;
    
    NSInteger kAdultNumberX;
    
    
    
    //成人人数框宽度
    NSInteger adultCountWidth;
    //成人人数框高度
    NSInteger kAdultNumberHeight;
    //成人人数框Y
    NSInteger kAdultNumberY;
    //儿童人数框宽度
    NSInteger childCountWidth;
    //儿童说明提示按钮X
    NSInteger kChildActionX;
    //儿童价格X
    NSInteger childPriceX;
    
    
    if (kScreenHeight < 569) {
        adlutX = 10;
        adlutY = kAdultLabelY;
        adlutWidth = 35;
        adlutHeight = 15;
        
        adlutCountX = 10;
        adlutPriceSize = 14;
//        childCountX = 160;
        NextButtonY = 72;
        NextButtonHeight = 40;
        childLabelX = 155;
        childActionY = 18;
        childActionWidth = 15;
        childActionHeigh = 15;
        
        adultCountWidth = 100;
        childCountWidth = 100;
        //儿童数目X
        childCountX = 210;
        //儿童事项按钮
        kChildActionX = 190;
        childPriceX = 190;
        //成人数目X
        kAdultNumberX = 50;
        kAdultNumberHeight = 33;
        kAdultNumberY = 8;
        childCountY = 8;
    } else if (kScreenHeight == 667){
        adlutX = kAdultLabelX;
        adlutY = kAdultLabelY;
        adlutWidth = kAdultLabelWidth;
        adlutHeight = kAdultLabelHeight;
        adlutCountX = 15;
        adlutPriceSize = 15;
        NextButtonY = 83;
        NextButtonHeight = 47;
        childActionY = 18;
        childLabelX = 190;
        
        childActionWidth = 16;
        childActionHeigh = 16;
        
        adultCountWidth = 120;
        childCountWidth = 120;
        childCountX = 245;
        kChildActionX = 225;
        childPriceX = 190;
        kAdultNumberX = 60;
        kAdultNumberHeight = 36;
        kAdultNumberY = 8;
        childCountY = 8;
    } else if (kScreenHeight == 736){
        adlutX = 25;
        adlutY = kAdultLabelY;
        adlutWidth = kAdultLabelWidth;
        adlutHeight = kAdultLabelHeight;
        adlutCountX = 25;
        adlutPriceSize = 15;
        NextButtonY = 79;
        NextButtonHeight = 51;
        childActionY = 17;
        //儿童名称
        childLabelX = 206;
        
        childActionWidth = 17;
        childActionHeigh = 17;
        
        adultCountWidth = 120;
        childCountWidth = 120;
        //儿童数目
        childCountX = 269;
        //儿童注意事项X
        kChildActionX = 245;
        //儿童价X
        childPriceX = 206;
        kAdultNumberX = 65;
        kAdultNumberHeight = 36;
        kAdultNumberY = 8;
        childCountY = 8;
    }
    
    //成人
    self.adultLabel = [[UILabel alloc]initWithFrame:CGRectMake(adlutX, adlutY, adlutWidth, adlutHeight)];
    self.adultLabel.text = @"成人";
    //    self.adultLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.adultLabel];
    
    //成人数目
    self.adultNumberbackView = [[TravelChangeCountView alloc]initWithFrame:CGRectMake(kAdultNumberX, kAdultNumberY, adultCountWidth, kAdultNumberHeight)and:@"1"];
    self.adultNumberbackView.countTextField.text = @"1";
    //    self.adultNumberbackView.backgroundColor = [UIColor greenColor];
    [self addSubview:self.adultNumberbackView];
    
    //成人价格
    self.adultPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(adlutX, kAdultPriceLableY, kAdultPriceLableWidth, kAdultPriceLableHeight)];
    self.adultPriceLabel.textColor = [UIColor orangeColor];
    self.adultPriceLabel.font = [UIFont systemFontOfSize:adlutPriceSize];
    [self addSubview:self.adultPriceLabel];
    
    //儿童
    self.childLabel = [[UILabel alloc]initWithFrame:CGRectMake(childLabelX, kChildLabelY, kChildLabelWidth, kChildLabelHeight)];
    self.childLabel.text = @"儿童";
    [self addSubview:self.childLabel];
    
    //儿童说明
    self.childActionButton = [[UIImageView alloc]initWithFrame:CGRectMake(kChildActionX, childActionY, childActionWidth, childActionHeigh)];
    [self.childActionButton setImage:[UIImage imageNamed:@"childAction"]];
    [self addSubview:self.childActionButton];
    
    //儿童人数
    self.childNumberBackView = [[TravelChangeCountView alloc]initWithFrame:CGRectMake(childCountX, childCountY, childCountWidth, kAdultNumberHeight)and:@"2"];
    //    self.childNumberBackView.backgroundColor = [UIColor redColor];
    [self.childNumberBackView.minusView setImage:[UIImage imageNamed:@"--灰色"]];
    [self addSubview:self.childNumberBackView];
    
    //儿童价格
    self.childPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(childLabelX, kChildPriceY, kChildPriceWidth, kChildPriceHeight)];
    self.childPriceLabel.textColor = [UIColor orangeColor];
    self.childPriceLabel.font = [UIFont systemFontOfSize:adlutPriceSize];
    [self addSubview:self.childPriceLabel];
    
    
    //下一步
    self.nextStepButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.nextStepButton.frame = CGRectMake(0, NextButtonY, kScreenWidth, NextButtonHeight);
    [self.nextStepButton setBackgroundColor:[UIColor colorWithRed:255/255.0 green:153/255.0 blue:102/255.0 alpha:1]];
    [self.nextStepButton setTitle:@"下一步" forState:(UIControlStateNormal)];
    self.nextStepButton.titleLabel.font = [UIFont systemFontOfSize:kScreenWidth / 21.33];
    [self.nextStepButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self addSubview:self.nextStepButton];

    
    
    
}


@end
