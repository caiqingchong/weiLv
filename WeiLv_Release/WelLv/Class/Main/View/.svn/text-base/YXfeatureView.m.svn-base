//
//  YXfeatureView.m
//  WelLv
//
//  Created by lyx on 15/4/3.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXfeatureView.h"
#define btn_With (windowContentWidth - 34)/3

@implementation YXfeatureView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame Feature:(NSMutableArray *)feature
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _featureArr = feature;
        [self initView];
    }
    return self;
}

- (void)initView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Begin_X, 5, btn_With, ViewHeight(_scrollView)-15)];
    //[imageView sd_setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/w%3D2048/sign=924de0c45066d0167e199928a313d507/cefc1e178a82b901e106a03a718da9773912ef14.jpg"]];
    imageView.image=[UIImage imageNamed:@"t_1.png"];
    imageView.userInteractionEnabled = YES;
    imageView.tag = 1;
    [_scrollView addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapClick:)];
    [imageView addGestureRecognizer:tap];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(imageView)+ViewX(imageView)+4, ViewY(imageView), btn_With*2+4, ViewHeight(imageView)/2)];
    //[imageView1 sd_setImageWithURL:[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D2048/sign=8830e20c4dc2d562f208d7edd32991ef/cdbf6c81800a19d88d36c86931fa828ba61e46a0.jpg"]];
    imageView1.image=[UIImage imageNamed:@"t_2.png"];
    imageView1.tag = 2;
    imageView1.userInteractionEnabled = YES;
    [_scrollView addSubview:imageView1];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapClick:)];
    [imageView1 addGestureRecognizer:tap2];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(imageView1), ViewY(imageView1)+ViewHeight(imageView1)+4, btn_With, ViewHeight(imageView)-ViewHeight(imageView1)-4)];
    //[imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D2048/sign=593808e68fb1cb133e693b13e96c574e/f9dcd100baa1cd111f1b1129bb12c8fcc3ce2d0d.jpg"]];
    imageView2.image=[UIImage imageNamed:@"t_3.png"];
    imageView2.tag = 3;
    imageView2.userInteractionEnabled = YES;
    [_scrollView addSubview:imageView2];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapClick:)];
    [imageView2 addGestureRecognizer:tap3];
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(ViewX(imageView2)+ViewWidth(imageView2)+4, ViewY(imageView2), btn_With, ViewHeight(imageView2))];
    //[imageView3 sd_setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/w%3D310/sign=7f661d96d3c8a786be2a4c0f5708c9c7/d50735fae6cd7b89c42887ef0d2442a7d9330e11.jpg"]];
    imageView3.image=[UIImage imageNamed:@"t_4.png"];
    imageView3.tag = 4;
    imageView3.userInteractionEnabled = YES;
    [_scrollView addSubview:imageView3];
     UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapClick:)];
    [imageView3 addGestureRecognizer:tap4];


}
- (void)TapClick:(UIGestureRecognizer *)sender
{
    [self.delegate selectFeature:sender.view.tag];
}
@end
