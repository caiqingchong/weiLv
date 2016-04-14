//
//  YXBannerView.h
//  weiLv100
//
//  Created by lyx on 15/4/1.
//  Copyright (c) 2015年 lyx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"


@protocol EScrollerViewDelegate <NSObject>
@optional
-(void)EScrollerViewDidClicked:(NSUInteger)index;
@end
@interface YXBannerView : UIView<UIScrollViewDelegate>
{
    CGRect viewSize;
    UIScrollView *scrollView;
    NSArray *imageArray;
    NSArray *titleArray;
    UIPageControl *pageControl;
    int currentPageIndex;
    UILabel *noteTitle;
    NSTimer *myTimer;
    
    
    UIScrollView *_bgScrollView;
}
@property(nonatomic,weak)id<EScrollerViewDelegate> delegate;
@property(nonatomic)BOOL isLunp;
@property(weak, nonatomic) UIPageControl *pageControl;
@property(nonatomic,assign)BOOL isPageControlShow;

//-(id)initWithFrameRect:(CGRect)rect bgImageArr:(NSArray *)imgArr;
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr;
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr isXunHuan:(BOOL)isLunp height:(float)bannerHeight;
@end
