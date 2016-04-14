//
//  LXAlterView.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/18.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define TextFont 15
#define AlertWidth 200

#import "LXAlterView.h"

@implementation LXAlterView

+ (LXAlterView*)sharedMyTools
{
    static LXAlterView *sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[self alloc] init];
    });
    
    return sharedSVC;
}

#pragma mark -- 提示框
-(void)createTishi:(NSString *)tishiStr 
{
    
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    
    
        //计算字符串高度
        CGFloat height=[self textHeight:tishiStr Afont:TextFont];
      if(!_tiShiView&&!_tishiLabel){
        _tiShiView=[[UIView alloc] init];
        _tiShiView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.9];
        _tiShiView.layer.cornerRadius=5.0;
        _tiShiView.frame=CGRectMake((windowContentWidth-AlertWidth)/2, (windowContentHeight-height)/2, AlertWidth, height+10);
   
        _tishiLabel=[[UILabel alloc] init];
        _tishiLabel.frame=_tiShiView.frame;
        _tishiLabel.textAlignment=NSTextAlignmentCenter;
        _tishiLabel.font=[UIFont systemFontOfSize:TextFont];
        _tishiLabel.textColor=[UIColor whiteColor];
        _tishiLabel.numberOfLines=0;
        _tishiLabel.text=tishiStr;
        
        [window addSubview:_tiShiView];
        [window addSubview:_tishiLabel];
    }
    
    [self performSelector:@selector(cleanTishi) withObject:nil afterDelay:2];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cleanTishi];
    });
}

-(void)cleanTishi
{
    
    [_tiShiView removeFromSuperview];
    _tiShiView=nil;
    
    [_tishiLabel removeFromSuperview];
    _tishiLabel=nil;
    
}
#pragma mark --计算字符串高度
-(CGFloat)textHeight:(NSString *)str Afont:(CGFloat)font
{
    
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(AlertWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
      return rect.size.height+10;
}

@end
