//
//  JYCbeizhuViewVC.m
//  WelLv
//
//  Created by lyx on 15/11/19.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCbeizhuViewVC.h"

@interface JYCbeizhuViewVC ()
{
    UITextView *textView;
}
@end

@implementation JYCbeizhuViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"填写备注信息";
    self.view.backgroundColor=[UIColor colorWithRed:221/255.0 green:230/255.0 blue:236/255.0 alpha:1];
   UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
   // searchBtn.hidden=YES;
    searchBtn.frame=CGRectMake(0, 0, 40, 40);
   // [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"保存" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self createTextView];
}
-(void)searchBtnClick
{
    if (self.chuBlock) {
        self.chuBlock(textView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
   
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textView resignFirstResponder];
}
-(void)createTextView
{
    textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, 100)];
    [self.view addSubview:textView];
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
