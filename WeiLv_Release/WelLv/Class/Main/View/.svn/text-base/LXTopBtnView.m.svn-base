//
//  LXTopBtnView.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#define BTN_WIDTH 60
#define BTN_HIGHT 60

#import "LXTopBtnView.h"

@implementation LXTopBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame nameArray:(NSMutableArray *)name ImageArray:(NSMutableArray *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _nameArray = name;
        _imageArray = image;
        [self initView];
    }
    return self;
}

-(void)initView
{
    UIView *topView=[[UIView alloc] initWithFrame:self.frame];
    topView.backgroundColor=[UIColor whiteColor];
    [self addSubview:topView];
    
    //列间隔
    int colWidth =(windowContentWidth-BTN_WIDTH*4 - 30)/3;
    //行间隔
    int rowHeight =40;
    for (int i=0; i<_nameArray.count; i++)
    {
//        NSLog(@"hot==================%ld", _nameArray.count);
//        int x =(i%4)*(colWidth +BTN_WIDTH)+colWidth;
        int y =(i/4)*(rowHeight +BTN_HIGHT)+rowHeight-20;
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImageView * backImageView = [[UIImageView alloc] init];
        //btn.backgroundColor=[UIColor yellowColor];
        if (i == 0 || i == 4) {
             btn.frame=CGRectMake(15, y, BTN_WIDTH, BTN_HIGHT);
            backImageView.frame = CGRectMake(15, y, BTN_WIDTH, BTN_HIGHT);
        } else if (i == 3 || i == 7){
             btn.frame=CGRectMake(windowContentWidth - BTN_HIGHT - 15, y, BTN_WIDTH, BTN_HIGHT);
            backImageView.frame = CGRectMake(windowContentWidth - BTN_HIGHT - 15, y, BTN_WIDTH, BTN_HIGHT);

        } else if (i == 1 || i == 2){
            btn.frame=CGRectMake(15 + BTN_WIDTH * i + colWidth * i, y, BTN_WIDTH, BTN_HIGHT);
            backImageView.frame = CGRectMake(15 + BTN_WIDTH * i + colWidth * i, y, BTN_WIDTH, BTN_HIGHT);
        } else {
            btn.frame=CGRectMake(15 + BTN_WIDTH * (i - 4) + colWidth * (i - 4), y, BTN_WIDTH, BTN_HIGHT);
            backImageView.frame = CGRectMake(15 + BTN_WIDTH * (i - 4) + colWidth * (i - 4), y, BTN_WIDTH, BTN_HIGHT);
        }
        
        [topView addSubview:backImageView];
        
        btn.layer.cornerRadius=10;
        btn.layer.masksToBounds=YES;
        backImageView.layer.cornerRadius=10;
        backImageView.layer.masksToBounds=YES;
        btn.tag=i+1;
        [btn addTarget:self action:@selector(featureClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == _imageArray.count - 1) {
            [btn setImage:[UIImage imageNamed:[_imageArray objectAtIndex:i]] forState:UIControlStateNormal];
        }else {
            backImageView.contentMode = UIViewContentModeScaleAspectFill;
            backImageView.clipsToBounds = YES;
            //[btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认图1"] options:SDWebImageTransformAnimatedImage];
            //[btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认图1"]];
            //[btn.imageView sd_setImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:i]] forState:UIControlStateNormal];
            [backImageView sd_setImageWithURL:[NSURL URLWithString:[_imageArray objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
       }
        
        [topView addSubview:btn];
        
        UILabel *nameLab=[[UILabel alloc] init];
        nameLab.frame=CGRectMake(btn.frame.origin.x, y+BTN_HIGHT+5, BTN_WIDTH, 20);
        nameLab.font=[UIFont systemFontOfSize:13];
        nameLab.textAlignment=NSTextAlignmentCenter;
        nameLab.textColor=[UIColor grayColor];
        nameLab.text=[_nameArray objectAtIndex:i];
        [topView addSubview:nameLab];
        
    }
    
}

- (void)featureClick:(UIButton *)sender
{
    [self.delegate selectBtn:sender.tag];
}

@end
