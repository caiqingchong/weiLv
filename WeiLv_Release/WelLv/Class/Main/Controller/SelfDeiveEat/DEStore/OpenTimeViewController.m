//
//  OpenTimeViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/10.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "OpenTimeViewController.h"

@interface OpenTimeViewController ()<UITextViewDelegate,UIAlertViewDelegate>
{
    UITextView *_view1;
    NSInteger numbt;
    UILabel *label1;
    UILabel *label2;
    UILabel *labelTime;
    UIDatePicker *_datapicker1;
    UIDatePicker *_datapicker2;
    //选择器载体
    UIView *viewData;
    UIScrollView *_zxdScrollView;
}
@property(nonatomic,strong)UITextView *view1;
@property(nonatomic,strong)UIDatePicker *datapicker1;
@property(nonatomic,strong)UIDatePicker *datapicker2;
@property(nonatomic,strong)UIScrollView *zxdScrollView;
@end

@implementation OpenTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(btnBc)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    numbt = 0;
    // Do any additional setup after loading the view.
    [self creatscrollView];
    [self creatView];
    [self creatText];
    [self creatDataView];
    
}
-(void)creatscrollView
{
    self.zxdScrollView = [[UIScrollView alloc] init];
    self.zxdScrollView.frame = CGRectMake(0, 0, windowContentWidth, windowContentHeight);
    self.zxdScrollView.backgroundColor = BgViewColor;
    self.zxdScrollView.showsVerticalScrollIndicator = NO;
   
   self.zxdScrollView.contentSize = CGSizeMake(windowContentWidth, windowContentHeight-44);
    
    
    [self.view addSubview:self.zxdScrollView];
}
-(void)creatView
{
    NSArray *arr = @[@"营业时间1",@"营业时间2"];
    
    for (int i=0; i<arr.count; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame =CGRectMake(0, 15+45*i, windowContentWidth, 45);
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] init];
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentLeft;
        label.frame = CGRectMake(5, 5, 80, 35);
        [view addSubview:label];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 0, windowContentWidth, 45);
        //btn.backgroundColor = [UIColor redColor];
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = 11+i;
        //NSLog(@"")
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45 , ViewHeight(view)/2-15, 45, 30)];
        [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [view addSubview:IGV];
        if (i==0) {
            label1 = [[UILabel alloc] init];
            label1.frame = CGRectMake(80, 5, windowContentWidth-80-45, 30);
            label1.textAlignment = NSTextAlignmentCenter;
            //label1.text = @"请输入营业时间";
            label1.font = [UIFont systemFontOfSize:14];
            [view addSubview:label1];
            
        }
        else
        {
            label2 = [[UILabel alloc] init];
            label2.frame = CGRectMake(80, 5, windowContentWidth-80-45, 30);
            //label2.text = @"请输入营业时间";
            label2.textAlignment = NSTextAlignmentCenter;
            label2.font = [UIFont systemFontOfSize:14];
            [view addSubview:label2];

        }
        [self.zxdScrollView addSubview:view];
    }
    UILabel *labrlline = [[UILabel alloc] init];
    labrlline.frame = CGRectMake(5, 15+45, windowContentWidth-10, 1);
    labrlline.backgroundColor = BgViewColor;
    [self.zxdScrollView addSubview:labrlline];
}
-(void)btnClick:(UIButton *)btn
{
    viewData.hidden = NO;
    [self.view1 resignFirstResponder];
    self.zxdScrollView.contentSize = CGSizeMake(windowContentWidth, 520);
    if (btn.tag == 11) {
        label1.text = @"请输入营业时间";
        numbt = 1;
        return;
    }
    if (btn.tag == 12) {
        label2.text = @"请输入营业时间";
        numbt = 2;
        return;
    }
    

    
}
-(void)creatText
{
    self.view1 = [[UITextView alloc] init];
    self.view1.frame = CGRectMake(0, 30+90, windowContentWidth, 90);
    self.view1.text  = @"备注";
    
    self.view1.delegate = self;
    self.view1.textAlignment = NSTextAlignmentLeft;
    self.view1.font = [UIFont systemFontOfSize:17];
    [self.zxdScrollView addSubview:self.view1];
}
//保存
-(void)btnBc
{
    NSMutableString *str1;
    NSMutableString *str2;
    NSMutableString *str3;
    if ([label1.text isEqualToString:@"请输入营业时间"]) {
        str1 = [NSMutableString stringWithFormat:@"%@",@""];
    }
    else
    {
        str1 = [NSMutableString stringWithFormat:@"%@",label1.text];
    }
    if ([label2.text isEqualToString:@"请输入营业时间"]) {
        str2 = [NSMutableString stringWithFormat:@"%@",@""];
    }
    else
    {
        str2 = [NSMutableString stringWithFormat:@"%@",label2.text];
    }
    if ([self.view1.text isEqualToString:@"备注"]) {
        str3 = [NSMutableString stringWithFormat:@"%@",@""];
    }
    else
    {
        str3 = [NSMutableString stringWithFormat:@"%@",self.view1.text];
    }
    if (str1.length == 0 &&str2.length == 0) {
        UIAlertView *zxdAlert2 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲,必须至少有一个营业之间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [zxdAlert2 show];
        return;

    }
   // NSLog(@"%@",str2);
    //NSMutableString *str4 = [NSMutableString stringWithFormat:@"%@\n%@\n%@",str1,str2,str3];
    NSDictionary *dic = @{@"arrindex1":[NSString stringWithFormat:@"%ld",(long)self.arrindex1],@"arrindex2":[NSString stringWithFormat:@"%ld",(long)self.arrindex2],@"text1":str1,@"text2":str2,@"text3":str3};
    //NSLog(@"===================%@",str4);
    NSNotification *notification = [NSNotification notificationWithName:@"zxdZZ" object:nil userInfo:dic];

    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -时间选择器
-(void)creatDataView
{
    viewData = [[UIView alloc] init];
    viewData.backgroundColor = [UIColor whiteColor];
    viewData.frame = CGRectMake(0, 220, windowContentWidth, 280);
    viewData.hidden = YES;
    labelTime = [[UILabel alloc] init];
    labelTime.frame = CGRectMake(50, 0, windowContentWidth-100, 30);
    labelTime.textAlignment = NSTextAlignmentCenter;
    labelTime.font = [UIFont systemFontOfSize:15];
    [viewData addSubview:labelTime];
    [self.zxdScrollView addSubview:viewData];
    self.datapicker1 = [[UIDatePicker alloc] init];
    self.datapicker1.tag = 61;
    self.datapicker1.frame = CGRectMake(0, 30, windowContentWidth/2, 270);
    [self.datapicker1 setDatePickerMode:UIDatePickerModeTime];
    // NSData *data = [self.datapicker date];
    // self.datapicker.hidden = YES;
    [self.datapicker1 addTarget:self action:@selector(datachanged:) forControlEvents:UIControlEventValueChanged];
    UIButton *btuuton = [UIButton buttonWithType:UIButtonTypeSystem];
    [btuuton setTitle:@"取消" forState:UIControlStateNormal];
    btuuton.frame =CGRectMake(0, 0, 50, 30);
    btuuton.tag = 51;
    [btuuton addTarget:self action:@selector(zxdbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewData addSubview:btuuton];
    //label.text = [NSString stringWithFormat:@"%@",[self.datapicker date]];
    [viewData addSubview:self.datapicker1];
    
    self.datapicker2 = [[UIDatePicker alloc] init];
    self.datapicker2.tag = 62;
    self.datapicker2.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width)/2, 30, ([[UIScreen mainScreen] bounds].size.width)/2, 270);
    [self.datapicker2 setDatePickerMode:UIDatePickerModeTime];
    // NSData *data = [self.datapicker date];
    // self.datapicker.hidden = YES;
    [self.datapicker2 addTarget:self action:@selector(datachanged:) forControlEvents:UIControlEventValueChanged];
    //label.text = [NSString stringWithFormat:@"%@",[self.datapicker date]];
    UIButton *btuuton2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btuuton2 setTitle:@"确定" forState:UIControlStateNormal];
    btuuton2.frame =CGRectMake(([[UIScreen mainScreen] bounds].size.width)-50, 0, 50, 30);
    btuuton2.tag = 52;
    [btuuton2 addTarget:self action:@selector(zxdbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [viewData addSubview:btuuton2];
    [viewData addSubview:self.datapicker2];

}
-(void)zxdbtnClick:(UIButton *)btn
{
    if (btn.tag == 51) {
        self.zxdScrollView.contentSize = CGSizeMake(windowContentWidth,windowContentHeight-44);
        viewData.hidden = YES;
        
        NSLog(@"取消");
        return;
    }
    if (btn.tag == 52) {
        UIDatePicker *pick1 = (UIDatePicker *)[self.view viewWithTag:61];
        UIDatePicker *pick2 = (UIDatePicker *)[self.view viewWithTag:62];
        NSDate  *date1 = pick1.date;
        NSDate  *date2 = pick2.date;
        if ([date2 isEqualToDate:[date1 earlierDate:date2]]) {
            UIAlertView *zxdAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"开始时间不能晚于结束时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [zxdAlert show];
            
            NSLog(@"+++99999++++");
            return;
        }
        if (numbt == 1) {
            label1.text = labelTime.text;
        }
        if (numbt == 2) {
            label2.text = labelTime.text;

        }
        NSLog(@"确定");

        return;
    }
    
}
-(void)datachanged:(UIDatePicker *)sender
{
    UIDatePicker *pick1 = (UIDatePicker *)[self.view viewWithTag:61];
    UIDatePicker *pick2 = (UIDatePicker *)[self.view viewWithTag:62];
    NSDate  *date1 = pick1.date;
    NSDate  *date2 = pick2.date;
    //NSLog(@"%d",[date1 earlierDate:date2]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm"];
   // UIDatePicker *control = (UIDatePicker *)sender;
    NSDate *date = sender.date;
    if (sender.tag == 61) {
        NSLog(@"++123+++");
       labelTime.text = [NSString stringWithFormat:@"%@--%@",[dateFormatter stringFromDate:date],[dateFormatter stringFromDate:date2]];
    }
    if(sender.tag == 62)
    {
        labelTime.text = [NSString stringWithFormat:@"%@--%@",[dateFormatter stringFromDate:date1],[dateFormatter stringFromDate:date]];
    }
   
    
    //labelTime.text = [dateFormatter stringFromDate:date];
    NSLog(@"%@",date);
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.zxdScrollView.contentSize = CGSizeMake(windowContentWidth,windowContentHeight-44);
    NSLog(@"+++++++++++++++++++++++++");
    viewData.hidden = YES;
    return YES;
}
/*
#pragma mark - Navigation
/Users/liuxin/Desktop/WelLv/WelLv/Class/Main/Controller/SelfDeiveEat/MYselfViewController.h
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
