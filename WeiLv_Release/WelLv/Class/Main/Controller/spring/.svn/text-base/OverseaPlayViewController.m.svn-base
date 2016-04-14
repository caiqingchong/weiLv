//
//  OverseaPlayViewController.m
//  WelLv
//
//  Created by 刘鑫 on 15/7/21.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "OverseaPlayViewController.h"

@interface OverseaPlayViewController ()

@end

@implementation OverseaPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTopView];
}

-(void)initTopView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 15, 15);
    [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-65-拷贝"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形-65-拷贝"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    super.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

-(void)close
{
    [self.navigationController popViewControllerAnimated:YES];
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
