//
//  ManagCusInfoViewController.m
//  WelLv
//
//  Created by mac for csh on 15/4/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ManagCusInfoViewController.h"
#import "LXUserTool.h"
#import "CheckIDNumber.h"

@interface ManagCusInfoViewController ()

@end

@implementation ManagCusInfoViewController
@synthesize  bgimage,zjButton,cusInfoArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =BgViewColor;
    
    if (cusInfoArray) {
        [cusInfoArray removeAllObjects];
    }else{
        cusInfoArray=[NSMutableArray array];
    }
     cusInfoArray=[NSMutableArray array];
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    cusInfoArray = [NSMutableArray arrayWithArray:[settings objectForKey:@"custom"]];
    
    
    [self.navigationItem setTitle:@"添加常用游客"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor =[UIColor orangeColor];
    
    
    //kColor(255, 165, 98);// [UIColor colorWithRed:255/255.0 green:165/255.0 blue:98/255.0 alpha:1];
    
    bgimage = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 50*4)];
    bgimage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgimage];
    
    //初始化labeel
    UILabel *namLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 50)];
    namLabel.text = @"姓名";
    namLabel.backgroundColor = [UIColor clearColor];
    namLabel.textAlignment = NSTextAlignmentLeft;
    namLabel.font = [UIFont systemFontOfSize:16];
    [bgimage addSubview: namLabel];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(namLabel)+ViewHeight(namLabel)-1, windowContentWidth, 0.3)];
    view1.backgroundColor = [UIColor lightGrayColor];
    [bgimage addSubview:view1];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(namLabel), ViewY(namLabel)+ViewHeight(namLabel), ViewWidth(namLabel), 50)];
    phoneLabel.text = @"手机";
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.font = [UIFont systemFontOfSize:16];
    [bgimage addSubview: phoneLabel];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(phoneLabel)+ViewHeight(phoneLabel)-1, windowContentWidth, 0.3)];
    view2.backgroundColor = [UIColor lightGrayColor];
    [bgimage addSubview:view2];
    
    UILabel *zjLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(phoneLabel), ViewY(phoneLabel)+ViewHeight(phoneLabel), ViewWidth(phoneLabel), 50)];
    zjLabel.text = @"证件类型";
    zjLabel.backgroundColor = [UIColor clearColor];
    zjLabel.textAlignment = NSTextAlignmentLeft;
    zjLabel.font = [UIFont systemFontOfSize:16];
    [bgimage addSubview: zjLabel];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(zjLabel)+ViewHeight(zjLabel)-1, windowContentWidth, 0.3)];
    view3.backgroundColor = [UIColor lightGrayColor];
    [bgimage addSubview:view3];
    
    UILabel *zjhLabl = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(zjLabel), ViewY(zjLabel)+ViewHeight(zjLabel), ViewWidth(zjLabel), 50)];
    zjhLabl.text = @"证件号";
    zjhLabl.backgroundColor = [UIColor clearColor];
    zjhLabl.textAlignment = NSTextAlignmentLeft;
    zjhLabl.font = [UIFont systemFontOfSize:16];
    [bgimage addSubview: zjhLabl];
    /* UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(zjhLabl)+ViewHeight(zjhLabl)-1, windowContentWidth, 0.3)];
     view4.backgroundColor = [UIColor lightGrayColor];
     [bgimage addSubview:view4];*/
    
    UILabel *bzLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(zjhLabl), ViewY(zjhLabl)+ViewHeight(zjhLabl)+20, 40, 40)];
    bzLabel.text = @"备注";
    bzLabel.backgroundColor = [UIColor clearColor];
    bzLabel.textAlignment = NSTextAlignmentLeft;
    bzLabel.textColor = [UIColor lightGrayColor];
    bzLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:bzLabel];
    
    UILabel *bzzLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(bzLabel)+ViewWidth(bzLabel), ViewY(zjhLabl)+ViewHeight(zjhLabl)+20, [[UIScreen mainScreen] bounds].size.width-100, 40)];
    bzzLabel.text = @"请填写真实信息,以便为您提供服务";
    bzzLabel.backgroundColor = [UIColor clearColor];
    bzzLabel.textAlignment = NSTextAlignmentLeft;
    bzzLabel.textColor = [UIColor lightGrayColor];
    bzzLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:bzzLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(30,ViewY(bzLabel)+ViewHeight(bzLabel), [[UIScreen mainScreen] bounds].size.width-30*2, 40);
    [btn setTitle:@"保    存" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];//加粗
    [btn setBackgroundColor: kColor(57, 246, 177)];
    [btn addTarget:self action:@selector(conserve) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //填写项初始化
    namTextFild = [[UITextField alloc ]initWithFrame:CGRectMake(ViewX(namLabel)+ViewWidth(namLabel),ViewY(namLabel)+20,windowContentWidth - ViewX(namLabel)*2 , ViewHeight(namLabel))];
    namTextFild.placeholder = @"必填";
    namTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    namTextFild.font = [UIFont systemFontOfSize:16];
    namTextFild.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:namTextFild];namTextFild.delegate = self;
    
    zjhTextFild = [[UITextField alloc ]initWithFrame:CGRectMake(ViewX(zjhLabl)+ViewWidth(zjhLabl),ViewY(zjhLabl)+20,windowContentWidth - ViewX(zjhLabl)*2 , ViewHeight(zjhLabl))];
    zjhTextFild.placeholder = @"选填";
    zjhTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    zjhTextFild.font= [UIFont systemFontOfSize:16];;
    zjhTextFild.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:zjhTextFild];zjhTextFild.delegate = self;

    phoneTextFild = [[UITextField alloc ]initWithFrame:CGRectMake(ViewX(phoneLabel)+ViewWidth(phoneLabel),ViewY(phoneLabel)+20,windowContentWidth - ViewX(phoneLabel)*2 , ViewHeight(phoneLabel))];
    phoneTextFild.placeholder = @"必填";
    phoneTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextFild.font= [UIFont systemFontOfSize:16];
    phoneTextFild.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:phoneTextFild];phoneTextFild.delegate = self;
    
    zjButton = [[UIButton alloc] initWithFrame:CGRectMake(ViewX(zjLabel)+ViewWidth(zjLabel),ViewY(zjLabel)+20,windowContentWidth - ViewX(zjLabel)*2 , ViewHeight(zjLabel))];
    [zjButton setTitle:@"请选择" forState:UIControlStateNormal];
    zjButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [zjButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zjButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [zjButton addTarget:self action:@selector(loadPickerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zjButton];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadPickerView{
    if (!pView) {
        titArray = [NSArray arrayWithObjects:@"身份证",@"护照",@"军官证", @"港澳通行证", @"台胞证", nil];
        picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,25, [[UIScreen mainScreen] bounds].size.width, 140)];
        picker.backgroundColor = [UIColor whiteColor];
        picker.delegate = self; picker.dataSource =self;
        pView =  [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight-150-64-25, [[UIScreen mainScreen] bounds].size.width, 140+25)];
        pView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:pView];
        [pView addSubview:picker];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake( [[UIScreen mainScreen] bounds].size.width-40,0, 40, 25);
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn addTarget:self action:@selector(setIDType) forControlEvents:UIControlEventTouchUpInside];
        [pView addSubview:btn];
        if ([zjButton.titleLabel.text isEqualToString:@"身份证"]) {
            [picker selectRow:0 inComponent:0 animated:NO];
        }else if ([zjButton.titleLabel.text isEqualToString:@"护照"]) {
            [picker selectRow:1 inComponent:0 animated:NO];
        }else if ([zjButton.titleLabel.text isEqualToString:@"军官证"]) {
            [picker selectRow:2 inComponent:0 animated:NO];
        }else if ([zjButton.titleLabel.text isEqualToString:@"港澳通行证"]) {
            [picker selectRow:3 inComponent:0 animated:NO];
        }else if ([zjButton.titleLabel.text isEqualToString:@"台胞证"]) {
            [picker selectRow:4 inComponent:0 animated:NO];
        }else{
            [picker selectRow:0 inComponent:0 animated:NO];
            [zjButton setTitle:@"身份证" forState:UIControlStateNormal];
        }
        
    }else{
        pView.hidden =NO;
    }

}


/*-(void)chooseCertificate{
    bgChoiceView.hidden = NO;
    titArray = [NSArray arrayWithObjects:@"身份证",@"护照",@"军官证", @"港澳通行证", @"台胞证", nil];
    bgChoiceView.frame = CGRectMake(40+0.3*[[UIScreen mainScreen] bounds].size.width, 20+40*2, 170, 30*[titArray count]);
    bgChoiceView.backgroundColor = [UIColor lightGrayColor];
    for(int i = 0 ; i < [titArray count];i ++){
        NSString *str = [titArray objectAtIndex:i];
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 30*i, 170, 30)];
        [btn1 setTitle:str forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [btn1 addTarget:self action:@selector(changeCertificate:) forControlEvents:UIControlEventTouchUpInside];
        btn1.tag = i;
        [bgChoiceView addSubview:btn1];
        
        UILabel* label3 = [[UILabel alloc] initWithFrame: CGRectMake(30, 30*i, 110, 0.25)];
        label3.layer.borderColor = [[UIColor grayColor] CGColor];
        label3.layer.borderWidth = 0.25;
        [bgChoiceView addSubview:label3];
        
    }
    [self.view addSubview:bgChoiceView];
}

-(void)changeCertificate:(id)sender{
    //把传递过来的控件参数转化成按钮
    UIButton *btn=(UIButton *)sender;
    //把btn.tag转化成整型
  //  zjButton.titleLabel.text = [titArray objectAtIndex:(int)btn.tag];
    [zjButton setTitle:[titArray objectAtIndex:(int)btn.tag] forState:UIControlStateNormal];
    bgChoiceView.hidden = YES;
}
*/

-(void)setIDType{
    pView.hidden =YES;
}
-(void)getBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存
-(void)conserve{
    NSString *Checkstr = @"请选择";
    
    if ([zjButton.titleLabel.text isEqualToString: @"身份证"]) {
        Checkstr = @"1";
    }else if([zjButton.titleLabel.text isEqualToString: @"护照"]){
        Checkstr = @"2";
    }else if([zjButton.titleLabel.text isEqualToString: @"军官证"]){
        Checkstr = @"3";
    }else if([zjButton.titleLabel.text isEqualToString: @"港澳通行证"]){
        Checkstr = @"4";
    } else if([zjButton.titleLabel.text isEqualToString: @"台胞证"]){
        Checkstr = @"5";
    }
    DLog(@"zibutton.text is %@ -----str is %@",zjButton.titleLabel.text,Checkstr);
    if ([namTextFild.text isEqualToString:@""]) {
        [[LXAlterView sharedMyTools] createTishi:@"您还未输入常用游客姓名"];
        return;
//    }else if ([Checkstr isEqualToString:@"请选择"]) {
//        [[LXAlterView sharedMyTools] createTishi:@"您还未选择证件类型"];
//        return;
//    }else if ([zjhTextFild.text isEqualToString:@""]) {
//        [[LXAlterView sharedMyTools] createTishi:@"您还未输入证件号"];
//        return;
//    }else if([Checkstr isEqualToString:@"1"] && [[CheckIDNumber sharedMyTools] validateIDCardNumber:zjhTextFild.text] == false){
//        [[LXAlterView sharedMyTools] createTishi:@"请输入正确的身份证号码"];
//        return;
    }else if (![YXTools isValidateMobile:phoneTextFild.text])
    {
       [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
        return;
    
    }else{
        //shangchuan
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"to_username":namTextFild.text,@"sex":@"",@"id_type":Checkstr,@"id_number":zjhTextFild.text,@"phone":phoneTextFild.text,@"email":@""};
        [manager POST:AddCommonInfoUrl parameters:parameters
     
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                 
                  if([[dict objectForKey:@"status"] integerValue] ==1 ){
                      [[LXAlterView sharedMyTools]createTishi:@"添加成功"];
                      //存本地
                      NSDictionary *dic = [dict objectForKey:@"data"];
                      [cusInfoArray addObject:dic];
                      NSUserDefaults *set=[NSUserDefaults  standardUserDefaults];
                      [set setObject:cusInfoArray forKey:@"custom"];
                      
                      [self getBack];
                  
                  }
                  else
                  {
                      if ([dict objectForKey:@"msg"]!=nil)
                      {
                           [[LXAlterView sharedMyTools]createTishi:[dict objectForKey:@"msg"]];
                      }
                      else
                      {
                          [[LXAlterView sharedMyTools]createTishi:@"添加失败"];
                      }
                  }
                
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  DLog(@"Error: %@", error);
                  
              }];

        
 
    }
    
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *v=[[UIView alloc]
               initWithFrame:CGRectMake(0,0,
                                        [self pickerView:pickerView widthForComponent:component],
                                        [self pickerView:pickerView rowHeightForComponent:component])];
    [v setOpaque:TRUE];
    [v setBackgroundColor:[UIColor clearColor]];
    UILabel *lbl=nil;
    lbl= [[UILabel alloc]
          initWithFrame:CGRectMake(8,0,
                                   [self pickerView:pickerView widthForComponent:component]-16,
                                   [self pickerView:pickerView rowHeightForComponent:component])];
    lbl.textAlignment = NSTextAlignmentCenter;
    [lbl setBackgroundColor:[UIColor clearColor]];
    NSString *ret=@"";
    
    switch (component) {
        case 0:
            ret=[titArray objectAtIndex:row];
            break;
    }
    [lbl setText:ret];
    [lbl setFont:[UIFont boldSystemFontOfSize:18]];
    [v addSubview:lbl];
    return v;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == 0) {
        [zjButton setTitle:@"身份证" forState:UIControlStateNormal];
    }else if(row == 1){
        [zjButton setTitle:@"护照" forState:UIControlStateNormal];
    }else if(row == 2){
        [zjButton setTitle:@"军官证" forState:UIControlStateNormal];
    }else if(row == 3){
        [zjButton setTitle:@"港澳通行证" forState:UIControlStateNormal];
    }else if(row == 4){
        [zjButton setTitle:@"台胞证" forState:UIControlStateNormal];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 200;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 25;
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}

//keyboardmiss
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [namTextFild resignFirstResponder];
    [zjhTextFild resignFirstResponder];
    [phoneTextFild resignFirstResponder];
    pView.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [namTextFild resignFirstResponder];
    [zjhTextFild resignFirstResponder];
    [phoneTextFild resignFirstResponder];
    pView.hidden = YES;
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    pView.hidden = YES;
    return YES;
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
