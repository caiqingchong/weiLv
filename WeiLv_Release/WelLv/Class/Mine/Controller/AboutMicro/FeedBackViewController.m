//
//  FeedBackViewController.m
//  WelLv
//
//  Created by lyx on 15/4/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "FeedBackViewController.h"
#import "YXRadioView.h"

#define PNumber @"4006199619"

@interface FeedBackViewController ()
{
    NSArray *beekArr;
    YXRadioView *radioView;
}
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgViewColor;
    self.title = @"意见反馈";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 30);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    btn.titleLabel.font =systemBoldFont(18);
    [btn  setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submitFeedBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    [self initView];
}

- (void)initView
{
    UIView *feedbackView = [[UIView alloc] init];
    feedbackView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:feedbackView];
    beekArr = [NSArray arrayWithObjects:@"功能不好用",@"没有合适线路",@"线路介绍不清楚",@"订单投诉",@"其他", nil];
    
    UILabel *feedBackLabel = [YXTools allocLabel:@"反馈类型" font:[UIFont systemFontOfSize:14 weight:0.5] textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, 15, 150, 30) textAlignment:0];
    [_scrollView addSubview:feedBackLabel];
    
    //反馈类型的项
    radioView = [[YXRadioView alloc] initWithFrame:CGRectMake(Begin_X, ViewHeight(feedBackLabel)+ViewY(feedBackLabel), ViewWidth(_scrollView) - Begin_X*2, 2*50) array:[NSMutableArray arrayWithArray:beekArr]];
    [radioView selectedIndexBtn:0];
    [_scrollView addSubview:radioView];
    
    
    feedbackView.frame = CGRectMake(0, 0, ViewWidth(_scrollView), ViewY(radioView)+ViewHeight(radioView)-15+25);
   
    UIView *feedContentView = [[UIView alloc] init];
    feedContentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:feedContentView];
    
    
    //创建反馈内容
    _neriorView=[[YXTextView alloc] initWithFrame:CGRectMake(0,ViewBelow(feedbackView)+15,ViewWidth(_scrollView),141)];
    [_scrollView addSubview:_neriorView];
    feedContentView.frame = CGRectMake(0, ViewY(_neriorView), ViewWidth(_scrollView), ViewHeight(_neriorView));
    
    
    UIView * phoneView = [[UIView alloc] initWithFrame:CGRectMake(0,ViewBelow(feedContentView)+15, ViewWidth(_scrollView), 40)];
    phoneView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:phoneView];

    UILabel *contactLabel = [YXTools allocLabel:@"联系电话" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X,  ViewBelow(feedContentView)+15, 80, 40) textAlignment:0];
    [_scrollView addSubview:contactLabel];

    UILabel *phoneLabel = [YXTools allocLabel:PNumber font:systemFont(14) textColor:[UIColor grayColor] frame:CGRectMake(ViewWidth(contactLabel)+ViewX(contactLabel), ViewY(contactLabel),ViewWidth(_scrollView)-80-Begin_X*2, 40) textAlignment:0];
    [_scrollView addSubview:phoneLabel];
    UIButton *callBtn = [[UIButton alloc] initWithFrame:CGRectMake(ViewWidth(_scrollView) - 30 - 15  , ViewY(contactLabel) + 7.5, 25, 25)];
     [callBtn setBackgroundImage:[UIImage imageNamed:@"电话"] forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(MakeTelephoneCall) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:callBtn];



    NSString *phone=@"";
    if ([[LXUserTool alloc] getPhone]) {
        phone = [[LXUserTool alloc] getPhone];
    }
    _phoneLabel = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(contactLabel)+ViewX(contactLabel), ViewY(contactLabel),ViewWidth(_scrollView)-100-Begin_X, 30)];
    _phoneLabel.placeholder = @"请输入电话号码";
    _phoneLabel.text = phone;
    _phoneLabel.font = systemFont(13);

    _scrollView.contentSize = CGSizeMake(0, ViewHeight(phoneView)+ViewY(phoneView)+200);

}

-(void)MakeTelephoneCall{
    NSString *number = PNumber;// 此处读入电话号码
 /*  //直接打电话
     NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
  */
    //弹窗询问拨打  1-确定-拨打  2-取消
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
   
}

//提交反馈
- (void)submitFeedBack
{
    if ([YXTools stringIsNotNullTrim:_neriorView.contentView.text]) {
        [[LXAlterView sharedMyTools] createTishi:@"反馈内容不可为空"];
        return;
    }
    NSString *feekStr = [beekArr objectAtIndex:radioView.selectedIndex];
    NSString *uid = [NSString stringWithFormat:@"%@",[[LXUserTool alloc] getUid]];
    NSString *memberType= @"";
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"member"])
    {
        memberType = @"m";      //是会员
    }else
    {
        memberType = @"a";      //是管家
    }
    NSDictionary *parment = @{@"id":uid,@"check":memberType,@"type":feekStr,@"content":_neriorView.contentView.text,@"phone":_phoneLabel.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:FeedbackUrl parameters:parment success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         if (json != nil) {
             if ([[json objectForKey:@"status"] intValue] == 1) {
                  [[LXAlterView sharedMyTools] createTishi:@"提交成功！"];
                 [self performSelector:@selector(close) withObject:nil afterDelay:1];
             }else
             {
                 [[LXAlterView sharedMyTools] createTishi:[json objectForKey:@"msg"]];
             }
         }

         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         [[LXAlterView sharedMyTools] createTishi:@"提交失败！"];
     }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

@implementation YXTextView
@synthesize contentView = _contentView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self initView];
    }
    return self;
}
- (void)initView
{
    _contentView = [[UITextView alloc] initWithFrame:CGRectMake(Begin_X,  0, ViewWidth(self)-Begin_X*2, self.frame.size.height)];
    _contentView.delegate = self;
    [self addSubview:_contentView];
    
    _placeholderLabel = [YXTools allocLabel:@"还有什么不满意？欢迎吐槽~" font:systemFont(12) textColor:[UIColor grayColor] frame:CGRectMake(Begin_X+5, ViewY(_contentView)+5, ViewWidth(_contentView)-5, 20) textAlignment:0];
    
    [self addSubview:_placeholderLabel];
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSString *content=textView.text;
    
    if (content.length > 0)
    {
        _placeholderLabel.hidden = YES;
        
    }
    else
    {
        _placeholderLabel.hidden = NO;
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //  NSLog(@"1is%ld",textView.text.length);
    if ([text isEqualToString:@"\n"]){
        [_contentView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
/*
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [mesTextView resignFirstResponder];
}
*/
@end
