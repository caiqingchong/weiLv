//
//  YXBannerView.m
//  weiLv100
//
//  Created by lyx on 15/4/1.
//  Copyright (c) 2015年 lyx. All rights reserved.
//

#import "YXBannerView.h"
#import "UIImageView+LBBlurredImage.h"

@implementation YXBannerView
@synthesize delegate;
//@synthesize myTimer;

//控制图片轮播
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr 
{
    if ((self=[super initWithFrame:rect])) {
        self.frame = rect;
        self.userInteractionEnabled=YES;
        self.isLunp = NO;
        viewSize = self.frame;
        [self initView:imgArr];
    }
    return self;
    
}

//控制图片不自动轮播
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr isXunHuan:(BOOL)isLunp height:(float)bannerHeight
{
    if ((self=[super initWithFrame:rect])) {
        self.frame = rect;
        self.userInteractionEnabled=YES;
        self.isLunp = isLunp;
         viewSize = CGRectMake(0, 0, self.frame.size.width, bannerHeight);
        [self initView:imgArr];

    }
    return self;
}

- (void)initView:(NSArray *)imgArr
{
    NSMutableArray *tempArray;
    if (imgArr.count <= 0)
    {
        NSArray *data = [[NSUserDefaults standardUserDefaults] objectForKey:ImageLink];
        if (data.count <= 0)
        {
            tempArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
        }
        else
        {
            imgArr = data;
        }
    }
    if (imgArr.count > 0) {
        [tempArray removeAllObjects];
        tempArray=[NSMutableArray arrayWithArray:imgArr];
        [tempArray insertObject:[imgArr lastObject] atIndex:0];
        [tempArray addObject:[imgArr firstObject]];
    }
    imageArray=[NSArray arrayWithArray:tempArray];
    NSUInteger pageCount=[imageArray count];
    scrollView=[[UIScrollView alloc]initWithFrame:self.frame];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.frame.size.width * pageCount, self.frame.size.height);
    //scrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"默认图3"]];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    UIImage *image;
    if (self.isLunp == NO) {
       image = [UIImage imageNamed:@"default_bg_view_750_400"];
    }else
    {
        image = [UIImage imageNamed:@"default_bg_view_750_400"];
    }
    scrollView.layer.contents = (id) image.CGImage;
    for (int i=0; i<pageCount; i++) {
        NSString *imgURL=[imageArray objectAtIndex:i];
        UIImageView *imgView=[[UIImageView alloc] init];
        if ([imgURL hasPrefix:@"https://"] || [imgURL hasPrefix:@"http://"]) {
            //网络图片 请使用ego异步图片库
            //imgView.contentMode = UIViewContentModeScaleAspectFit;
            
            if (self.isLunp == NO) {
                [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
            }else
            {
                [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
            }
        }
        else
        {
            UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
            [imgView setImage:img];
        }
        
        [imgView setFrame:CGRectMake(self.frame.size.width*i, self.frame.origin.y,self.frame.size.width, self.frame.size.height)];
        imgView.tag=i;
        UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [Tap setNumberOfTapsRequired:1];
        [Tap setNumberOfTouchesRequired:1];
        imgView.userInteractionEnabled=YES;
        [imgView addGestureRecognizer:Tap];
        [scrollView addSubview:imgView];
    }
    
    [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
    [self addSubview:scrollView];
    
    float pageControlWidth=(pageCount-2)*10.0f+40.f;
    float pagecontrolHeight=20.0f;
    
    
    pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(((viewSize.size.width-pageControlWidth)/2),viewSize.size.height-20, pageControlWidth, pagecontrolHeight)];
    pageControl.currentPage=0;
    pageControl.numberOfPages=(pageCount-2);
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    if (self.isLunp == NO) {
        myTimer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
    }
    

}
-(void)scrollToNextPage:(id)sender
{

   [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x + scrollView.frame.size.width, scrollView.contentOffset.y) animated:YES];
}

-(void)setIsPageControlShow:(BOOL)isPageControlShow
{
    _isPageControlShow = isPageControlShow;
    pageControl.hidden = !isPageControlShow;

}
#pragma mark ---设置滑动动画
- (void)scrollViewDidScroll:(UIScrollView *)sender
{

   //-
    if (scrollView.contentOffset.x >= ((imageArray.count)-1)*self.frame.size.width) {
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    if (scrollView.contentOffset.x <= 0) {
        scrollView.contentOffset = CGPointMake(((imageArray.count)-2)*self.frame.size.width, 0);
    }
//-
    
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    if (sender == scrollView) {
        pageControl.currentPage=(page-1);
    }
    
  }
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    
    if (currentPageIndex==0) {
        if (_scrollView == scrollView) {
            [scrollView setContentOffset:CGPointMake(([imageArray count]-2)*self.frame.size.width, 0)];
            [_bgScrollView setContentOffset:scrollView.contentOffset];
        }else
        {
            [_bgScrollView setContentOffset:CGPointMake(([imageArray count]-2)*self.frame.size.width, 0)];
            [scrollView setContentOffset:_bgScrollView.contentOffset];

        }
     
        
    }else if (currentPageIndex==([imageArray count]-1)) {
        
        if (_scrollView == scrollView) {
            [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
            [_bgScrollView setContentOffset:scrollView.contentOffset];
        }else
        {
           [_bgScrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
            [scrollView setContentOffset:_bgScrollView.contentOffset];
            
        }
        
    }else
    {
        if (_scrollView == scrollView) {
            [_bgScrollView setContentOffset:scrollView.contentOffset];
        }else
        {
            [scrollView setContentOffset:_bgScrollView.contentOffset];
        }
    }
    
}
- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    if ([delegate respondsToSelector:@selector(EScrollerViewDidClicked:)]) {
        [delegate EScrollerViewDidClicked:sender.view.tag];
    }
}

#pragma mark ---手动滑动后重置时间
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
 //    关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
     [myTimer invalidate];
     myTimer= nil;
}

 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
     myTimer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
  }


@end
