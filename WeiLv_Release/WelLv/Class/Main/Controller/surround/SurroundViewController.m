//
//  SurroundViewController.m
//  WelLv
//
//  Created by lyx on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "SurroundViewController.h"
#import "JSONKit.h"

@interface SurroundViewController ()
{
    UIScrollView *_scrollView;
}
@end

@implementation SurroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"中华泰山号";
    // Do any additional setup after loading the view.
    
//    DLog(@"%d",iPhone4S);
//    if (iPhone4S==1)
//    {
//        //是4s
//        UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake((windowContentWidth-200)/2, (windowContentHeight-310)/2-64, 200, 310)];
//        bgImageView.image=[UIImage imageNamed:@"社区"];
//        [self.view addSubview:bgImageView];
//    }
//    else
//    {
//        UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake((windowContentWidth-246)/2, (windowContentHeight-382)/2-64, 246, 382)];
//        bgImageView.image=[UIImage imageNamed:@"社区"];
//        [self.view addSubview:bgImageView];
//    }
    UIImage *taishanImage = [UIImage imageNamed:@""];
    float withSize = taishanImage.size.width/taishanImage.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentWidth/withSize)];
    bgImageView.image = taishanImage;
    [_scrollView addSubview:bgImageView];
    
    _scrollView.contentSize = CGSizeMake(0, ViewY(bgImageView)+ViewHeight(bgImageView)+30);
    
//    UIButton * reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    reserveButton.frame = CGRectMake(0, windowContentHeight - 64 - 40, self.view.frame.size.width, 40);
//    [reserveButton setBackgroundImage:[UIImage imageNamed:@"gjbd"] forState:UIControlStateNormal];
//    [reserveButton setTitle:@"立即预订" forState:UIControlStateNormal];
//    reserveButton.titleLabel.font = systemFont(14);
//    [reserveButton addTarget:self action:@selector(bookZHTSH) forControlEvents:UIControlEventTouchUpInside];
//    reserveButton.tag = 102;
//    [self.view addSubview:reserveButton];
}
- (void)bookZHTSH
{
    NSLog(@"预定");
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
