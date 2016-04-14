//
//  JYCChooseLines.m
//  WelLv
//
//  Created by lyx on 15/9/21.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCChooseLines.h"

@interface JYCChooseLines ()
//@property (nonatomic, strong) UIButton * lineBut;
//@property (nonatomic, strong) UIImageView * chooseIcon;
@property (nonatomic, assign) NSInteger tempTag;
@property (nonatomic, copy) ChooseRow chooseRow;


@property (nonatomic, strong) NSMutableArray * tempArr;
@property (nonatomic, copy) ChooseRowArray chooseArr;


@end

@implementation JYCChooseLines

- (id)initWithFrame:(CGRect)frame withChooseLineArray:(NSArray *)lineArr {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        for (int i = 0; i < lineArr.count; i++) {
            
            UIButton * lineBut = [UIButton buttonWithType:UIButtonTypeCustom];
            lineBut.backgroundColor = [UIColor whiteColor];
            lineBut.frame = CGRectMake(0, (frame.size.height + 1) * i, ViewWidth(self), frame.size.height);
            [lineBut setTitle:[lineArr objectAtIndex:i] forState:UIControlStateNormal];
            [lineBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            lineBut.titleLabel.font = [UIFont systemFontOfSize:17];
            lineBut.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            lineBut.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            lineBut.tag = 100+ i;
            [lineBut addTarget:self action:@selector(chooseOneLine:) forControlEvents:UIControlEventTouchUpInside];
            
            lineBut.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 30);
            [self addSubview:lineBut];
            
            //[self.contentArr addObject:lineArr[i]];
            self.chooseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(lineBut) - 25, (frame.size.height - 15) / 2.0, 15, 15)];
            //chooseIcon.tag = 200 + i;
            //            if (i == 0) {
            if (i==0) {
                self.tempTag = i;
                self.chooseIcon.image = [UIImage imageNamed:@"选中圆圈"];
            }else{
                self.chooseIcon.image = [UIImage imageNamed:@"未选中圆圈"];
            }
            [lineBut addSubview:self.chooseIcon];
            
           
        }
        self.frame = CGRectMake(ViewX(self), ViewY(self), ViewWidth(self), lineArr.count * (frame.size.height));
        // NSLog(@"%ld", lineArr.count * (M_LINE_HEIGHT + 1));
        
    }
    return self;
}


- (void)chooseOneLine:(UIButton *)button {
   
    
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
    self.tempTag = defaultLineNum;
    
    
    
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

@end
