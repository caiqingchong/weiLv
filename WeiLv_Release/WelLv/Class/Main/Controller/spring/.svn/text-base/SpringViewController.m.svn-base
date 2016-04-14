//
//  SpringViewController.m
//  WelLv
//
//  Created by lyx on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "SpringViewController.h"
#import "SearchResultViewController.h"
#import "YXDetailTraveViewController.h"
#import "OverseaPlayViewController.h"
#import "LXSpecialViewController.h"

@interface SpringViewController ()

@end

@implementation SpringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"游学";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTopView];
    // Do any additional setup after loading the view.
    [self initView];
    
}

-(void)initTopView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 16, 25);
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    super.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

-(void)close
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initView
{
    NSArray *imageAraay=[[NSArray alloc] initWithObjects:@"组-2",@"组-1", nil];
    for (int i=0; i<2; i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(0, (windowContentHeight-64)/2*i+3*i, windowContentWidth, (windowContentHeight-64-6)/2);
        [btn setBackgroundImage:[UIImage imageNamed:[imageAraay objectAtIndex:i]] forState:UIControlStateNormal];
        btn.tag=i+1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    
    }
}

-(void)btnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
//            //华东
//            SearchResultViewController *searchVC = [[SearchResultViewController alloc] init];
//            searchVC.title=@"华东游";
//            searchVC.isFromSpring=YES;
//            [self.navigationController pushViewController:searchVC animated:YES];
//            //英国希望之星
//            OverseaPlayViewController *overseaVC=[[OverseaPlayViewController alloc] initWithURLString:@"http://www.weilv100.com/20150720/stxw-a.html"];
//            overseaVC.titleStr=@"英国希望之星";
//            [self.navigationController pushViewController:overseaVC animated:YES];
            
            LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
            specialVc.loadUrl=@"http://www.weilv100.com/20150720/stxw-a.html";
            specialVc.title=@"英国希望之星";
            [self.navigationController pushViewController:specialVc animated:YES];
        }
            break;
            
        case 2:
        {
//            //法国
//            YXDetailTraveViewController *yxDetailVc=[[YXDetailTraveViewController alloc] init];
//            yxDetailVc.productId=@"5771";
//            yxDetailVc.productPrice=@"69";
//            [self.navigationController pushViewController:yxDetailVc animated:YES];
//            //中韩艺术交流周
//            OverseaPlayViewController *overseaVC=[[OverseaPlayViewController alloc] initWithURLString:@"http://www.weilv100.com/20150720/dream-a.html"];
//            overseaVC.titleStr=@"中韩艺术交流周";
//            [self.navigationController pushViewController:overseaVC animated:YES];
            
            LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
            specialVc.loadUrl=@"http://www.weilv100.com/20150720/dream-a.html";
            specialVc.title=@"中韩艺术交流周";
            [self.navigationController pushViewController:specialVc animated:YES];
            
        }
            break;
            
        default:
            break;
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
