//
//  ZFJQRResultVC.m
//  WelLv
//
//  Created by 张发杰 on 15/6/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJQRResultVC.h"

@interface ZFJQRResultVC ()

@end

@implementation ZFJQRResultVC

@synthesize backTitle = _backTitle;
@synthesize backBtn = _backBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"扫描结果页面");
    
    _backBtn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    _backBtn.leftView.image = [UIImage imageNamed:@"back"];
    _backBtn.titleLab.text = self.backTitle;
    [_backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)close
{
    [self.navigationController popViewControllerAnimated:YES];
   
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
