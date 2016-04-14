//
//  ShipViewController.m
//  WelLv
//
//  Created by lyx on 15/4/2.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ShipViewController.h"
#import "LXTopBtnView.h"

@interface ShipViewController ()<LXTopBtnViewDelegate>

@end

@implementation ShipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleStr=@"邮轮";

    self.view.backgroundColor=[UIColor whiteColor];
    
    [self  initTopView];
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
