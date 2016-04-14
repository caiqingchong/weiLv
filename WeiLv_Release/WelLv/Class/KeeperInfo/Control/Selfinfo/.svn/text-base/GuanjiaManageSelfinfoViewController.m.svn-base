//
//  GuanjiaManageSelfinfoViewController.m
//  WelLv
//
//  Created by mac for csh on 15/5/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "GuanjiaManageSelfinfoViewController.h"
#import "GuanjiaInfoViewController.h"

#define geyanLength 255
#define dizhiLength 128
#define yewuLngth 255

@interface GuanjiaManageSelfinfoViewController ()
{
    UITextView *mesTextView;
    NSMutableDictionary *infoDivtionary;
    NSInteger  textLength;
    UILabel *countLabel;
}
@end

@implementation GuanjiaManageSelfinfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    infoDivtionary =[[NSMutableDictionary alloc]init];
    infoDivtionary =  [[[NSUserDefaults standardUserDefaults] objectForKey:AssitantData] mutableCopy];
  //  NSLog(@"dic1 = %@",infoDivtionary),
    [self initview];
}

-(void)initview{
    
    UIView *vv = [[UIView alloc] initWithFrame: CGRectMake(0, 15, windowContentWidth, 130)];
    vv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vv];
    mesTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 0, ViewWidth(vv)-30, ViewHeight(vv)-20)];
    mesTextView.font = [UIFont systemFontOfSize:16];
    mesTextView.backgroundColor = [UIColor clearColor];
    mesTextView.textColor = [UIColor blackColor];
    mesTextView.text = [infoDivtionary objectForKey:@""];
    mesTextView.textAlignment = NSTextAlignmentLeft;
    mesTextView.hidden = NO;
    mesTextView.delegate = self;
    [vv addSubview:mesTextView];
    
    if ([self.title isEqualToString:@"精通业务"]) {
       mesTextView.text = [self judgeReturnString:[infoDivtionary objectForKey:@"advantage"] withReplaceString:@""];
        textLength = yewuLngth;
    }else if([self.title isEqualToString:@"管家所属"]){
        mesTextView.text = [self judgeReturnString:[infoDivtionary objectForKey:@"belong"] withReplaceString:@""];
       // textLength = suo
    }else if([self.title isEqualToString:@"公司地址"]){
        mesTextView.text = [self judgeReturnString:[infoDivtionary objectForKey:@"address"] withReplaceString:@""];
        textLength = dizhiLength;
    }else if([self.title isEqualToString:@"人生格言"]){
        mesTextView.text = [self judgeReturnString:[infoDivtionary objectForKey:@"motto"] withReplaceString:@""];
        textLength = geyanLength;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld/%ld",mesTextView.text.length,textLength]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,[str length]-2)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange([str length]-4,4)];
  //  [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:11] range:NSMakeRange([str length]-4,4)];
    countLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewWidth(vv)-55, ViewHeight(vv)-15, 45, 15)];
    countLabel.attributedText = str;
    countLabel.font = [UIFont systemFontOfSize:11];
    countLabel.textAlignment = NSTextAlignmentRight;
    [vv addSubview:countLabel];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(15, ViewY(vv)+ViewHeight(vv)+15, ViewWidth(mesTextView), 20)];
    [label1 setBackgroundColor:[UIColor clearColor]];
    label1.text = [NSString stringWithFormat:@"备注：您填写的信息将会展示给用户和会员，请认真填写"];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor =[UIColor blackColor];
    [self.view addSubview:label1];

    
    //touch miss kyboard
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}

-(void)conserve{
//1、上传服务器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *infodic = @{@"motto":mesTextView.text};
    if ([self.title isEqualToString:@"精通业务"]) {
        infodic = @{@"advantage":mesTextView.text};
    }else if([self.title isEqualToString:@"管家所属"]){
        infodic = @{@"region":mesTextView.text};
    }else if([self.title isEqualToString:@"公司地址"]){
        infodic = @{@"address":mesTextView.text};
    }else if([self.title isEqualToString:@"人生格言"]){
        infodic = @{@"motto":mesTextView.text};
    }
    
    NSDictionary *parameters = @{@"assistant_id":[infoDivtionary objectForKey:@"id"],@"data":[self dictionaryToJson:infodic]};
    [manager POST:GJManageSelfInfoUrl parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              if([[dict objectForKey:@"status"]integerValue] == 1){
                  [[LXAlterView sharedMyTools] createTishi:@"操作成功"];
                  //2、传给上个页面
                  //添加 字典，将label的值通过key值设置传递
                  NSDictionary *dict =[[NSDictionary alloc] initWithObjectsAndKeys:self.title,@"title",mesTextView.text,@"textViewString", nil];
                  //创建通知
                  NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dict];
                  //通过通知中心发送通知
                  [[NSNotificationCenter defaultCenter] postNotification:notification];
                  [self.navigationController popViewControllerAnimated:YES];

                
                  // cun 村本地
                  if ([self.title isEqualToString:@"精通业务"]) {
                      [infoDivtionary setValue:mesTextView.text forKey:@"advantage"];
                  }else if([self.title isEqualToString:@"管家所属"]){
                      [infoDivtionary setValue:mesTextView.text forKey:@"belong"];
                  }else if([self.title isEqualToString:@"公司地址"]){
                      [infoDivtionary setValue:mesTextView.text forKey:@"address"];
                  }else if([self.title isEqualToString:@"人生格言"]){
                      [infoDivtionary setValue:mesTextView.text forKey:@"motto"];
                  }
                  [[NSUserDefaults standardUserDefaults] setObject:infoDivtionary forKey:AssitantData];
                //  NSLog(@"dic2 = %@",infoDivtionary);
              }
              
          //    NSLog(@"dict = %@  \n msg = %@",dict,[dict objectForKey:@"msg"]);
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
}

//字典数据转Json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
//textViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > textLength)
    {
        textView.text = [textView.text substringToIndex:textLength];
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld/%ld",mesTextView.text.length,textLength]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0,[str length]-2)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange([str length]-4,4)];
   // [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:11] range:NSMakeRange([str length]-4,4)];
    countLabel.attributedText = str;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
  //  NSLog(@"1is%ld",textView.text.length);
    if ([text isEqualToString:@"\n"]){
        [mesTextView resignFirstResponder];
        return NO;
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
