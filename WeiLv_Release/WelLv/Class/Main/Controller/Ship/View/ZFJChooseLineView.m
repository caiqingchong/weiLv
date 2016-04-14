//
//  ZFJChooseLineView.m
//  WelLv
//
//  Created by 张发杰 on 15/8/27.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJChooseLineView.h"
#define M_LINE_HEIGHT self.frame.size.height
@interface ZFJChooseLineView ()
//@property (nonatomic, strong) UIButton * lineBut;
//@property (nonatomic, strong) UIImageView * chooseIcon;
@property (nonatomic, assign) NSInteger tempTag;
@property (nonatomic, copy) ChooseRow chooseRow;


@property (nonatomic, strong) NSMutableArray * tempArr;
@property (nonatomic, copy) ChooseRowArray chooseArr;


@end


@implementation ZFJChooseLineView

- (id)initWithFrame:(CGRect)frame withChooseLineArray:(NSArray *)lineArr {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        //self.canChooseRow = 1;
        
        for (int i = 0; i < lineArr.count; i++) {
            
            UIButton * lineBut = [UIButton buttonWithType:UIButtonTypeCustom];
            lineBut.backgroundColor = [UIColor whiteColor];
            lineBut.frame = CGRectMake(0, (M_LINE_HEIGHT + 1) * i, ViewWidth(self), M_LINE_HEIGHT);
            [lineBut setTitle:[lineArr objectAtIndex:i] forState:UIControlStateNormal];
            [lineBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lineBut.titleLabel.font = [UIFont systemFontOfSize:15];
            lineBut.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            lineBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            lineBut.tag = 100+ i;
            [lineBut addTarget:self action:@selector(chooseOneLine:) forControlEvents:UIControlEventTouchUpInside];
            
            lineBut.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 30);
            [self addSubview:lineBut];
            
            
            UIImageView * chooseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(lineBut) - 25, (M_LINE_HEIGHT - 15) / 2.0, 15, 15)];
            //chooseIcon.tag = 200 + i;
            if (i == 0) {
                self.tempTag = i;
                chooseIcon.image = [UIImage imageNamed:@"选中圆圈"];
                
                //                if (self.multiRow) {
                //                    [self.tempArr addObject:[NSString stringWithFormat:@"%d", i]];
                //                    self.chooseArr(self.tempArr);
                //                } else {
                //                    self.chooseRow(i);
                //                }
                
            } else {
                chooseIcon.image = [UIImage imageNamed:@"未选中圆圈"];
            }
            [lineBut addSubview:chooseIcon];
        }
        self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), lineArr.count * (M_LINE_HEIGHT + 1));
        // NSLog(@"%ld", lineArr.count * (M_LINE_HEIGHT + 1));
        
    }
    return self;
}



- (void)chooseOneLine:(UIButton *)button {
    if (self.multiRow) {
        UIImageView * chooseIcon = [button.subviews objectAtIndex:button.subviews.count - 1];
        if ([chooseIcon.image isEqual:[UIImage imageNamed:@"未选中圆圈"]]) {
            if (self.canChooseRow && self.tempArr.count == self.canChooseRow) {
                [[LXAlterView sharedMyTools] createTishi:@"你的选择\n已超过限制\n请重新选择 :)"];
                return;
            }
            chooseIcon.image = [UIImage imageNamed:@"选中圆圈"];
            [self.tempArr addObject:[NSString stringWithFormat:@"%ld", button.tag - 100 ]];
            self.chooseArr(self.tempArr);
            
        } else {
            chooseIcon.image = [UIImage imageNamed:@"未选中圆圈"];
            [self.tempArr removeObject:[NSString stringWithFormat:@"%ld", button.tag - 100 ]];
            self.chooseArr(self.tempArr);
            
        }
        
        /*
         UIImageView * chooseIcon = (UIImageView *)[self viewWithTag:button.tag +100];
         chooseIcon.image = [UIImage imageNamed:@"选中圆圈"];
         if (button.tag - 100 == self.tempTag) {
         //            [self.tempArr removeObjectAtIndex:self.tempArr.count - 1];
         //            [self.chooseRowArr removeObjectAtIndex:self.chooseRowArr.count - 1];
         //            UIImageView * lsatChooseIcon = [self.tempArr objectAtIndex:self.chooseRowArr.count - 1];
         //            lsatChooseIcon.image = [UIImage imageNamed:@"未选中圆圈"];
         return;
         }
         self.tempTag = button.tag - 100;
         if (self.tempArr.count < self.canChooseRow ) {
         [self.tempArr addObject:chooseIcon];
         [self.chooseRowArr addObject:[NSString stringWithFormat:@"%ld", button.tag - 100 ]];
         self.chooseArr(self.chooseRowArr);
         
         } else {
         [self.tempArr addObject:chooseIcon];
         [self.chooseRowArr addObject:[NSString stringWithFormat:@"%ld", button.tag - 100 ]];
         
         UIImageView * lsatChooseIcon = [self.tempArr objectAtIndex:0];
         lsatChooseIcon.image = [UIImage imageNamed:@"未选中圆圈"];
         [self.tempArr removeObjectAtIndex:0];
         [self.chooseRowArr removeObjectAtIndex:0];
         self.chooseArr(self.chooseRowArr);
         }
         chooseIcon.image = [UIImage imageNamed:@"选中圆圈"];
         */
        
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            UIView * lastView = [self viewWithTag:self.tempTag + 100];
            UIImageView * lastChooseIcon = [lastView.subviews objectAtIndex:lastView.subviews.count - 1];
            lastChooseIcon.image = [UIImage imageNamed:@"未选中圆圈"];
            
            UIView * chooseView = [self viewWithTag:button.tag];
            UIImageView * chooseIcon = [chooseView.subviews objectAtIndex:chooseView.subviews.count - 1];
            chooseIcon.image = [UIImage imageNamed:@"选中圆圈"];
            
        }];
        
        self.tempTag = button.tag - 100;
        self.chooseRow(button.tag - 100);
        
    }
}




- (void)chooseOneRow:(ChooseRow)chooseRow {
    self.chooseRow = chooseRow;
}

- (void)setDefaultLineNum:(NSInteger)defaultLineNum {
    
    UIView * lastView = [self viewWithTag:self.tempTag + 100];
    UIImageView * lastChooseIcon = [lastView.subviews objectAtIndex:lastView.subviews.count - 1];
    lastChooseIcon.image = [UIImage imageNamed:@"未选中圆圈"];
    
    UIView * chooseView = [self viewWithTag:defaultLineNum + 100];
    UIImageView * chooseIcon = [chooseView.subviews objectAtIndex:chooseView.subviews.count - 1];
    chooseIcon.image = [UIImage imageNamed:@"选中圆圈"];
    self.tempTag = defaultLineNum ;
    
    //    if (self.multiRow) {
    //        [self.tempArr removeAllObjects];
    //        [self.tempArr addObject:[NSString stringWithFormat:@"%ld", defaultLineNum - 1]];
    //        self.chooseArr(self.tempArr);
    //    } else {
    //        self.chooseRow(defaultLineNum - 1);
    //    }
    
    
}


- (void)chooseRowArr:(ChooseRowArray)arr {
    self.chooseArr = arr;
}

- (NSMutableArray *)tempArr {
    if (!_tempArr) {
        self.tempArr = [NSMutableArray array];
    }
    return _tempArr;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(self) - 25 - 60, 0, 60, ViewHeight(self))];
        self.priceLabel.font = [UIFont systemFontOfSize:14];
        self.priceLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _priceLabel;
    
}

- (void)setPriceArr:(NSArray *)priceArr {
    for (int i = 0; i < priceArr.count; i++) {
        NSString * priceStr = [priceArr objectAtIndex:i];
        UIView * tempView = [self viewWithTag:100 + i];
        UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(self) - 25 - 65 , (ViewHeight(tempView) + 1) * i, 60,ViewHeight(tempView))];
        UIButton * but = [self viewWithTag:100 + i];
        [but setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 65 + 20)];
        priceLabel.font = [UIFont systemFontOfSize:14];
        priceLabel.adjustsFontSizeToFitWidth = YES;
        if ([self judgeString:priceStr]) {
            priceLabel.text = [NSString stringWithFormat:@"%@", priceStr];
            
        } else {
            priceLabel.text = @"免费";
            
        }
        [self addSubview:priceLabel];
    }
}

@end
