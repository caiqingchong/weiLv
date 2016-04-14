//
//  MaritalStatusViewController.m
//  WelLv
//
//  Created by mac for csh on 15/7/27.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "MaritalStatusViewController.h"

@interface MaritalStatusViewController ()

@end

@implementation MaritalStatusViewController
@synthesize maritalArray,key,uid,keywords;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame=CGRectMake( 0, 10, [[UIScreen mainScreen] bounds].size.width, 40);
    NSString *str = [self judgeReturnString:keywords withReplaceString:@"请选择"];
    [btn1 setTitle:str forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 addTarget:self action:@selector(loadpicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 6.65, 40, 26.7)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [btn1 addSubview:IGV];

}

-(void)loadpicker{
    NSLog(@"marrarray %@",maritalArray);
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 25, [[UIScreen mainScreen] bounds].size.width, 100)];
    picker.backgroundColor = [UIColor whiteColor];
    picker.delegate = self; picker.dataSource =self;
    pView= [[UIView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-130-64, [[UIScreen mainScreen] bounds].size.width, 130)];
    pView.backgroundColor =[UIColor clearColor]; //[UIColor colorWithWhite:1 alpha:1];
    pView.hidden = NO;
    [pView addSubview:picker];
    [self.view addSubview:pView];
    if ([btn1.titleLabel.text isEqualToString:@"未婚"]) {
        [picker selectRow:0 inComponent:0 animated:NO];
    }else if ([btn1.titleLabel.text isEqualToString:@"已婚"]) {
        [picker selectRow:1 inComponent:0 animated:NO];
    }else if ([btn1.titleLabel.text isEqualToString:@"离异"]) {
        [picker selectRow:2 inComponent:0 animated:NO];
    }else if ([btn1.titleLabel.text isEqualToString:@"丧偶"]){
        [picker selectRow:3 inComponent:0 animated:NO];
    }else{
        [btn1 setTitle:@"未婚" forState:UIControlStateNormal];
        [picker selectRow:0 inComponent:0 animated:NO];
    }
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake( 0,0, windowContentWidth, 25)];
    lab.backgroundColor = [UIColor whiteColor];
    [pView addSubview:lab];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake( [[UIScreen mainScreen] bounds].size.width-40,1, 40, 25);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [pView addSubview:btn];
}

-(void)setting{
    pView.hidden = YES;
}

//保存
-(void)conserve{
    
    if(![btn1.titleLabel.text isEqualToString:@"请选择"]){
        //上传服务器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *infoarr = @{key:btn1.titleLabel.text};
        NSDictionary *parameters = @{@"member_id":self.uid,@"data":[self dictionaryToJson:infoarr]};
        [manager POST:GjManagMemberURL parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
                 // NSLog(@"dict = %@  \n msg = %@",dict,[dict objectForKey:@"msg"]);
                  [self.navigationController popViewControllerAnimated:YES];
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];
        
    }else{
        [[LXAlterView alloc] createTishi:@"请选择婚姻状况"];
    }
    
}

//字典数据转Json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
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
            ret=[maritalArray objectAtIndex:row];
            break;
    }
    [lbl setText:ret];
    [lbl setFont:[UIFont boldSystemFontOfSize:18]];
    [v addSubview:lbl];
    return v;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [btn1 setTitle:[maritalArray objectAtIndex:row] forState:UIControlStateNormal];
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
    return maritalArray.count;
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
