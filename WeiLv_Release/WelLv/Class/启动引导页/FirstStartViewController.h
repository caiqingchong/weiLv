//
//  FirstStartViewController.h
//  MedicalAPP
//
//  Created by NPHD on 14-11-1.
//  Copyright (c) 2014年 lyx. All rights reserved.
//

#import <UIKit/UIKit.h>

#define USER_GUIDE_KEY  @"enUseing"

typedef void (^DidSelectedEnter)();

@interface FirstStartViewController : UIViewController<UIScrollViewDelegate>
{
    NSArray *_imageArray;
    UIPageControl *_pageControl;
    UIScrollView *_scrollView;
}

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;
@end
