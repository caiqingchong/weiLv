//
//  ShareCustom.m
//  WelLv
//
//  Created by James on 16/1/27.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "ShareCustom.h"
#import <QuartzCore/QuartzCore.h>
#import <ShareSDK/ShareSDK.h>

//设备物理大小
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define SYSTEM_VERSION   [[UIDevice currentDevice].systemVersion floatValue]
//屏幕宽度相对iPhone6屏幕宽度的比例
#define KWidth_Scale    [UIScreen mainScreen].bounds.size.width/375.0f
@implementation ShareCustom

static id _publishContent;//类方法中的全局变量这样用（类型前面加static）

/*
 自定义的分享类，使用的是类方法，其他地方只要 构造分享内容publishContent就行了
 */

+(void)shareWithContent:(id)publishContent/*只需要在分享按钮事件中 构建好分享内容publishContent传过来就好了*/
{
    //分享的构建内容
    _publishContent = publishContent;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    //创建背景视图
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,windowContentWidth,windowContentHeight)];
    blackView.backgroundColor =[UIColor colorWithWhite:0 alpha:0.8f];
    blackView.tag = 440;
    [window addSubview:blackView];
    
    //尺寸适配
    float shareViewH=171; //设置分享视图默认高度（5S）
    
    float shareTitFontSize=14; //设置“分享到”标题默认字号（5s）
    float shareTitTop=8;//设置“分享到”标题默认居上边距离（5s）
    float shareTitDown=19;//设置“分享到”标题默认居底边距离（5s）
    
    float shareImageLeft=15;//设置默认分享第一个类型图片距左边距（5s）
    float shareImageRow=14;//设置默认分享各个图片的行间距（5s）
    float shareImageTitTop=8;//设置默认各个分享模块标题居图片的上边距（5s）
    float shareImageTitFontSize=12;//设置默认各个分享模块的字号（5s）
    float shareImageTitDown=17;//设置默认各个分享模块标题底部边距（5s）
    
    float shareCancelX=4;
    float shareCancelY=10;
    float shareCancelW=0;
    if(IS_IPHONE_6)
    {
        shareViewH=200;
        
        shareTitFontSize=16;
        shareTitTop=10;
        shareTitDown=22;
        
        shareImageLeft=17.5;
        shareImageRow=16;
        shareImageTitTop=10;
        shareImageTitFontSize=12;
        shareImageTitDown=21;
        shareCancelW=48;
        shareCancelY=5;
        shareCancelW=50;
    }
    else if(IS_IPHONE_6P)
    {
        shareViewH=664/3;
        
        shareTitFontSize=54/3;
        shareTitTop=32/3;
        shareTitDown=74/3;
        
        shareImageLeft=24;
        shareImageRow=52/3;
        shareImageTitTop=30/3;
        shareImageTitFontSize=12;
        shareImageTitDown=70/3;
        
        
        shareCancelX=10;
    }
    
    
    
    //创建分享视图
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0,windowContentHeight-shareViewH, kScreenWidth,shareViewH)];
    shareView.backgroundColor =[UIColor whiteColor];
    shareView.tag = 441;
    [window addSubview:shareView];
    
    //创建分享标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,shareTitTop, shareView.width,shareTitFontSize)];
    titleLabel.text = @"分享到";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:shareTitFontSize];
    titleLabel.textColor = [YXTools stringToColor:@"#2c2c2c"];
    titleLabel.backgroundColor = [UIColor clearColor];
    [shareView addSubview:titleLabel];
    
    NSArray *btnImages = @[@"微信", @"QQ", @"微信朋友圈", @"QQ空间"];
    NSArray *btnTitles = @[@"微信好友", @"QQ好友", @"微信朋友圈", @"QQ空间"];
    float padding=0;
    float shareImageIconH=0;
    float shareImageIconW=0;//图片宽度
    float sil=0;
    for (NSInteger i=0; i<4; i++)
    {
        
        //获取各个分享模块的图标
        UIImage *shareImage=[UIImage imageNamed:btnImages[i]];
        shareImageIconW=shareImage.size.width;
       if(IS_IPHONE_6 || IS_IPHONE_5)
       {
           shareImageIconW=60;
           padding=(windowContentWidth-shareImageLeft*2-4*shareImageIconW)/3;
           sil=shareImageLeft+i*(shareImageIconW+padding);
       }else{
    
       //因为tittle有5个字的 所以 button最小为60*60   12*5=60
        padding=(windowContentWidth-shareImageLeft*2-4*shareImageIconW)/3;
        
    
        sil=shareImageLeft+i*(shareImage.size.width+padding);
      
       }
        
    
        
        //创建各个分享模块的图标按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(sil,ViewBelow(titleLabel)+shareImageTitTop,shareImageIconW,shareImageIconW)];
        [button setBackgroundImage:shareImage forState:UIControlStateNormal];
        [button setTitle:btnTitles[i] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:shareImageTitFontSize];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[YXTools stringToColor:@"#6c6f71"] forState:UIControlStateNormal];
        
        
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [button setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0,20, 0)];
        
        
        //设置标题居上图片边距
        [button setTitleEdgeInsets:UIEdgeInsetsMake(shareImageIconW+10,0, 0, 0)];
        
        
        button.tag = 331+i;
        [button addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:button];
        shareImageIconH=ViewBelow(button);
    }
    
    
    UIImage *imageShareCancel=[UIImage imageNamed:@"分享-取消"];
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(shareImageLeft-shareCancelX,ViewBelow(titleLabel)+shareImageIconH+shareImageTitDown,imageShareCancel.size.width+shareCancelW,imageShareCancel.size.height)];
    
    
    
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancleBtn setBackgroundImage:imageShareCancel forState:UIControlStateNormal];
    cancleBtn.tag = 339;
    [cancleBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareView addSubview:cancleBtn];
    
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
    blackView.alpha = 0;
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1, 1);
        blackView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)shareBtnClick:(UIButton *)btn
{
    //    NSLog(@"%@",[ShareSDK version]);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *blackView = [window viewWithTag:440];
    UIView *shareView = [window viewWithTag:441];
    
    //为了弹窗不那么生硬，这里加了个简单的动画
    shareView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.35f animations:^{
        shareView.transform = CGAffineTransformMakeScale(1/300.0f, 1/270.0f);
        blackView.alpha = 0;
    } completion:^(BOOL finished) {
        
        [shareView removeFromSuperview];
        [blackView removeFromSuperview];
    }];
    
    int shareType = 0;
    id publishContent = _publishContent;
    switch (btn.tag) {
        case 331:
        {
            shareType = ShareTypeWeixiSession;
        }
            break;
            
        case 332:
        {
            shareType = ShareTypeQQ;
        }
            break;
            
        case 333:
        {
            shareType = ShareTypeWeixiTimeline;
        }
            break;
            
        case 334:
        {
            shareType = ShareTypeQQSpace;
        }
            break;
            
        case 335:
        {
            shareType = ShareTypeWeixiFav;
        }
            break;
            
        case 336:
        {
            shareType = ShareTypeSinaWeibo;
        }
            break;
            
        case 337:
        {
            shareType = ShareTypeDouBan;
        }
            break;
            
        case 338:
        {
            shareType = ShareTypeSMS;
        }
            break;
            
        case 339:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    [ShareSDK showShareViewWithType:shareType container:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end)
     {
        if (state == SSResponseStateSuccess)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (state == SSResponseStateFail)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                            message:[NSString stringWithFormat:@"失败原因：%@",[error errorDescription]]
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }];
    
    
    
}
@end
