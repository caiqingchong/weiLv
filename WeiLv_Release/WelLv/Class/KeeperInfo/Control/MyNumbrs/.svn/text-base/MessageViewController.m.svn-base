//
//  MessageViewController.m
//  WelLv
//
//  Created by mac for csh on 15/5/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "MessageViewController.h"
#import "LXUserTool.h"
#import "LXCommonTools.h"
@interface MessageViewController ()
{
    UISegmentedControl *segmentedControl;
    UIView *_sendMesView;
    UIScrollView *_scrollView;
    
    UITextView *mesTextView;
    UILabel *uilabel;
    
    NSArray *messageArray;
}
@end

@implementation MessageViewController
@synthesize mesModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // [ segmentedControl insertSegmentWithTitle: @"All" atIndex: 0 animated: NO ];
   // [ segmentedControl insertSegmentWithTitle: @"Missed" atIndex: 1 animated: NO ];
    
    NSArray *array=@[@"发送短信",@"短信记录"];
    segmentedControl=[[UISegmentedControl alloc]initWithItems:array];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBordered;
    segmentedControl.selectedSegmentIndex=0;//默认选择
    segmentedControl.tintColor= [UIColor orangeColor];//kColor(225, 146, 20);//设置背景色
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl addTarget: self action: @selector(controlPressed:)forControlEvents: UIControlEventValueChanged];
    
    _sendMesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    [self.view addSubview:_sendMesView];
    [self.view addSubview:_scrollView];
    _sendMesView.backgroundColor = BgViewColor;
    _sendMesView.hidden = NO;
    _scrollView.hidden = YES;
    
    [self initSendmessageView];
    [self initScrollView];
    NSLog(@"%@",mesModel.phone);
    NSLog(@"%@",mesModel.uid);
    NSLog(@"%@",[[LXUserTool alloc] getUid]);
   
}

-(void)initSendmessageView{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ViewWidth(self.view), 35)];
    [label setBackgroundColor:[UIColor whiteColor]];
    label.text = [NSString stringWithFormat:@"%@",mesModel.phone];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor =[UIColor orangeColor];
   // [_sendMesView addSubview:label];
    
    mesTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 15, ViewWidth(self.view)-20*2, 120)];//CGRectMake(20, ViewHeight(label)+ViewY(label), ViewWidth(self.view)-20*2, 120)
    mesTextView.font = [UIFont systemFontOfSize:16];
    mesTextView.backgroundColor = [UIColor whiteColor];//kColor(227, 233, 238);
    mesTextView.textColor = [UIColor blackColor];
    mesTextView.textAlignment = NSTextAlignmentLeft;
    mesTextView.hidden = NO;
    mesTextView.delegate = self;
    [_sendMesView addSubview:mesTextView];
    
    uilabel = [[UILabel alloc] initWithFrame:CGRectMake(20,15, ViewWidth(self.view)-20*2, 35)];//CGRectMake(20, ViewHeight(label)+ViewY(label), ViewWidth(self.view)-20*2, 35)
    uilabel.text = @"请输入短信内容";
    uilabel.enabled = NO;//lable必须设置为不可用
    uilabel.backgroundColor = [UIColor clearColor];
    uilabel.font = [UIFont systemFontOfSize:16];
    [_sendMesView addSubview:uilabel];
    
    UIButton *sendMesBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, ViewY(mesTextView)+ViewHeight(mesTextView)+20, ViewWidth(self.view)-20*2, 40)];
    sendMesBtn.backgroundColor = kColor(57, 246, 177);
    [sendMesBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendMesBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [_sendMesView addSubview:sendMesBtn];

    
    //touch miss kyboard
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [_sendMesView addGestureRecognizer:tapGestureRecognizer];
    

}

//获取短信记录列表
-(void)initScrollView{
      
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"assistant_id":[[LXUserTool alloc] getUid],@"member_id":mesModel.uid};
    [manager POST:GetHouserSmsUrl parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              messageArray = [[NSArray alloc]init];
              messageArray = [dict objectForKey:@"data"];
              NSLog(@"messagearray is  = %@",messageArray);
              float orginY= 0;
              for (int i = 0; i < messageArray.count; i ++) {
                  NSString *str=[[messageArray objectAtIndex:messageArray.count-1-i] objectForKey:@"create_time"];//时间戳
                  NSTimeInterval time=[str doubleValue];//+28800;//因为时差问题要加8小时 == 28800 sec
                  NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                  //实例化一个NSDateFormatter对象
                  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                  //设定时间格式,这里可以设置成自己需要的格式
                  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                  
                  MessageModel* model = [[MessageModel alloc] init];
                  model.dateString = [dateFormatter stringFromDate: detaildate];
                  model.contentString = [[messageArray objectAtIndex:messageArray.count-1-i] objectForKey:@"summary"];
                  
                  MessageView *msView = [[MessageView alloc]initWithModel:model];
                  [msView setFrame:CGRectMake(0, orginY, ViewWidth(_scrollView), [[LXCommonTools sharedMyTools] textHeight:model.contentString Afont:15 width:[[UIScreen mainScreen] bounds].size.width-20]+35+1)];
                  msView.dateLabel.text = model.dateString;
                  msView.contntLabel.text = model.contentString;
                  [_scrollView addSubview:msView];
                  orginY = orginY + ViewHeight(msView);

              }
               _scrollView.contentSize= CGSizeMake(windowContentWidth, orginY + windowContentHeight/2);
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
    
}

- (void) controlPressed:(id)sender {
  //  NSLog(@"segmentControl %d",segmentedControl.selectedSegmentIndex);
    if (segmentedControl.selectedSegmentIndex == 0) {
        _sendMesView.hidden = NO;
        _scrollView.hidden = YES;
    }else if(segmentedControl.selectedSegmentIndex == 1){
        _sendMesView.hidden = YES;
        _scrollView.hidden = NO;
        for(UIView *view in [_scrollView subviews])
        {
            [view removeFromSuperview];
        }
        [self initScrollView];

    }
    
}

//发送短信
-(void)sendMessage{
    NSLog(@"发送短信");
 /*   if (mesTextView.text.length >70) {
        [[LXAlterView sharedMyTools] createTishi:@"短信输入文字不能超过70字"];
    }else */if([mesTextView.text isEqualToString:@""]){
        [[LXAlterView sharedMyTools] createTishi:@"请输入短信内容"];
    }else{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"assistant_id":[[LXUserTool alloc] getUid],@"member_id":mesModel.uid,@"content":mesTextView.text};
    [manager POST:SendMsgUrl parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              NSLog(@"xxxxxxx = %@",dict);
              if ([[dict objectForKey:@"status"] integerValue]== 1) {
                  [[LXAlterView sharedMyTools] createTishi:@"发送成功"];
              }else{
                  [[LXAlterView sharedMyTools] createTishi:@"发送失败，请检查网络"];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"发送失败，请检查网络"];
              
          }];
    }
}

//textViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView == mesTextView && textView.text.length == 0) {
        uilabel.text = @"请输入短信内容";
    }else{
        uilabel.text = @"";
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [mesTextView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [mesTextView resignFirstResponder];
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
