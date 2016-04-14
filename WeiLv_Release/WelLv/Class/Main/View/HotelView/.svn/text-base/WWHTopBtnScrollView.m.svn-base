//
//  WWHTopBtnScrollView.m
//  WelLv
//
//  Created by 吴伟华 on 15/11/25.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WWHTopBtnScrollView.h"
#import "WWHHotelTopListBtn.h"

@implementation WWHTopBtnScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)addTopListBtn:(WWHHotelTopListBtn *)topListBtn
{
    [self addSubview:topListBtn];
    [self layoutIfNeeded];

}
-(void)layoutSubviews
{
    NSInteger subViewCoun = self.subviews.count;
    for (int i = 0; i < subViewCoun; i++) {
        WWHHotelTopListBtn *topBtn = self.subviews[i];
        topBtn.frame = CGRectMake(i * 100, 0, 100, 40);
        [self addSubview:topBtn];
    }
  }
@end
