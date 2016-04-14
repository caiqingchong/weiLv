//
//  ZFJAddAndMinusVIew.m
//  WelLv
//
//  Created by 张发杰 on 15/8/27.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJAddAndMinusView.h"
#define M_ADD_MINUS_BUT_HEIGHT 40
@interface ZFJAddAndMinusView ()
//@property (nonatomic, strong) UILabel * sumLabel;
//@property (nonatomic, strong) UIButton * addBut;
//@property (nonatomic, strong) UIButton * minusBut;
@property (nonatomic, copy) NumOfSumLabel num;

@end

@implementation ZFJAddAndMinusView

//高40, 宽100;
- (id)initWithFrame:(CGRect)frame and:(NSString *)type {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tap];
        
        self.minusBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.minusBut.frame = CGRectMake(0, 0, 35, M_ADD_MINUS_BUT_HEIGHT);
        [self.minusBut setImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
        [self.minusBut addTarget:self action:@selector(minusTicketNumberBut:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.minusBut];
        
        
        self.sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(self.minusBut), 0, ViewWidth(self) - 70, M_ADD_MINUS_BUT_HEIGHT)];
        self.sumLabel.backgroundColor = [UIColor whiteColor];
        self.sumLabel.textAlignment = NSTextAlignmentCenter;
        self.sumLabel.text = @"0";
        self.sumLabel.font = [UIFont systemFontOfSize:15];
        self.sumLabel.adjustsFontSizeToFitWidth = YES;
        self.sumLabel.textColor = [UIColor orangeColor];
        [self addSubview:self.sumLabel];
        
        
        self.addBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBut.frame = CGRectMake(ViewRight(self.sumLabel), 0, 35, M_ADD_MINUS_BUT_HEIGHT);
        if ([type isEqualToString:@"child"]) {
          [self.addBut setImage:[UIImage imageNamed:@"添加不可用"] forState:UIControlStateNormal];
        }else if([type isEqualToString:@"1"]){
        
        [self.addBut setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
        }
        [self.addBut addTarget:self action:@selector(addTicketNumberBut:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addBut];

        self.minNum = 0;
        
        self.frame = CGRectMake(ViewX(self), ViewY(self), 100, M_ADD_MINUS_BUT_HEIGHT);
        //self.num(0);

    }
    return self;
}
/**
 *  设置默认值;
 *
 *  @param defaultNum  NSIntager ：默认值
 */
- (void)setDefaultNum:(NSInteger)defaultNum {
    self.sumLabel.text = [NSString stringWithFormat:@"%ld", defaultNum];
    self.num(defaultNum);
}

//- (void)setMaxNum:(NSInteger)maxNum {
//    
//}

- (NSInteger)currentNum {
    if (_currentNum) {
        self.currentNum = [self.sumLabel.text integerValue];
    }
    return _currentNum;
}

- (void)tapView:(UITapGestureRecognizer *)tap {
    
}

/**
 *   增加人数
 *
 *  @param button
 */
- (void)addTicketNumberBut:(UIButton *)button {
   
    NSInteger tempNum = [self.sumLabel.text integerValue];

    if (!self.maxNum) {
        tempNum = tempNum + 1;
        //self.sumLabel.text = [NSString stringWithFormat:@"%ld", tickrtSum];
        [self changeSumLabelNum:tempNum];

        
    } else {
        
        if (tempNum < self.maxNum) {
            if ([self.addBut.imageView.image isEqual:[UIImage imageNamed:@"添加不可用"]]) {
                [self.addBut setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];

            }
            tempNum = tempNum + 1;
            //self.sumLabel.text = [NSString stringWithFormat:@"%ld", tickrtSum];
            [self changeSumLabelNum:tempNum];
            
        }
        if (tempNum >= self.maxNum && self.maxNum >= 0) {
            
            [self.addBut setImage:[UIImage imageNamed:@"添加不可用"] forState:UIControlStateNormal];
            
        }

    }
    
    if (self.num) {
        self.num(tempNum);
    }
    if (self.maxNum && tempNum > self.maxNum) {
        
        [self.minusBut setImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
    } else {
        [self.minusBut setImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];

    }

}
/**
 *  减少人数
 *
 *  @param button
 */
- (void)minusTicketNumberBut:(UIButton *)button {
    
    NSInteger tempNum = [self.sumLabel.text integerValue];
    
    if (tempNum == self.minNum) {
        
        tempNum = self.minNum;
        
    } else if (tempNum > self.minNum){
        
        tempNum = tempNum - 1;
        
    }
    if (tempNum == self.minNum) {
        
        [self.minusBut setImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
       //[self.addBut setImage:[UIImage imageNamed:@"添加不可用"] forState:UIControlStateNormal];
        
    }
    
    //self.sumLabel.text = [NSString stringWithFormat:@"%ld", tickrtSum];
    [self changeSumLabelNum:tempNum];
    
    if (self.num) {
        self.num(tempNum);
    }
    
    [self.addBut setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];

}

- (void)changeSumLabelNum:(NSInteger)num {
    [UIView animateWithDuration:0.5 animations:^{
        self.sumLabel.text = [NSString stringWithFormat:@"%ld", num];
        if ([self.sumLabel.text intValue]==0) {
        self.num(0);
        }
    }];
}
- (void)numOfSumLabel:(NumOfSumLabel)num {
    self.num = num;
}

@end
