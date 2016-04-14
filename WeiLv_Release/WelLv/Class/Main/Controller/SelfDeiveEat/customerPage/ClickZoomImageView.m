//
//  ClickZoomImageView.m
//  ClickImageViewZoom
//
//  Created by 愤怒的振振 on 15-4-27.
//  Copyright (c) 2015年 LiuWeiZhen. All rights reserved.
//

#import "ClickZoomImageView.h"
#define kScreenBounds [[UIScreen mainScreen] bounds]

@interface ClickZoomImageView ()

@property (nonatomic, retain) UIView *bgView;
@end

@implementation ClickZoomImageView

- (void)setClickable:(BOOL)clickable {
    if (clickable == NO) return ;
    
    _clickable = clickable;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnImageView:)];
    
    
    [self addGestureRecognizer:tap];
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    NSLog(@"%f %f", self.frame.size.width, self.frame.size.height);
}

- (void)tapOnImageView:(UITapGestureRecognizer *)tap {
    // 第一步，取到bgView[上面已经放了一个imageView(我们要放大和缩小的imageView)]
    
    // 第二步：取到bgView上的imageView
    
    // 第三步：放大
    UIImageView *imageView = (id)[self.bgView viewWithTag:100];
    CGRect frame           = imageView.frame;
    CGFloat height         = frame.size.width/kScreenBounds.size.width*kScreenBounds.size.height;
    CGFloat width          = frame.size.width/kScreenBounds.size.width*kScreenBounds.size.height;
    frame.size.width       = width;
    frame.size.height      = height;
    [UIView animateWithDuration:0.25 animations:^{
    imageView.frame        = frame;
        
      
    imageView.center       = _bgView.center;
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tapOnBGView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnBGView:)];
        [_bgView addGestureRecognizer:tapOnBGView];
       
    }];
}

- (void)tapOnBGView:(id)sender {
    CGRect rect = [self convertRect:self.bounds toView:[[UIApplication sharedApplication] keyWindow]];
    UIImageView *targetImageView = (id)[_bgView viewWithTag:100];
    [UIView animateWithDuration:0.25 animations:^{
        targetImageView.frame = rect;
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
        self.bgView = nil;
    }];
}

//_bg，就会触发这个方法
- (UIView *)bgView {
    if (_bgView == nil) {
        //  让_bgView和屏幕一样大
        _bgView = [[UIView alloc] initWithFrame:kScreenBounds];
        _bgView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8];
        [[[UIApplication sharedApplication] keyWindow] addSubview:_bgView];
        
        // 坐标转换, 把自己的坐标转换成相对于window的坐标
        CGRect rect = [self convertRect:self.bounds toView:[[UIApplication sharedApplication] keyWindow]];
        // 这个targetImageView就是要放大和缩小的imageView
        UIImageView *targetImageView = [[UIImageView alloc] initWithFrame:rect];
        targetImageView.tag          = 100;
        targetImageView.image        = self.image;
        [_bgView addSubview:targetImageView];
            }
    return _bgView;
}


@end
