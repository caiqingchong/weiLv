//
//  changeIDNumViewController.m
//  aa
//
//  Created by mac for csh on 15/4/14.
//  Copyright (c) 2015年 mac for csh. All rights reserved.
//

#import "changeIDNumViewController.h"
#import "LXUserTool.h"
#import "AFNetworking.h"
#import "CheckIDNumber.h"

@interface changeIDNumViewController ()
{
  //  NSString *idtypeString;
}
@end

@implementation changeIDNumViewController
@synthesize zjButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationItem setTitle:@"修改证件"];
    self.view.backgroundColor = BgViewColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    //keyboard hidden
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    UILabel *zjLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, [[UIScreen mainScreen] bounds].size.width, 44)];
    zjLabel.text = @"  证件类型";
    zjLabel.backgroundColor = [UIColor whiteColor];
    zjLabel.textAlignment = NSTextAlignmentLeft;
    zjLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview: zjLabel];
    
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0, 15+44, [[UIScreen mainScreen] bounds].size.width, 0.35)];
    vv.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:vv];
    
    UILabel *zjhLabl = [[UILabel alloc] initWithFrame:CGRectMake(0, 15+45, [[UIScreen mainScreen] bounds].size.width, 45)];
    zjhLabl.text = @"  证件号";
    zjhLabl.backgroundColor = [UIColor whiteColor];
    zjhLabl.textAlignment = NSTextAlignmentLeft;
    zjhLabl.font = [UIFont systemFontOfSize:18];
    [self.view addSubview: zjhLabl];
    
    zjhTextFild = [[UITextField alloc ]initWithFrame:CGRectMake(40+0.19*[[UIScreen mainScreen] bounds].size.width,15+45, [[UIScreen mainScreen] bounds].size.width*0.7-40, 45)];
    zjhTextFild.placeholder = @"";
    if([[LXUserTool alloc] getIdnumber] && ![[[LXUserTool alloc] getIdnumber] isEqual:[NSNull null]]){
        zjhTextFild.text = [[LXUserTool alloc] getIdnumber];
    }
    zjhTextFild.clearButtonMode = UITextFieldViewModeWhileEditing;
    zjhTextFild.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:zjhTextFild];
    zjhTextFild.delegate = self;
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"",@"身份证",@"护照",@"军官证", @"港澳通行证", @"台胞证", nil];
    zjButton = [[UIButton alloc] initWithFrame:CGRectMake(40+0.25*[[UIScreen mainScreen] bounds].size.width, 15, [[UIScreen mainScreen] bounds].size.width*0.75-40, 44)];
    [zjButton setTitle:@"选择证件" forState:UIControlStateNormal];
    if([[LXUserTool alloc] getIdtype] && ![[[LXUserTool alloc] getIdtype] isEqual:[NSNull null]]){
        [zjButton setTitle:[array objectAtIndex:[[[LXUserTool alloc] getIdtype] integerValue]] forState:UIControlStateNormal];
    }
    zjButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [zjButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    zjButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [zjButton addTarget:self action:@selector(chooseCertificate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zjButton];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(zjButton)-40 , 6.65, 40, 26.7)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [zjButton addSubview:IGV];


    
    
//    bgChoiceView = [[UIView alloc] initWithFrame:CGRectMake(40+0.25*[[UIScreen mainScreen] bounds].size.width, 15+40, 170, 30*2)];
//    bgChoiceView.backgroundColor = [UIColor lightGrayColor];
//    bgChoiceView.hidden = YES;
//
    
}


-(void)chooseCertificate{
    
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
        NSLog(@"%@",zjButton.titleLabel.text);
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
    pView.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getBack{
    [self.navigationController popViewControllerAnimated:YES];
}

//保存
-(void)conserve{
    NSString *Checkstr = @"选择证件";
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

    
    
    if([zjButton.titleLabel.text isEqualToString:@"选择证件"]){
         [[LXAlterView sharedMyTools] createTishi:@"请选择证件类型"];
    }else if (!zjhTextFild || zjhTextFild.text == nil|| [zjhTextFild.text isEqualToString:@""]) {
        [[LXAlterView sharedMyTools] createTishi:@"请输入证件号"];
    }else if([zjButton.titleLabel.text isEqualToString:@"身份证"] && [[CheckIDNumber sharedMyTools] validateIDCardNumber:zjhTextFild.text] == false){
         [[LXAlterView sharedMyTools] createTishi:@"请输入正确的身份证号码"];
    }else{
        
    //上传服务器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"idnumber": zjhTextFild.text,@"idtype":Checkstr};
        
        [manager POST:UpdateUserInfo parameters:parameters
         
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  
                    NSLog(@"xxxxxxx = %@",responseObject);
                  NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
                  [settings setObject: Checkstr forKey:@"idtype"];
                  [settings setObject: zjhTextFild.text forKey:@"idnumber"];
                  [[LXAlterView alloc] createTishi:@"修改成功"];
                  [self.navigationController popViewControllerAnimated:YES];
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];
        
        
        /*   NSDictionary *sparameters = @{@"uid":[[LXUserTool alloc] getUid],@"idtype":Checkstr };
         
         [manager POST:UpdateUserInfo parameters:sparameters
         
         success:^(AFHTTPRequestOperation *operation,id responseObject) {
         
         NSLog(@"xxxxxxx = %@",responseObject);
         
         }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
         
         NSLog(@"Error: %@", error);
         
         }];
         
         */
        
       
    
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
  //  NSInteger cx = row +1;
  //  idtypeString = [NSString stringWithFormat:@"%ld",cx];
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [zjhTextFild resignFirstResponder];
    pView.hidden = YES;
    return YES;
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [zjhTextFild resignFirstResponder];
    pView.hidden = YES;
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
