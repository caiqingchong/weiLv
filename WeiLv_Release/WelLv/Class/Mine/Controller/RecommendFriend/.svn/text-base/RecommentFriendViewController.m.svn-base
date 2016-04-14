//
//  RecommentFriendViewController.m
//  WelLv
//
//  Created by lyx on 15/6/12.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "RecommentFriendViewController.h"
#define btnWith (windowContentWidth-30)/2
@interface RecommentFriendViewController ()
{
    UILabel *siteLabel;
    NSString *imgSite;
    NSString *qrSite;
    UIImageView *qrImage;
    
    NSString *shareImageURL;  //分享产品的图片
    NSString *shareURL;       //分享跳转的URL
    
    UIImage *_shareImage;
}
@end

@implementation RecommentFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"推荐好友";
    self.view.backgroundColor = BgViewColor;
    NSString *houseId = [[LXUserTool alloc] getUid];
    imgSite = [NSString stringWithFormat:@"%@",houseQrCode(houseId)];
    qrSite = [NSString stringWithFormat:@"%@",houseRegirst(houseId)];
    
    //获取分享产品的图片
    shareImageURL=imgSite;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareImageURL]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _shareImage = [UIImage imageWithData:imageData];
        });
    });

    shareURL=qrSite;
    
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
    if ([reco state]==UIGestureRecognizerStateBegan)
    {
        UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        UIImageWriteToSavedPhotosAlbum(qrImage.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }
}

-(void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    if (!error)
    {
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
    if (sender.tag == 1)
    {
        //构造分享内容
        id<ISSContent> publishContent = [ShareSDK content:@"我是微旅管家，这是我的二维码，注册即可为您提供管家服务"
                                           defaultContent:@"微旅"
                                                    image:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                                    title:@"微旅,您家门口的旅行管家"
                                                      url:qrSite
                                              description:@"分享"
                                                mediaType:SSPublishContentMediaTypeNews];
        
        
        
        
        //微信好友显示内容样式
        [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE content:INHERIT_VALUE title:INHERIT_VALUE url:INHERIT_VALUE image:[ShareSDK jpegImageWithImage:_shareImage quality:1] musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
        
        //微信朋友圈显示内容样式
        [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                              content:INHERIT_VALUE
                                                title:@"我是微旅管家，这是我的二维码，注册即可为您提供管家服务"
                                                  url:INHERIT_VALUE
                                           thumbImage:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                                image:INHERIT_VALUE
                                         musicFileUrl:nil
                                              extInfo:nil
                                             fileData:nil
                                         emoticonData:nil];
        
        
        //QQ空间、好友显示内容样式
        [publishContent addQQUnitWithType:INHERIT_VALUE
                                  content:INHERIT_VALUE
                                    title:INHERIT_VALUE
                                      url:INHERIT_VALUE
                                    image:INHERIT_VALUE];
        
        //调用自定义分享
        [ShareCustom shareWithContent:publishContent];
        
        
//        //创建弹出菜单容器
//        id<ISSContainer> container = [ShareSDK container];
//        [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
//        
//
//        //创建自定义分享列表
//        NSArray *shareList = [ShareSDK customShareListWithType:
//                              SHARE_TYPE_NUMBER(ShareTypeQQSpace),
//                              SHARE_TYPE_NUMBER(ShareTypeQQ),
//                              SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
//                              SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
//                              nil];
//        
//        //弹出分享菜单
//        [ShareSDK showShareActionSheet:container
//                             shareList:shareList
//                               content:publishContent
//                         statusBarTips:NO
//                           authOptions:nil
//                          shareOptions:nil
//                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                    
//                                    if (state == SSResponseStateSuccess)
//                                    {
//                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                        message:nil
//                                                                                       delegate:self
//                                                                              cancelButtonTitle:@"确定"
//                                                                              otherButtonTitles:nil, nil];
//                                        [alert show];
//                                    }
//                                    else if (state == SSResponseStateFail)
//                                    {
//                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                                        message:[NSString stringWithFormat:@"失败原因：%@",[error errorDescription]]
//                                                                                       delegate:self
//                                                                              cancelButtonTitle:@"确定"
//                                                                              otherButtonTitles:nil, nil];
//                                        [alert show];
//                                        
//                                    }
//                                }];
//        
//        
//
//        
        
    }
    else
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = qrSite;
        [[LXAlterView sharedMyTools]createTishi:@"已成功复制到剪切板"];
        //NSLog(@"%@",qrSite);
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
