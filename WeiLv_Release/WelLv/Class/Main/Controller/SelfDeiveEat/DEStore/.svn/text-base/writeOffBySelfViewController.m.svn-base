//
//  writeOffBySelfViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/7.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WXUtil.h"
#import "writeOffBySelfViewController.h"

@interface writeOffBySelfViewController ()<UITextViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    UIView *_view1;
}
@property(nonatomic,strong)UIView *view1;
@end

@implementation writeOffBySelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.title = @"手动核销";
    self.str = [[NSMutableString alloc] init];
    [self creatScrollview];
    [self creatTextView];
    [self creatLabel];
  //  [self creatText];
    [self creatKeyButton];
}
-(void)creatScrollview
{
    self.zxdScrollView = [[UIScrollView alloc] init];
    self.zxdScrollView.delegate = self;
    self.zxdScrollView.frame = CGRectMake(0, 0, windowContentWidth, windowContentHeight);
    [self.view addSubview:self.zxdScrollView];
}
-(void)creatTextView
{
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, windowContentHeight*0.015, windowContentWidth, windowContentHeight*0.15)];
     self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.scrollEnabled = NO;
    
    self.textView.font = [UIFont systemFontOfSize:17];
    self.textView.text = @"备注(选填)";
    self.textView.scrollEnabled = YES;
    self.textView.editable = YES;
    self.textView.delegate = self;
    
    [self.zxdScrollView addSubview:self.textView];
}
-(void)creatLabel
{
    self.labelText = [[UILabel alloc] init];
    self.labelText.frame =CGRectMake(30, windowContentHeight*0.2-5, windowContentWidth-60, windowContentHeight*0.1);
    ;
    self.labelText.backgroundColor = kColor(255, 165, 98);
    self.labelText.textAlignment = NSTextAlignmentCenter;
    [self.zxdScrollView addSubview:self.labelText];
//    self.textField = [[UITextField alloc] init];
//    self.textField.frame = CGRectMake(30, windowContentHeight*0.2, windowContentWidth-60, windowContentHeight*0.1);
//    
//    self.textField.backgroundColor = kColor(255, 165, 98);
//    self.textField.textAlignment = NSTextAlignmentCenter;;
//    self.textField.textColor =  [UIColor blackColor];
//    [self.view addSubview:self.textField];
}
-(void)creatText
{
    self.textField = [[UITextField alloc] init];
    self.textField.frame = CGRectMake(30, windowContentHeight*0.2, windowContentWidth-60, windowContentHeight*0.1);
    
    self.textField.backgroundColor = kColor(255, 165, 98);
    self.textField.textAlignment = NSTextAlignmentCenter;;
    self.textField.textColor =  [UIColor blackColor];
    [self.zxdScrollView addSubview:self.textField];
}
-(void)creatKeyButton
{
    
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"",];
    self.view1 = [[UIView alloc] init];
    self.view1.frame = CGRectMake(0, windowContentHeight*0.4-44, windowContentWidth, windowContentHeight*0.6);
    self.view1.backgroundColor = [UIColor whiteColor];
    for (int i=0; i<3; i++) {
        for (int j=0; j<3; j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(j*(windowContentWidth/4), i*(windowContentHeight*0.6)*0.25, windowContentWidth/4, (windowContentHeight*0.6)*0.25);
            //[btn.layer setBorderWidth:1.0];
           
            btn.tag = i*3+j+1;
            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:30];
            [btn setTitle:array[i*3+j] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.textColor = [UIColor redColor];
            [self.view1 addSubview:btn];
        }
    }
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn0.frame = CGRectMake(0, 3*(windowContentHeight*0.6)*0.25, windowContentWidth*0.75, (windowContentHeight*0.6)*0.25);
   // [btn0.layer setBorderWidth:1.0];
    
    btn0.tag = 0;
    btn0.backgroundColor = [UIColor whiteColor];
    btn0.titleLabel.font = [UIFont systemFontOfSize:30];
    [btn0 setTitle:@"0" forState:UIControlStateNormal];
    [btn0 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn0.titleLabel.textColor = [UIColor redColor];

    [self.view1 addSubview:btn0];
    //C按钮
//    UIView *viewc = [[UIView alloc] init];
//    viewc.frame =CGRectMake(windowContentWidth*0.75, 0, windowContentWidth*0.25, (windowContentHeight*0.6)*0.25);
//    viewc.backgroundColor = [UIColor redColor];
//    [view1 addSubview:viewc];
    UIButton *btnc= [UIButton buttonWithType:UIButtonTypeSystem];
    btnc.frame = CGRectMake(windowContentWidth*0.75, 0, windowContentWidth*0.25, (windowContentHeight*0.6)*0.25);
   // [btnc.layer setBorderWidth:1.0];
    
    btnc.tag = 11;
    btnc.backgroundColor = kColor(54, 137, 215);
    btnc.titleLabel.font = [UIFont systemFontOfSize:30];
    
    [btnc setTitle:@"C" forState:UIControlStateNormal];
    [btnc setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnc addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:btnc];
    //删除按钮
    UIButton *btnx= [UIButton buttonWithType:UIButtonTypeSystem];
    btnx.frame = CGRectMake(windowContentWidth*0.75, (windowContentHeight*0.6)*0.25, windowContentWidth*0.25, (windowContentHeight*0.6)*0.25);
    UIImage *img = [UIImage imageNamed:@"z删除"];
    
    //[btnx setBackgroundImage:img forState:UIControlStateNormal];
   // [btnx setImage:img forState:UIControlStateNormal];
   // [btnx.layer setBorderWidth:1.0];
//    UIImageView *imageview = [[UIImageView alloc] init];
//    imageview.frame = CGRectMake(windowContentWidth*0.25*0.15, windowContentWidth*0.15*0.55, windowContentWidth*0.25*0.6, 35);
   // imageview.frame = CGRectMake(windowContentWidth*25*0.34, windowContentHeight*0.05, windowContentWidth*0.25*0.67, windowContentHeight*0.05);
    //imageview.image = img;
   // [btnx addSubview:imageview];
    [btnx setImage:img forState:UIControlStateNormal];
    btnx.tag = 12;
    btnx.backgroundColor = kColor(38, 208, 115);
    btnx.titleLabel.font = [UIFont systemFontOfSize:30];
   // [btnx setTitle:@"C" forState:UIControlStateNormal];
    [btnx addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:btnx];
    
    
    //￥按钮
    UIButton *btnQ= [UIButton buttonWithType:UIButtonTypeSystem];
    btnQ.frame = CGRectMake(windowContentWidth*0.75, (windowContentHeight*0.6)*0.5, windowContentWidth*0.25, (windowContentHeight*0.6)*0.5);
   // [btnQ.layer setBorderWidth:1.0];
    
    btnQ.tag = 13;
    btnQ.backgroundColor = kColor(236, 188, 52);
    btnQ.titleLabel.font = [UIFont systemFontOfSize:30];
   // [btnQ setBackgroundImage:<#(nullable UIImage *)#> forState:UIControlStateNormal];
    [btnQ setTitle:@"￥" forState:UIControlStateNormal];
    [btnQ addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view1 addSubview:btnQ];
    [self.view addSubview:self.view1];
    for (int i=0; i<3; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0,(windowContentHeight*0.6)*(i+1)*0.25 , windowContentWidth*0.75, 1);
        label.backgroundColor = kColor(255, 165, 98);
        [self.view1 addSubview:label];
    }
    for (int j =0; j<2; j++) {
        UILabel *label2 = [[UILabel alloc] init];
        label2.frame = CGRectMake(windowContentWidth*0.25*(j+1),0 , 1,windowContentHeight*0.6*0.75);
        label2.backgroundColor = kColor(255, 165, 98);
        [self.view1 addSubview:label2];

    }
}
-(void)btnClick:(UIButton *)btn
{
    [self.textView resignFirstResponder];
    //[self.textField resignFirstResponder];
    if (btn.tag<=10) {
        NSMutableString *string = [NSMutableString stringWithFormat:@"%@",btn.titleLabel.text];
        NSLog(@"%@",string);
        self.str = [NSMutableString stringWithFormat:@"%@%@",self.str,string];
       // self.textField.text = self.str;
        self.labelText.text = self.str;
    }
    else if (btn.tag == 11)
    {
        self.str = [NSMutableString stringWithString:@""];
        //self.textField.text = self.str;
        self.labelText.text = self.str;

    }
    else if (btn.tag == 12)
    {
       // NSString *str1 =[NSString stringWithFormat:@"%@",@""];
        NSInteger strlong  = 0;
        strlong = self.str.length;
        if (strlong==0) {
            return;
        }
        //str1 = [self.str substringToIndex:strlong-1];
        self.str = [NSMutableString stringWithFormat:@"%@",[self.str substringToIndex:strlong-1]];
        self.labelText.text = self.str;
        //self.textField.text = self.str;
        NSLog(@"-----------%@",self.str);

    }
    else if (btn.tag == 13)
    {
        NSString *strText = [self.textView.text isEqual:@"备注(选填)"]?@"":self.textView.text;
        NSLog(@"6666%@",strText);
        if (self.str.length == 0) {
            UIAlertView *fristView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"核销码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [fristView show];
            return;
        }
        
        NSString *token = @"~0;id<zOD.{ll@]JKi(:";
        NSString * shopId = @"13";
        NSString *token1 = [token stringByAppendingString:shopId];
        
        NSDictionary *parameters = @{@"shopId":shopId,
                                     @"wltoken":[WXUtil md5:token1],
                                     @"ticket_pwd":self.str
                                     };
        //        NSDictionary *parameters = @{@"shopId":shopId,
        //                                     @"wltoken":[WXUtil md5:token1],
        //                                     @"ticket_pwd":self.labelText.text
        //                                     };

        NSString *url = [NSString stringWithFormat:@"%@/api/drivingShop/consumeTicket",WLHTTP];
        
        AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
        zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *zxdDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",zxdDict[@"msg"]);
            NSLog(@"%@",zxdDict[@"state"]);
            UIAlertView *zxdSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:zxdDict[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [zxdSuccess show];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *zxdFailView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"核销失败,请检查你们网络是否连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [zxdFailView show];
            
            NSLog(@"上传失败");
        }];
        NSLog(@"-----------%@",self.str);

    }
    else{
        
    }
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //[self.view1 setHidden:YES];
    [textField resignFirstResponder];
    
    return NO;
}
//点击空白处的时候隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
        //self.view1.hidden = NO;
    }
    return YES;
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
