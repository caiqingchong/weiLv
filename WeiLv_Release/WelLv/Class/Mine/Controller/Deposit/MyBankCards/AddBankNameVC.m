//
//  AddBankNameVC.m
//  WelLv
//
//  Created by lyx on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "AddBankNameVC.h"

@interface AddBankNameVC ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *placeHoderLabel;
@end

@implementation AddBankNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"填写支行名称";
    self.view.backgroundColor=BgViewColor;
    UIBarButtonItem *rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
    [rightBtn setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem=rightBtn;
    [self createTextView];
   
}
-(void)createTextView
{
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, 80)];
    self.textView.delegate=self;
    //self.textView.returnKeyType=UIReturnKeyDone;
    self.textView.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:self.textView];
    self.placeHoderLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, windowContentWidth-20, 50)];
    self.placeHoderLabel.text=@"请准确填写支行名称，否则无法提现，允许输入30个字...";
    self.placeHoderLabel.textColor=[UIColor grayColor];
    self.placeHoderLabel.font=[UIFont systemFontOfSize:20];
    self.placeHoderLabel.numberOfLines=0;
    [self.textView addSubview:self.placeHoderLabel];
    self.textView.text=self.text;
    if (self.textView.text.length>0) {
        self.placeHoderLabel.hidden=YES;
    }else if(self.textView.text.length==0)
    {
        self.placeHoderLabel.hidden=NO;
    }
    

}

-(void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.text.length==0) {
        self.placeHoderLabel.hidden=NO;
    }else if (self.textView.text){
        self.placeHoderLabel.hidden=YES;
    }
    //该判断用于联想输入
    if (self.textView.text.length > 30)
    {
        [[LXAlterView sharedMyTools]createTishi:@"最多输入30个字"];
        self.textView.text = [self.textView.text substringToIndex:30];
    }
  

}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    self.placeHoderLabel.hidden=YES;
    
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
}
-(void)btnClick
{
    if (self.block) {
        self.block(self.textView.text);
    }
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
