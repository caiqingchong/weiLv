//
//  YXTopImageView.m
//  WelLv
//
//  Created by lyx on 15/5/29.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXTopImageView.h"

@implementation YXTopImageView

-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr
{
    if ((self=[super initWithFrame:rect])) {
        self.userInteractionEnabled=YES;
        NSMutableArray *tempArray;
        if (imgArr.count <= 0)
        {
            tempArray = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
        }
        else {
            tempArray=[NSMutableArray arrayWithArray:imgArr];
            [tempArray insertObject:[imgArr lastObject] atIndex:0];
            [tempArray addObject:[imgArr firstObject]];
        }
        imageArray=[NSArray arrayWithArray:tempArray];
        viewSize=rect;
        NSUInteger pageCount=[imageArray count];
        scrollView=[[UIScrollView alloc]initWithFrame:rect];
        scrollView.pagingEnabled = YES;
        scrollView.backgroundColor = [UIColor lightGrayColor];
        scrollView.contentSize = CGSizeMake(viewSize.size.width * pageCount, viewSize.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        for (int i=0; i<pageCount; i++) {
            NSString *imgURL=[imageArray objectAtIndex:i];
            UIImageView *imgView=[[UIImageView alloc] init];
            if ([imgURL hasPrefix:@"http://"]||[imgURL hasPrefix:@"https://"]) {
                //网络图片 请使用eg图o异步片库
                //imgView.contentMode = UIViewContentModeScaleAspectFit;
                [imgView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"默认图3"]];
            }
            else
            {
                UIImage *img=[UIImage imageNamed:[imageArray objectAtIndex:i]];
                [imgView setImage:img];
            }
            
            [imgView setFrame:CGRectMake(viewSize.size.width*i, rect.origin.y,viewSize.size.width, viewSize.size.height)];
            imgView.tag=i;
//            UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
//            [Tap setNumberOfTapsRequired:1];
//            [Tap setNumberOfTouchesRequired:1];
//            imgView.userInteractionEnabled=YES;
//            [imgView addGestureRecognizer:Tap];
            [scrollView addSubview:imgView];
        }
        [scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        [self addSubview:scrollView];
        
        float pageControlWidth=(pageCount-2)*10.0f+40.f;
        float pagecontrolHeight=20.0f;
        
        
        pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(self.frame.size.width-pageControlWidth,self.frame.size.height-20, pageControlWidth, pagecontrolHeight)];
        pageControl.currentPage=0;
        pageControl.numberOfPages=(pageCount-2);
        [self addSubview:pageControl];
        
        myTimer=[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
    }
    return self;
    
}

-(void)scrollToNextPage:(id)sender
{
    NSInteger pageNum=pageControl.currentPage;
    CGRect rect=CGRectMake((pageNum+2)*viewSize.size.width, 0, viewSize.size.width, viewSize.size.height);
    [scrollView scrollRectToVisible:rect animated:NO];
    
    pageNum++;
    if (pageNum==imageArray.count-2) {
        CGRect newRect=CGRectMake(viewSize.size.width, 0,viewSize.size.width, viewSize.size.height);
        [scrollView scrollRectToVisible:newRect animated:NO];
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentPageIndex=page;
    
    pageControl.currentPage=(page-1);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    if (currentPageIndex==0) {
        
        [_scrollView setContentOffset:CGPointMake(([imageArray count]-2)*viewSize.size.width, 0)];
    }
    if (currentPageIndex==([imageArray count]-1)) {
        
        [_scrollView setContentOffset:CGPointMake(viewSize.size.width, 0)];
        
    }
    
}

@end
