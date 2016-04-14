//
//  ChangeCYTravellerInfoViewController.m
//  WelLv
//
//  Created by 张子乾 on 16/1/29.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "ChangeCYTravellerInfoViewController.h"
#import "LXUserTool.h"
#import "CheckIDNumber.h"
#import "CYYLModel.h"

#import "TravelAllHeader.h"

@interface ChangeCYTravellerInfoViewController ()
{
    NSInteger personLocation;
    NSInteger arrowX;
    NSInteger arrowY;
    NSInteger arrowWidth;
    NSInteger arrowHeight;
}


@end

@implementation ChangeCYTravellerInfoViewController
@synthesize  bgimage,zjButton,cusInfoArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =BgViewColor;
    
    if (UISCREEN_HEIGHT == 667) {
        arrowWidth = 8;
        arrowHeight = 25;
        arrowX = UISCREEN_WIDTH - 25;
        arrowY = 177;
    } else if (UISCREEN_HEIGHT == 568 || UISCREEN_HEIGHT == 480) {
        arrowWidth = 8;
        arrowHeight = 25;
        arrowX = UISCREEN_WIDTH - 25;
        arrowY = 177;
    } else if (UISCREEN_HEIGHT == 736) {
        arrowWidth = 8;
        arrowHeight = 25;
        arrowX = UISCREEN_WIDTH - 35;
        arrowY = 177;
    }
    
    
    //获取需要修改人的位置
    personLocation = [self.tag integerValue];
    //取出来常用游客资料
//    NSDictionary *pensonDic = self.detaillArray[personLocation-1];
    
    
    if (cusInfoArray) {
        [cusInfoArray removeAllObjects];
    }else{
        cusInfoArray=[NSMutableArray array];
    }
    cusInfoArray=[NSMutableArray array];
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    cusInfoArray = [NSMutableArray arrayWithArray:[settings objectForKey:@"custom"]];
    
    
    [self.navigationItem setTitle:@"修改游客资料"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    //    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);// [UIColor colorWithRed:255/255.0 green:165/255.0 blue:98/255.0 alpha:1];
    
    
    bgimage = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, 50*4)];
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
    //    zjLabel.backgroundColor = [UIColor yellowColor];
    zjLabel.textAlignment = NSTextAlignmentLeft;
    zjLabel.font = [UIFont systemFontOfSize:16];
    [bgimage addSubview: zjLabel];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(zjLabel)+ViewHeight(zjLabel)-1, windowContentWidth, 0.3)];
    view3.backgroundColor = [UIColor lightGrayColor];
    [bgimage addSubview:view3];
    
    UILabel *zjhLabl = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(zjLabel), ViewY(zjLabel)+ViewHeight(zjLabel), ViewWidth(zjLabel), 50)];
    zjhLabl.text = @"号码";
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
    //    [self.view addSubview:bzLabel];
    
    UILabel *bzzLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(bzLabel)+ViewWidth(bzLabel), ViewY(zjhLabl)+ViewHeight(zjhLabl)+20, [[UIScreen mainScreen] bounds].size.width-100, 40)];
    bzzLabel.text = @"请填写真实信息,以便为您提供服务";
    bzzLabel.backgroundColor = [UIColor clearColor];
    bzzLabel.textAlignment = NSTextAlignmentLeft;
    bzzLabel.textColor = [UIColor lightGrayColor];
    bzzLabel.font = [UIFont systemFontOfSize:14];
    //    [self.view addSubview:bzzLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(30,ViewY(bzLabel)+ViewHeight(bzLabel), [[UIScreen mainScreen] bounds].size.width-30*2, 40);
    [btn setTitle:@"保    存" forState:UIControlStateNormal];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];//加粗
    [btn setBackgroundColor: kColor(57, 246, 177)];
    [btn addTarget:self action:@selector(conserve) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:btn];
    
    //     NSDictionary *newInfoDic = @{@"to-id":to_idStr,@"t-name":to_username,@"t-tel":phone,@"t-zj":idtype,@"t-zjnum":id_number,@"t-sex":sex};
    
    
#pragma mark --------------------常用联系人赋值---------------------
    
    //填写项初始化
    namTextFild = [[UITextField alloc ]initWithFrame:CGRectMake(ViewX(namLabel)+ViewWidth(namLabel),ViewY(namLabel)+64,windowContentWidth - ViewX(namLabel)*2 , ViewHeight(namLabel))];
    namTextFild.placeholder = @"必填";
    [namTextFild setText:self.travelerInfoModel.to_username];
    namTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    namTextFild.font = [UIFont systemFontOfSize:16];
    namTextFild.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:namTextFild];namTextFild.delegate = self;
    
    zjhTextFild = [[UITextField alloc ]initWithFrame:CGRectMake(ViewX(zjhLabl)+ViewWidth(zjhLabl),ViewY(zjhLabl)+64,windowContentWidth - ViewX(zjhLabl)*2 , ViewHeight(zjhLabl))];
    zjhTextFild.text = self.travelerInfoModel.id_number;
    zjhTextFild.placeholder = @"选填";
    zjhTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    zjhTextFild.font= [UIFont systemFontOfSize:16];;
    zjhTextFild.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:zjhTextFild];zjhTextFild.delegate = self;
    
    phoneTextFild = [[UITextField alloc ]initWithFrame:CGRectMake(ViewX(phoneLabel)+ViewWidth(phoneLabel),ViewY(phoneLabel)+64,windowContentWidth - ViewX(phoneLabel)*2 , ViewHeight(phoneLabel))];
    phoneTextFild.placeholder = @"必填";
    phoneTextFild.text = self.travelerInfoModel.phone;
    phoneTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneTextFild.font= [UIFont systemFontOfSize:16];
    phoneTextFild.textAlignment = NSTextAlignmentLeft;
    phoneTextFild.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:phoneTextFild];phoneTextFild.delegate = self;
    
    //    zjButton = [[UIButton alloc] initWithFrame:CGRectMake(ViewX(zjLabel)+ViewWidth(zjLabel),ViewY(zjLabel)+20,windowContentWidth - ViewX(zjLabel)*2 , ViewHeight(zjLabel))];
    zjButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(zjLabel.frame), ViewY(zjLabel)+64, [UIScreen mainScreen].bounds.size.width-CGRectGetWidth(zjLabel.frame)*2+20, CGRectGetHeight(zjLabel.frame))];
    
    NSString *Checkstr = @"身份证";
    if ([self.travelerInfoModel.id_type isEqualToString: @"1"]) {
        Checkstr = @"身份证";
    }else if([self.travelerInfoModel.id_type isEqualToString: @"2"]){
        Checkstr = @"护照";
    }else if([self.travelerInfoModel.id_type isEqualToString: @"3"]){
        Checkstr = @"军官证";
    }else if([self.travelerInfoModel.id_type isEqualToString: @"4"]){
        Checkstr = @"港澳通行证";
    } else if([self.travelerInfoModel.id_type isEqualToString: @"5"]){
        Checkstr = @"台胞证";
    }
    
    [zjButton setTitle:Checkstr forState:UIControlStateNormal];
    //    zjButton.backgroundColor = [UIColor redColor];
    zjButton.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [zjButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zjButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [zjButton addTarget:self action:@selector(loadPickerView) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:zjButton];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
#pragma mark -----------------箭头-----------------------------
    UIImageView *moreArrow = [[UIImageView alloc]initWithFrame:CGRectMake(arrowX, arrowY, arrowWidth, arrowHeight)];
    
    moreArrow.contentMode = UIViewContentModeScaleAspectFill;
    moreArrow.image = [UIImage imageNamed:@"6-箭头"];
    [self.view addSubview:moreArrow];

}

- (void)loadPickerView{
    if (!pView) {
        titArray = [NSArray arrayWithObjects:@"身份证",@"护照",@"军官证", @"港澳通行证", @"台胞证", nil];
        picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,25, [[UIScreen mainScreen] bounds].size.width, 140)];
        picker.backgroundColor = [UIColor whiteColor];
        picker.delegate = self; picker.dataSource =self;
        pView =  [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight-150, [[UIScreen mainScreen] bounds].size.width, 140+25)];
        pView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:pView];
        [pView addSubview:picker];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake( [[UIScreen mainScreen] bounds].size.width-60,0, 40, 25);
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
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

-(void)setIDType{
    pView.hidden =YES;
}
-(void)getBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//保存
-(void)conserve{
    NSString *Checkstr = @"身份证";
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
    
    BOOL isTeleRight = [self checkTelNumber:phoneTextFild.text];
    
    if ([namTextFild.text isEqualToString:@""]) {
        [[LXAlterView sharedMyTools] createTishi:@"您还未输入常用游客姓名"];
    }else if ([Checkstr isEqualToString:@"请选择"]) {
        [[LXAlterView sharedMyTools] createTishi:@"您还未选择证件类型"];
    }else if ([phoneTextFild.text isEqualToString:@""]) {
        [[LXAlterView sharedMyTools] createTishi:@"您还未输入手机号"];
    }else if([Checkstr isEqualToString:@"1"] && [[CheckIDNumber sharedMyTools] validateIDCardNumber:zjhTextFild.text] == false && zjhTextFild.text.length != 0){
        [[LXAlterView sharedMyTools] createTishi:@"请输入正确的身份证号码"];
    }else if(!isTeleRight){
        
        [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
    }
    
//    else if([phoneTextFild.text isEqualToString:@""]){
//        [[LXAlterView sharedMyTools] createTishi:@"手机号不能为空"];
//    }else if([YXTools isValidateMobile:phoneTextFild.text] == NO){
//        [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号码"];
//    }
    
    else{
        //shangchuan
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        //判断会员类型
        NSString *groupType = nil;
        if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeMember) {
            groupType = @"1";
        } else if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeSteward) {
            groupType = @"2";
        }
        
        
        //证件类型
        NSString *Checkstr = @"身份证";
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
        

        NSString *to_id = self.travelerInfoModel.to_id;
        NSString *idtype = Checkstr;
        NSString *id_number = zjhTextFild.text;
        NSString *phone = phoneTextFild.text;
        NSString *to_username = namTextFild.text;
        NSString *sex = self.travelerInfoModel.sex;
        
        NSDictionary *parameter = @{@"to_id":to_id,@"to_username":to_username,@"phone":phone,@"idtype":idtype,@"id_number":id_number,@"sex":sex};
        
//        NSString *jsonData = [self dictionaryToJson:parameter];
        
        [manager POST:kChangeTravelListInfoUrl parameters:parameter
         
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                  if([[dict objectForKey:@"status"] integerValue] ==1 ){
                      [[LXAlterView sharedMyTools]createTishi:@"修改成功"];
                      
                      [self getBack];
                      
                  }else{
                      [[LXAlterView sharedMyTools]createTishi:[NSString stringWithFormat:@"%@",dict[@"msg"]]];
                  }
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];
    }
}

-(BOOL)checkTelNumber:(NSString *) telNumber
{
    //^1(3[0-9]|4[57]|5[012356789]|8[0-9]|7[0-7])\\d{8}$
    //手机号以13， 15，18开头，八个 \d 数字字符
    //NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[012356789]|8[0-9]|7[0-7])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:telNumber];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

//限制手机号的位数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    self.nextView = (NexttView *)[self.scrollView viewWithTag:501];
    if (textField == phoneTextFild) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
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
