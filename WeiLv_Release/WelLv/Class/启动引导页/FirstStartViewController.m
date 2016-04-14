//
//  FirstStartViewController.m
//  MedicalAPP
//
//  Created by NPHD on 14-11-1.
//  Copyright (c) 2014年 lyx. All rights reserved.
//

#import "FirstStartViewController.h"
//#import "LoginViewController.h"

#define GUIDE_PILIST_NAME @"guide.plist"

#define IMG_KEY4 @"img4"
#define IMG_KEY5 @"img5"
#define IMG_KEY6 @"img6"
#define IMG_KEY6P @"img6plus"

@interface FirstStartViewController ()

@end

@implementation FirstStartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if (iPhone4S) {
//        _imageArray = [NSArray arrayWithObjects:@"iphone4s_1",@"iphone4s_2",@"iphone4s_3",@"iphone4s_4", nil];
//    }else
//    {
//        _imageArray = [NSArray arrayWithObjects:@"4s_1",@"4s_2",@"4s_3",@"4s_4", nil];
//    }
    _imageArray = [NSArray arrayWithObjects:@"guide_home",@"guide_steward_shop", nil];
    [self showUI];
}
- (void)btnClick{
  
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_GUIDE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)showUI{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollView.userInteractionEnabled = YES;
    [self.view addSubview:_scrollView];

    for (int i= 0 ; i < _imageArray.count; i++) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height)];
        //更换图片位置
        imgV.image = [UIImage imageNamed:[_imageArray objectAtIndex:i]];
        [_scrollView addSubview:imgV];
        if (i == _imageArray.count-1)
        {
            imgV.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame =CGRectMake((self.view.frame.size.width - 150)/2, windowContentHeight - 110, 150, 60);
            //[button setBackgroundImage:[UIImage imageNamed:@"立即体验5"] forState:UIControlStateNormal];
            [button setTitle:@"" forState:UIControlStateNormal];
           
            [button addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
            [imgV addSubview:button];

        }
    }
    
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * _imageArray.count, self.view.bounds.size.height);
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    
    _pageControl = [[UIPageControl alloc] init];
    
    //_pageControl.frame = CGRectMake(self.view.frame.size.width/2 - 57/2,self.view.frame.size.height-70, 57, 15);//指定位置大小
    _pageControl.numberOfPages =_imageArray.count;//指定页面个数
    _pageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    [_pageControl addTarget:self action:@selector(guideChangePage)forControlEvents:UIControlEventValueChanged];
    [NSThread sleepForTimeInterval:1];          //添加委托方法，当点击小白点就执行此方法
    [self.view addSubview:_pageControl];
}

- (void)guideChangePage
{
    NSInteger page = _pageControl.currentPage;
    [_scrollView setContentOffset:CGPointMake(windowContentWidth * page, 0)];
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        if (![self hasNext:_pageControl]) {
            [self enter:nil];
        }
    }
}

#pragma mark - UIScrollView & UIPageControl DataSource

- (BOOL)hasNext:(UIPageControl*)pageControl
{
    return pageControl.numberOfPages > pageControl.currentPage + 1;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_scrollView)
    {
        _pageControl.currentPage=_scrollView.contentOffset.x/windowContentWidth;
    }
  
}


- (void)enter:(id)object
{
    self.didSelectedEnter();
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
