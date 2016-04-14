//
//  CSHRefuseViewController.m
//  WelLv
//
//  Created by mac for csh on 15/11/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "CSHRefuseViewController.h"
#import "WXUtil.h"

@interface CSHRefuseViewController ()

{

}

@end

@implementation CSHRefuseViewController
@synthesize main_phone,shopid,member_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"拒绝理由";
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);

    textV = [[CSHTextView alloc] initWithFrame:CGRectMake(0, 15, windowContentWidth, 100)];
    textV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:textV];
}

-(void)conserve{
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    NSString *str = [self judgeReturnString:textV.contentView.text withReplaceString:@""];
     NSDictionary *parameters =@{@"assistant_id":[[LXUserTool alloc] getUid],@"wltoken":md5str,@"status":@"3",@"main_phone":self.main_phone,@"features_eat_partner_id":self.shopid,@"member_id":self.member_id,@"msg":str};
    //NSLog(@"%@",parameters);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:AduitUrl parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSRange range = [html rangeOfString:@"{"];
              html = [html substringFromIndex:range.location];
              
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              //NSLog(@"dict = %@ msg =%@" ,dict,[dict objectForKey:@"msg"]);
              if ([[dict objectForKey:@"state"] integerValue] ==1) {
                  [self.navigationController popViewControllerAnimated:YES];
                  [self.navigationController popViewControllerAnimated:YES];
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
                  
              }else{
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
              }
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];

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

@implementation CSHTextView
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
    _contentView.font = [UIFont systemFontOfSize:14];
    [self addSubview:_contentView];
    
    _placeholderLabel = [YXTools allocLabel:@"请填写拒绝申请开户的理由..." font:systemFont(14) textColor:[UIColor grayColor] frame:CGRectMake(Begin_X+5, ViewY(_contentView)+5, ViewWidth(_contentView)-5, 20) textAlignment:0];
    
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

