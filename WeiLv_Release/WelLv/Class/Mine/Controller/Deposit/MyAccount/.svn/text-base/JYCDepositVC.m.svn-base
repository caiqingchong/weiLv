//
//  JYCDepositVC.m
//  WelLv
//
//  Created by lyx on 16/1/20.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "JYCDepositVC.h"
#import "bank_model.h"
#import "JYCMyBankCardsCell.h"
@interface JYCDepositVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
{
    AFHTTPRequestOperationManager *manager;
    NSIndexPath *lastIndex;
    UITextField *amountField;
    UITextField *codeTextField;
    NSIndexPath *selectIndex;
    UIButton *depositBtn;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *baseArr;
@property(nonatomic,strong)UIButton *testBtn;
@property(nonatomic,strong)UIScrollView *scrollview;
@end

@implementation JYCDepositVC
- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=BgViewColor;
    self.navigationItem.title=@"提现";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    _baseArr=[[NSMutableArray alloc]init];
    lastIndex=[NSIndexPath indexPathForRow:1000 inSection:0];
    [self initData];
    [self createUI];
    
}
-(void)close
{
     self.navigationController.navigationBarHidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)keyboardWillShow:(NSNotification *)notification
{
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect]; //调整放置有textView的view的位置
    //设置动画
    [UIView beginAnimations:nil context:nil];
    //定义动画时间
    [UIView setAnimationDuration:0.2];
    //设置view的frame，往上平移
    [self.scrollview setFrame:CGRectMake(0, -keyboardRect.size.height, windowContentWidth, windowContentHeight-64-50)];
    
    [depositBtn setFrame:CGRectMake(0, windowContentHeight-64-50-keyboardRect.size.height, windowContentWidth, 50)];
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:nil]; [UIView setAnimationDuration:0.2];
    //设置view的frame，往下平移
    [self.scrollview setFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-50)];
    
    [depositBtn setFrame:CGRectMake(0, windowContentHeight-64-50, windowContentWidth, 50)];
    [UIView commitAnimations];
}

-(void)createUI
{
    self.scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-50)];
    
    self.scrollview.delegate=self;
    
    [self.view addSubview:self.scrollview];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, 0)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.bounces=NO;
    [self.scrollview addSubview:self.tableView];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    

}

-(void)createBotomView
{
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(self.tableView)+10, windowContentWidth, 40)];
    view1.backgroundColor=[UIColor whiteColor];
    [self.scrollview addSubview:view1];
    UILabel *leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    leftLabel.text=@"金额";
    leftLabel.textColor=[UIColor blackColor];
    leftLabel.font=[UIFont systemFontOfSize:16];
    [view1 addSubview:leftLabel];
    amountField=[[UITextField alloc]initWithFrame:CGRectMake(ViewRight(leftLabel)+10, 0, windowContentWidth-50,40)];
    amountField.placeholder=[NSString stringWithFormat:@"当前可提现金额¥%@元",self.maxAmount];
    amountField.delegate=self;
    amountField.returnKeyType=UIReturnKeyDone;
    [view1 addSubview:amountField];
   // UILabel *tishiLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(view1), windowContentWidth-10, 20)];
   // tishiLabel.text=[NSString stringWithFormat:@"每笔限额%@元,本次可提现%@次",self.singleAmount,self.maxNumber];
   
   // tishiLabel.textColor=[UIColor grayColor];
    //tishiLabel.font=[UIFont systemFontOfSize:11];
   // [self.scrollview addSubview:tishiLabel];
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(view1)+10, windowContentWidth, 40)];
    view2.backgroundColor=[UIColor whiteColor];
    [self.scrollview addSubview:view2];
    UILabel *codeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    codeLabel.textColor=[UIColor blackColor];
    codeLabel.text=@"短信验证码";
    codeLabel.font=[UIFont systemFontOfSize:16];
    [view2 addSubview:codeLabel];
    codeTextField=[[UITextField  alloc]initWithFrame:CGRectMake(ViewRight(codeLabel), 0, 100, 40)];
    
    codeTextField.delegate=self;
    codeTextField.returnKeyType =UIReturnKeyDone;
    [view2 addSubview:codeTextField];
    self.testBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-10-90,ViewY(codeTextField)+5, 90, 30)];
    [self.testBtn setBackgroundImage:[UIImage imageNamed:@"获取"] forState:UIControlStateNormal];
    self.testBtn.layer.cornerRadius=4.0;
    [self.testBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.testBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [self.testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.testBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:self.testBtn];
    UILabel *warningLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, ViewBelow(view2)+5, windowContentWidth-10, 40)];
     NSString *str=[[LXUserTool sharedUserTool].getPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    warningLabel.text=[NSString stringWithFormat:@"为确保您的账户安全,提现需要验证手机,验证码将发送至%@。预计提现到账时间从提交提现之日算起约2-7个工作日。",str];
   // warningLabel.text=@"预计提现到账时间从提交提现之日算起约2-7个工作日。";
    warningLabel.textColor=[UIColor grayColor];
    warningLabel.numberOfLines=0;
    warningLabel.font=[UIFont systemFontOfSize:11];
    [self.scrollview addSubview:warningLabel];
    depositBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, windowContentHeight-64-50, windowContentWidth, 50)];
    //提现图片与解绑用一个
    [depositBtn setBackgroundColor:[YXTools stringToColor:@"#ff9a66"]];
   
    [depositBtn setTintColor:[UIColor whiteColor]];
    [depositBtn setTitle:@"提现" forState:UIControlStateNormal];
    depositBtn.titleLabel.font=systemBoldFont(24);
    [depositBtn addTarget:self action:@selector(depositBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:depositBtn];
    if (80*self.baseArr.count+10+150<windowContentHeight-64-50) {
      [self.scrollview setContentSize:CGSizeMake(0,0)];
    }else{
    [self.scrollview setContentSize:CGSizeMake(0,80*self.baseArr.count+10+150)];
    }
}
#pragma mark --提现的请求
-(void)depositBtn
{
  
    //[amountField resignFirstResponder];
   // [codeTextField resignFirstResponder];
    
    DLog(@"==================%@",amountField.text);
    if (!selectIndex) {
        [[LXAlterView sharedMyTools]createTishi:@"您还没选择提现的银行卡"];
        return;
    }
    
    if (amountField.text.length==0 ) {
        [[LXAlterView sharedMyTools]createTishi:@"您还没选择提现金额"];
        return;
    }
    if (codeTextField.text.length==0) {
        [[LXAlterView sharedMyTools]createTishi:@"您还没有输入验证码"];
        return;
    }
    bank_model *model=self.baseArr[selectIndex.row];
    NSString *card_id=model.userid;
    
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *user_id = [LXUserTool sharedUserTool].getUid;
    NSString *token1 = [token stringByAppendingString:user_id];
    NSDictionary *dict=@{@"member_id":user_id,
                         @"_token":[WXUtil md5:token1],@"group_name":[[LXUserTool alloc] getuserGroup],@"amount":amountField.text,@"sms_code":codeTextField.text,@"card_id":card_id};
   [self sentUrl:apply_withdrawals use:dict];
}

#pragma mark --提现的网络请求
-(void)sentUrl:(NSString *)url use:(NSDictionary*)dict
{
    
    //WS(weakSelf);
    //[self setProgressHud];
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@",dict);
        if ([dict[@"flag"]intValue]==1)
        {
          [[LXAlterView sharedMyTools]createTishi:dict[@"msg"]];
          self.navigationController.navigationBarHidden=NO;
          [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [[LXAlterView sharedMyTools]createTishi:dict[@"msg"]];
        }
       [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
    }];
    
    
}

-(void)btnClick
{
   
    if (!selectIndex) {
        [[LXAlterView sharedMyTools]createTishi:@"您还没选择提现的银行卡"];
        return;
    }
    
    if (amountField.text.length==0 ) {
        [[LXAlterView sharedMyTools]createTishi:@"您还没选择提现金额"];
        return;
    }

    [self getPhoneNumber];
}

-(void)getPhoneNumber
{
    [self startTime];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *groupName=[[LXUserTool alloc] getuserGroup];
    
    
    NSDictionary *zxdparameters = @{@"phone":[LXUserTool sharedUserTool].getPhone,@"usergroup":groupName,@"token":@"7a6bd7af36e5db226281a037909fbdfd"};
    
    NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:zxdparameters];
    NSDictionary *dic=@{@"data":str};
    [manager POST:ForgetPwdGetPwd parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *zxdDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [[LXAlterView sharedMyTools]createTishi:zxdDict[@"msg"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"==========00000000000000=============")
    }];
}
#pragma mark-验证码计时
-(void)startTime{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.testBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.testBtn setFrame:CGRectMake(windowContentWidth-5-90, ViewY(codeTextField)+5, 90, 30)];
                self.testBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime;
            if (timeout==60) {
                strTime=[NSString stringWithFormat:@"%d", 60];
            }else{
                strTime = [NSString stringWithFormat:@"%d", seconds];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [self.testBtn setTitle:[NSString stringWithFormat:@"发送验证码(%@秒)",strTime] forState:UIControlStateNormal];
                [self.testBtn setFrame:CGRectMake(windowContentWidth-5-130, ViewY(codeTextField)+5, 130, 30)];
                self.testBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

-(void)initData
{
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *user_id = [LXUserTool sharedUserTool].getUid;
    NSString *token1 = [token stringByAppendingString:user_id];
    NSDictionary *dict=@{@"member_id":user_id,
                         @"_token":[WXUtil md5:token1],@"group_name":[[LXUserTool alloc] getuserGroup]};
    DLog(@"%@",dict);
 
   [self sentUrl:get_card_list and:dict];
    

}
#pragma 请求
-(void)sentUrl:(NSString *)url and:(NSDictionary*)dict
{
    
    WS(weakSelf);
  
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];

    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"flag"]intValue]==1) {
           
            [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
            NSArray *arr=dict[@"data"];
            DLog(@"%@",arr);
            for (NSDictionary *di in arr) {
                bank_model *model=[[bank_model alloc]init];
                [model setValuesForKeysWithDictionary:di];
                [weakSelf.baseArr addObject:model];
            }
        }else{
           [[LXAlterView sharedMyTools]createTishi:dict[@"msg"]];
            [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
            
           
        }
        [weakSelf.tableView setFrame:CGRectMake(0, 10, windowContentWidth, 80*weakSelf.baseArr.count)];
        [weakSelf.tableView reloadData];
         [weakSelf createBotomView];
        DLog(@"%@",dict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       DLog(@"%@",error);
        
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
    }];
    
    
}




#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
   
    return self.baseArr.count;
  }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
        return 80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
    static NSString * cellIndetifier1000 = @"cellIndetifier1000";
    JYCMyBankCardsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier1000];
    if (cell == nil) {
        cell = [[JYCMyBankCardsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier1000];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
        }
    
    bank_model *model=[[bank_model alloc]init];
    model=self.baseArr[indexPath.row];
    
    cell.model=model;
    
    return cell;
}

//点击某一行时候触发的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DLog(@"%@",lastIndex);
    if (lastIndex.row==indexPath.row) {
        JYCMyBankCardsCell * cell2=(JYCMyBankCardsCell *)[tableView cellForRowAtIndexPath:lastIndex];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 17, 12)];
        imageView.image=[UIImage imageNamed:@"12"];
        cell2.accessoryView=imageView;
        lastIndex=[NSIndexPath indexPathForRow:10000 inSection:0];//把index置为一个不可能相等的数
        selectIndex=nil;
    }else{
    JYCMyBankCardsCell * cell3=(JYCMyBankCardsCell *)[tableView cellForRowAtIndexPath:lastIndex];
    UIImageView *imageView3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 17, 12)];
    imageView3.image=[UIImage imageNamed:@"12"];
    cell3.accessoryView=imageView3;
     
    JYCMyBankCardsCell * cell2=(JYCMyBankCardsCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 17, 12)];
    imageView2.image=[UIImage imageNamed:@"矩形对勾"];
    cell2.accessoryView=imageView2;
    lastIndex=indexPath;
    selectIndex=indexPath;
    DLog(@"%@",lastIndex);
    }
  
}




-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}
#pragma textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    DLog(@"%f----",scrollView.contentOffset.y);
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
