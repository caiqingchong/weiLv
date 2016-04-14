//
//  YXTopImageView.h
//  WelLv
//
//  Created by lyx on 15/5/29.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXTopImageView : UIView<UIScrollViewDelegate>
{
    CGRect viewSize;
    UIScrollView *scrollView;
    NSArray *imageArray;
    NSArray *titleArray;
    UIPageControl *pageControl;
    int currentPageIndex;
    UILabel *noteTitle;
    NSTimer *myTimer;
}
@property (nonatomic,strong)UIPageControl *pageControl;
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr;
@end
