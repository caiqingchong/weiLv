//
//  ZFJHotelPriceStarFilterView.m
//  WelLv
//
//  Created by WeiLv on 15/10/8.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJHotelPriceStarFilterView.h"


@interface ZFJHotelPriceStarFilterView ()
@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UIView * slideView;
@property (nonatomic, strong) UIButton * leftSlideBut;
@property (nonatomic, strong) UIButton * rightSlideBut;


@end

@implementation ZFJHotelPriceStarFilterView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, windowContentWidth, windowContentHeight);
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [self customView];
    }
    return self;
}


- (void)customView {
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight /2, windowContentWidth, windowContentHeight / 2)];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(_backgroundView), 45)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    //titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"价格星级";
    [self.backgroundView addSubview:titleLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(titleLabel), ViewWidth(_backgroundView), 0.5)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.backgroundView addSubview:lineView];
    
    UILabel * starTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, ViewBelow(lineView), ViewWidth(_backgroundView) - 30, 45)];
    starTitleLabel.textColor = [UIColor blackColor];
    starTitleLabel.text = @"星级(可多选)";
    [self.backgroundView addSubview:starTitleLabel];
    NSArray * filterTitleArr = @[@"不限", @"经济", @"三星/舒适", @"四星/高档", @"五星/豪华"];
    for (int i = 0; i <filterTitleArr.count; i++) {
        UIButton * but =[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(18 + (windowContentWidth - 36) / filterTitleArr.count * i, ViewBelow(starTitleLabel), (windowContentWidth - 36) / filterTitleArr.count, (windowContentWidth - 36) / filterTitleArr.count * 60 / 136);
        
        but.titleLabel.adjustsFontSizeToFitWidth = YES;
        [but setTitle:[filterTitleArr objectAtIndex:i] forState:UIControlStateNormal];
        but.layer.borderWidth = 0.5;
        but.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if ([[filterTitleArr objectAtIndex:i] isEqualToString:@"不限"]) {
            but.backgroundColor = UIColorFromRGB(0xff9600);
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        [self.backgroundView addSubview:but];
    }
    
    UILabel * priceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, ViewBelow(starTitleLabel) + (windowContentWidth - 36) / filterTitleArr.count * 60 / 136 + 15, windowContentWidth - 30, 45)];
    priceTitleLabel.text = @"价格";
    priceTitleLabel.textColor = [UIColor blackColor];
    [self.backgroundView addSubview:priceTitleLabel];
    
    UIView * slideBackgrounView = [[UIView alloc] initWithFrame:CGRectMake(15, ViewBelow(priceTitleLabel) + 21.5, windowContentWidth - 30, 2)];
    slideBackgrounView.backgroundColor = [UIColor grayColor];
    [self.backgroundView addSubview:slideBackgrounView];
    
    self.leftSlideBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftSlideBut.frame = CGRectMake(15, ViewBelow(priceTitleLabel) + 7.5, 30, 30);
    self.leftSlideBut.backgroundColor = [UIColor cyanColor];
    
    UIPanGestureRecognizer * leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftPan:)];
    [self.leftSlideBut addGestureRecognizer:leftPan];
    
    [self.backgroundView addSubview:_leftSlideBut];
    
    self.rightSlideBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightSlideBut.frame = CGRectMake(windowContentWidth - 15 - 30, ViewBelow(priceTitleLabel) + 7.5, 30, 30);
    self.rightSlideBut.backgroundColor = [UIColor cyanColor];
    
    UIPanGestureRecognizer * rightPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightPan:)];
    [self.rightSlideBut addGestureRecognizer:rightPan];

    [self.backgroundView addSubview:_rightSlideBut];
   
    self.slideView = [[UIView alloc] initWithFrame:CGRectMake(ViewRight(_leftSlideBut), ViewY(slideBackgrounView), ViewX(_rightSlideBut) - ViewRight(_leftSlideBut), 2)];
    self.slideView.backgroundColor = UIColorFromRGB(0xff9600);
    [self.backgroundView addSubview:_slideView];
    
    
    
    UIView * priceView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(slideBackgrounView) + 21.5, windowContentWidth, 45)];
    priceView.backgroundColor = [UIColor orangeColor];
    [self.backgroundView addSubview:priceView];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(priceView) + 20, windowContentWidth, 0.8)];
    line.backgroundColor = UIColorFromRGB(0xff9600);
    [self.backgroundView addSubview:line];
    
    UIButton * okBut = [UIButton buttonWithType:UIButtonTypeCustom];
    okBut.frame = CGRectMake(0, ViewBelow(line), windowContentWidth, 45);
    [okBut setTitle:@"确定" forState:UIControlStateNormal];
    [okBut setTitleColor:UIColorFromRGB(0xff9600) forState:UIControlStateNormal];
    [self.backgroundView addSubview:okBut];
    
    self.backgroundView.frame = CGRectMake(0, windowContentHeight - ViewBelow(okBut), windowContentWidth, ViewBelow(okBut));
    [self addSubview:_backgroundView];

}
- (void)showInView:(UIView *)view {
    [view addSubview:self];
}

- (void)leftPan:(UIPanGestureRecognizer *)pan {
    CGPoint offset = [pan translationInView:pan.view];
    NSLog(@"offset_X = %g", offset.x);
    pan.view.transform = CGAffineTransformTranslate(self.leftSlideBut.transform, offset.x, 0);
    //self.leftSlideBut.frame = CGRectMake(offset.x, ViewY(self.leftSlideBut), 20, 20);
    [pan setTranslation:CGPointZero inView:pan.view];
    self.slideView.frame = CGRectMake(ViewRight(_leftSlideBut), ViewY(self.slideView), ViewX(_rightSlideBut) - ViewRight(_leftSlideBut), 2);

}
- (void)rightPan:(UIPanGestureRecognizer *)pan {
    CGPoint offset = [pan translationInView:pan.view];
    NSLog(@"offset_X = %g", offset.x);
    pan.view.transform = CGAffineTransformTranslate(self.rightSlideBut.transform, offset.x, 0);
    //self.leftSlideBut.frame = CGRectMake(offset.x, ViewY(self.leftSlideBut), 20, 20);
    [pan setTranslation:CGPointZero inView:pan.view];
    self.slideView.frame = CGRectMake(ViewRight(_leftSlideBut), ViewY(self.slideView), ViewX(_rightSlideBut) - ViewRight(_leftSlideBut), 2);
}

@end
