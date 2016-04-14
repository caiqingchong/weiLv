//
//  AboutMicroViewController.m
//  WelLv
//
//  Created by lyx on 15/4/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "AboutMicroViewController.h"
#import "FeedBackViewController.h"
#import "FirstStartViewController.h"

@interface AboutMicroViewController ()
{
    UIScrollView *_scrollView;
}
@property (nonatomic,strong) FirstStartViewController *firstVC;
@end

@implementation AboutMicroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于微旅";
    [self.navigationController.navigationBar setTranslucent:NO];
    self.view.backgroundColor = BgViewColor;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
 
    //绘制界面视图
    [self initView];
    
    //检测版本更新
   // [self checkAppVersion];

}

#pragma mark - 绘制界面视图
- (void)initView
{
    
    int intervlY=-1;
    if (iPhone5) {
        intervlY=-2;
    }
    
    //微旅LOGO头像
    UIImage *logoImage=[UIImage imageNamed:@"about_logo1"];
    UIImageView *logVIew = [[UIImageView alloc] initWithFrame:CGRectMake((windowContentWidth -RectWidth(logoImage.size.width))/2, 21.5,RectWidth(logoImage.size.width), RectHeight(logoImage.size.height))];
    logVIew.image = logoImage;
    [_scrollView addSubview:logVIew];
   
    //当前APP版本号
    UILabel *Version = [YXTools allocLabel:[NSString stringWithFormat:@"微旅%@",XcodeAppVersion] font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(0,ViewBelow(logVIew)+10, windowContentWidth, 30) textAlignment:1];
    [_scrollView addSubview:Version];
    
    //创建主模块视图
    UIView *listView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(Version)+20.5, windowContentWidth, 88+45)];
    listView.backgroundColor = [UIColor whiteColor];

    [_scrollView addSubview:listView];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"版本介绍",@"意见反馈",@"版本更新", nil];
    for (int i=0; i<titleArr.count; i++)
    {
        //行按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 45*i, windowContentWidth, 45);
        btn.tag = i;
        [btn addTarget:self action:@selector(toNext:) forControlEvents:UIControlEventTouchUpInside];
        [listView addSubview:btn];

        //行图标
        UIImage *titImg=[UIImage imageNamed:[titleArr objectAtIndex:i]];
        UIImageView *titImgView=[[UIImageView alloc] initWithFrame:CGRectMake(11,12.5,RectWidth(titImg.size.width),RectHeight(titImg.size.height))];
        titImgView.image=titImg;
        [btn addSubview:titImgView];
        
      
        //行箭头
        UIImage *rowNavImg=[UIImage imageNamed:@"about_j"];
        //行标题
        UILabel *nameLabel;
        if (i==2) {
            nameLabel = [YXTools allocLabel:[titleArr objectAtIndex:i] font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewBelow(titImgView)+12,intervlY, 150,  45)textAlignment:0];
            [btn addSubview:nameLabel];
        }else{
             nameLabel = [YXTools allocLabel:[titleArr objectAtIndex:i] font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewBelow(titImgView)+10,intervlY, 150,  45)textAlignment:0];
            [btn addSubview:nameLabel];
        }
        
        if(i==2)
        {
            NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",WeiLvAppID];
            NSURL *storeURL = [NSURL URLWithString:storeString];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
            [request setHTTPMethod:@"GET"];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            
            [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                
                if ( [data length] > 0 && !error )
                {
                    
                    NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                        
                        if (![versionsInAppStore count])
                        {
                    
                                VersionMsg=[[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth-30-RectWidth(rowNavImg.size.width)-65,intervlY,100,44)];
                                VersionMsg.text=@"已是最新版本";
                                VersionMsg.font=systemFont(14);
                                VersionMsg.textColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
                                [btn addSubview:VersionMsg];
                         
                            
                        }
                        else
                        {
                            
                            NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                            
                            if ([XcodeAppVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending)
                            {
                                
                                
                                VersionMsg=[[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth-30-RectWidth(rowNavImg.size.width)-70,intervlY,100,44)];
                                VersionMsg.text=@"发现新版本";
                                VersionMsg.font=systemFont(14);
                                VersionMsg.textColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
                                [btn addSubview:VersionMsg];

                                
                                //导航箭头
                                UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-30, (45-20)/2,RectWidth(rowNavImg.size.width),RectHeight(rowNavImg.size.height))];
                                rightView.contentMode = UIViewContentModeScaleAspectFit;
                                rightView.image =rowNavImg;
                                [btn addSubview:rightView];
                            }
                            else
                            {
                             
                                    VersionMsg=[[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth-30-RectWidth(rowNavImg.size.width)-65,intervlY,100,44)];
                                    VersionMsg.text=@"已是最新版本";
                                    VersionMsg.font=systemFont(14);
                                    VersionMsg.textColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
                                    [btn addSubview:VersionMsg];

                                
                            }
                            
                        }
                        
                    });
                }
                
            }];
            
        }
        else
        {
            //导航箭头
            UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-30, (45-20)/2,RectWidth(rowNavImg.size.width),RectHeight(rowNavImg.size.height))];
            rightView.contentMode = UIViewContentModeScaleAspectFit;
            rightView.image =rowNavImg;
            [btn addSubview:rightView];
        }
    

        //分割线
        if (i != titleArr.count-1)
        {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ViewX(nameLabel), 43, windowContentWidth-ViewX(nameLabel), 0.5)];
            line.backgroundColor = bordColor;
            [btn addSubview:line];
        }
        
    }
    [_scrollView setContentSize:CGSizeMake(0, ViewHeight(listView)+ViewY(listView)+150)];
}

#pragma mark - 列表跳转事件
- (void)toNext:(UIButton *)sender
{
    //版本介绍
    if(sender.tag == 0 )
    {
        [UIView animateWithDuration:0.05 animations:^{
            self.firstVC = [[FirstStartViewController alloc]init];
            [[YXTools getApp].window addSubview:self.firstVC.view];
            __weak typeof(self) weakSelf = self;
            self.firstVC.didSelectedEnter = ^()
            {
                [weakSelf.firstVC.view removeFromSuperview];
                weakSelf.firstVC = nil;
            };
        }];
    }
    //已经反馈
    if (sender.tag == 1)
    {
        NSString *username=[[LXUserTool alloc] getUid];
        if (!username)
        {
            LoginAndRegisterViewController *login = [[LoginAndRegisterViewController alloc] init];
            [self.navigationController pushViewController:login animated:YES];
        }
        else
        {
            FeedBackViewController *feedVC = [[FeedBackViewController alloc] init];
            [self.navigationController pushViewController:feedVC animated:YES];
        }
    }
    //版本更新
    if(sender.tag == 2)
    {
        [self checkAppVersion];
    }
    //给我评分
//    if(sender.tag == 2)
//    {
//          [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/wei-lu-guan-jia/id990860767?mt=8"]];
//    }
}



#pragma mark - 判断当前版本是否是最新版本
-(void) checkAppVersion
{
    
    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",WeiLvAppID];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ( [data length] > 0 && !error )
        {
            
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                
                if (![versionsInAppStore count])
                {
                    return;
                }
                else
                {
                    NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                    if ([XcodeAppVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending)
                    {
                        NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",WeiLvAppID];
                        NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
                        [[UIApplication sharedApplication] openURL:iTunesURL];
                        
                    }
                    else
                    {
                        
                    }
                    
                }
                
            });
        }
        
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
