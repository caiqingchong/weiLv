//
//  ZFJSteShopQRVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/28.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopQRVC.h"
#define btnWith (windowContentWidth-30)/2
@interface ZFJSteShopQRVC ()<UIActionSheetDelegate>
{
    UILabel *siteLabel;
    NSString *imgSite;
    NSString *qrSite;
    UIImageView *qrImage;
}

@end

@implementation ZFJSteShopQRVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.title = @"推荐好友";
    self.view.backgroundColor = BgViewColor;
    imgSite = [NSString stringWithFormat:@"%@/%@", M_SS_URL_SHOP_QR,[[WLSingletonClass defaultWLSingleton] wlUserSteShopID]];
    qrSite = [NSString stringWithFormat:@"%@/%@", M_SS_URL_SHOP_SHARE_URL,[[WLSingletonClass defaultWLSingleton] wlUserSteShopID]];
    [self initView];
}

- (void) initView
{
    UIView *qrCodeView = [[UIView alloc] initWithFrame:CGRectMake(0, Begin_X*2, windowContentWidth, 220)];
    qrCodeView.backgroundColor = [UIColor whiteColor];
    qrCodeView.layer.cornerRadius = 4.0;
    [self.view addSubview:qrCodeView];
    
    qrImage = [YXTools allocImageView:CGRectMake((windowContentWidth - 150)/2, 20, 150, 150) image:nil];
    [qrImage sd_setImageWithURL:[NSURL URLWithString:imgSite] placeholderImage:[UIImage imageNamed:@"logo"]];
    qrImage.userInteractionEnabled = YES;
    [qrCodeView addSubview:qrImage];
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)];
    [qrImage addGestureRecognizer:longTap];
    
    UILabel *qrLabel = [YXTools allocLabel:@"长按可保存图片到本地" font:systemFont(13) textColor:[UIColor grayColor] frame:CGRectMake(0, ViewHeight(qrImage)+ViewY(qrImage), windowContentWidth, 40) textAlignment:1];
    [qrCodeView addSubview:qrLabel];
    
    UIView *siteView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(qrCodeView)+ViewY(qrCodeView)+20, windowContentWidth, 80)];
    siteView.backgroundColor = [UIColor whiteColor];
    siteView.layer.cornerRadius = 4.0;
    [self.view addSubview:siteView];
    
    siteLabel = [YXTools allocLabel:qrSite font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(20, 20, windowContentWidth-20*2, 40) textAlignment:1];
    siteLabel.numberOfLines = 0;
    [siteView addSubview:siteLabel];
    
    UIButton *shareBtn = [YXTools allocButton:@"" textColor:[UIColor clearColor] nom_bg:[UIImage imageNamed:@"分享链接给好友-1"] hei_bg:nil frame:CGRectMake(Begin_X, ViewHeight(siteView)+ViewY(siteView)+20, btnWith, 40)];
    shareBtn.tag = 1;
    [shareBtn addTarget:self action:@selector(shareAndCopy:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
    UIButton *copyBtn = [YXTools allocButton:@"" textColor:[UIColor clearColor] nom_bg:[UIImage imageNamed:@"复制链接-1"] hei_bg:nil frame:CGRectMake(Begin_X+ViewWidth(shareBtn)+ViewX(shareBtn), ViewY(shareBtn), btnWith, 40)];
    copyBtn.tag = 2;
    [copyBtn addTarget:self action:@selector(shareAndCopy:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:copyBtn];
}

//保存图片
-(void)longTap:(UILongPressGestureRecognizer *)reco
{
    if ([reco state]==UIGestureRecognizerStateBegan) {
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImageWriteToSavedPhotosAlbum(qrImage.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
}

-(void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
    [[LXAlterView alloc] createTishi:message];
}

//分享和复制
- (void)shareAndCopy:(UIButton *)sender
{
    NSString * shareStr = @"";

    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember) {
        shareStr = @"我是微旅管家店铺合伙人，这是我的店铺二维码，扫码即可进入我的店铺";
    } else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        shareStr = @"我是微旅管家，这是我的店铺二维码，扫码即可进入我的管家店铺";
    }
    
    if (sender.tag == 1) {
        //构造分享内容
        id<ISSContent> publishContent = [ShareSDK content:shareStr
                                           defaultContent:@"微旅"
                                                    image:[ShareSDK imageWithUrl:imgSite]
                                                    title:@"微旅,您家门口的旅行管家"
                                                      url:qrSite
                                              description:@"分享"
                                                mediaType:SSPublishContentMediaTypeNews];
        //创建弹出菜单容器
        id<ISSContainer> container = [ShareSDK container];
        [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
        
        id<ISSShareActionSheetItem> wxsItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeWeixiSession] icon:[ShareSDK getClientIconWithType:ShareTypeWeixiSession] clickHandler:^{
            [ShareSDK clientShareContent:publishContent  type:ShareTypeWeixiSession statusBarTips:YES   result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                if (state == SSPublishContentStateSuccess){
                    NSLog(NSLocalizedString(@"TEXt_SHARE_SUC", @"分享成功"));
                }
                else if (state == SSPublishContentStateFail)
                {
                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                }
            }];
        }];
        id<ISSShareActionSheetItem> wxtItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeWeixiTimeline] icon:[ShareSDK getClientIconWithType:ShareTypeWeixiTimeline] clickHandler:^{  [ShareSDK clientShareContent:publishContent type:ShareTypeWeixiTimeline statusBarTips:YES    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            
            if (state == SSPublishContentStateSuccess)
            {
                NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
            }
            else if (state == SSPublishContentStateFail)
            {
                NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
            }
        }];
        }];
        id<ISSShareActionSheetItem> qqItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeQQ]  icon:[ShareSDK getClientIconWithType:ShareTypeQQ] clickHandler:^{ [ShareSDK clientShareContent:publishContent   type:ShareTypeQQ  statusBarTips:YES  result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            
            if (state == SSPublishContentStateSuccess)
            {
                NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
            }
            else if (state == SSPublishContentStateFail)
            {
                NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
            }
        }];
        }];
        
        id<ISSShareActionSheetItem> sinaItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeSinaWeibo] icon:[ShareSDK getClientIconWithType:ShareTypeSinaWeibo] clickHandler:^{  [ShareSDK clientShareContent:publishContent type:ShareTypeSinaWeibo  statusBarTips:YES  result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
            
            if (state == SSPublishContentStateSuccess)
            {
                NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
            }
            else if (state == SSPublishContentStateFail)
            {
                NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
            }
        }];
        }];
        
        //创建自定义分享列表
        NSArray *shareList = [ShareSDK customShareListWithType:
                              wxsItem,
                              wxtItem,
                              qqItem,
                              nil];
        
        //弹出分享菜单
        [ShareSDK showShareActionSheet:container
                             shareList:shareList
                               content:publishContent
                         statusBarTips:YES
                           authOptions:nil
                          shareOptions:nil
                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                    
                                    if (state == SSResponseStateSuccess)
                                    {
                                        [[LXAlterView alloc] createTishi:@"分享成功"];
                                    }
                                    else if (state == SSResponseStateFail)
                                    {
                                        [[LXAlterView alloc] createTishi:[NSString stringWithFormat:@"分享失败,错误描述:%@", [error errorDescription]]];
                                    }
                                }];
        
    } else {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = qrSite;
        [[LXAlterView sharedMyTools]createTishi:@"已成功复制到剪切板"];
        //NSLog(@"%@",qrSite);
    }
    
}
@end
